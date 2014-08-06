/**
 * grammar-editor.js
 * Author: Russell Hertzberg
 * Date: October 11, 2011
 *
 * This javascript library contains functionality that is relevant to the
 * grammar editor in the GenoCAD system.
 *
 **/

var gGrammarID;
var gCategoryID = -1;
var objGrammar = new Object();
var isEditable = false;
var loading = $('<div style="position: absolute; top: 100px; left: 275px;"><img src="/images/loading.gif" alt="loading"></div>');
var codeInt = 1;



function insertCode(myValue) {
	//jQuery.fn.extend({
	//    insertAtCaret: function(myValue) {
	//        return this.each(function(i) {
				var el = $('#action_code').get(0);
				var pos = 0;
	            if (document.selection) {
	                //For browsers like Internet Explorer
	                //this.focus();
	            	$('#action_code').focus();
	                sel = document.selection.createRange();
	                sel.text = myValue;
	                $('#action_code').focus();
	            }
	            else if ('selectionStart' in el) {
	            	pos = el.selectionStart;
	                //For browsers like Firefox and Webkit based
	                $('#action_code').val($('#action_code').val().substring(0, pos) + myValue + $('#action_code').val().substring(pos+1, $('#action_code').val().length));
	                $('#action_code').focus();
	            } else {
	            	alert($('#action_code').val());
	            	//$('#action_code').value += myValue;
	            	$('#action_code').val($('#action_code').val() + myValue);
	            	$('#action_code').focus();
	            }
	      //  });
	    
	//});
	
	//$('action_code').insertAtCaret('^' + myValue + '^');
}

/**
 * Replaces the HTML attribute of the given jQuery selector with the message
 *  
 * @param selector
 * @param message
 */
function showMessage(selector, message) {
	$(selector).html(message);
	$(selector).show().fadeOut();
}

/**
 * Loads the category jsTree object with the JSON returned by the API call
 * for the grammar being displayed on the page
 */
function loadCategoryTree() {

	var url = "/api/grammar/category-tree/id/" + gGrammarID;

    $("#categorytree")
      .jstree({
        "types" : {
            "valid_children" : [ "root" ],
            "types" : {
                "root" : {
                    "valid_children" : [ "default" ],
                    "hover_node" : false,
                    "select_node" : function() { return false; },
                    "close_node" : true
                }
            }
        },
        "json_data" : {
            "ajax" : { "url" : url }
        },
        "progressive_render" : true,
        "plugins" : [ "themes", "json_data", "ui", "types"]
     })
     .bind("select_node.jstree", function (event, data) {
         selectCategory(data.rslt.obj.attr("id"));
     });
     
    
     $("#categorytree").jstree("set_theme","classic");

}

function refreshCategoryTree() {
	var node = "#" + gCategoryID;
	$.jstree._reference("#categorytree").refresh();
}

/**************************************************************************************
 * Retrieves the selected Grammar from the database, clears the design and 
 * populates the library select list.  If there is only one available library, 
 * it will be selected and the category parts will be retrieved.
 * 
 */
function getGrammar(id) {

	var grammar_id = id;
	var sUrl = "/api/grammar/grammar/id/" + grammar_id;

	$.ajax({
	    type: 'GET',
	    url: sUrl,
	    dataType: 'json',
	    success: function(data) {
			objGrammar = data.grammar;
			redrawAvailableCategories();
			$("td#grammar-name").html(objGrammar.name);
			$("td#grammar-description").html(objGrammar.description);
			$("td#grammar-starting-category").html(objGrammar.categories[objGrammar.starting_category_id].label);
			$("td#grammar-icon-set").html(objGrammar.icon_set);
			if (gCategoryID != -1)
				selectCategory(gCategoryID);
		    stopLoading();
		},
		async: true
	});

}

function drawRuleCategory(objCategory) {

	var element = $('<div class="element"/>');
	var detail = $('<div class="detail" />');
	var icon = $('<img width="24" class="elementIcon tooltip">');
	icon.attr('src', objCategory.image_url);
	icon.attr('title',objCategory.description);
	detail.append(icon);
	
	return (element.append(detail));

}

function drawRule(objRule) {

	var row = $('<tr class="rule">');
	var code = $('<td>' + objRule.code + '</td>');
	var rule = $('<td>');
	var is_attribute = $("#grammar-wrapper #is_attribute").val();

	if (gIsEditable) {
		var edit = $('<td align="center" valign="center"><img src="/images/edit.png" class="img-edit" id="' + objRule.rule_id + '"></td>');
		if (is_attribute == 1) {
			var semantic = $('<td align="center" valign="center"><img src="/images/code.png" class="img-semantic" id="' + objRule.rule_id + '"></td>');
		} else {
			var semantic = "";
		}
		var del = $('<td align="center"><img src="/images/delete.gif" class="img-delete" id="' + objRule.rule_id + '"></td>');
	} else {
		var edit = $('<td align="center"></td>');
		if (is_attribute == 1) {
			var semantic = $('<td align="center"></td>');
		} else {
			var semantic = "";
		}
		var del = $('<td align="center"></td>');
	}

	rule.append(drawRuleCategory(objGrammar.categories[objRule.category_id]));
	rule.append('<div class="element"><div class="detail"><img vspace="21" src="/images/other/right-arrow.png" style="padding-top: 5px;"></div></div>');

	if (objRule.transform != null) {
		$.each(objRule.transform, function (t) {
			rule.append(drawRuleCategory(objGrammar.categories[objRule.transform[t].category_id]));
		});
	}

	return(row.append(code).append(rule).append(edit).append(semantic).append(del));
}

/**
 * showCategoryRules
 * 
 * 
 * @params category_id
 * 
 */
function showCategoryRules(category_id) {

	// remove existing child and parent rules 
    $("#child-rules tr.rule, #parent-rules tr.rule").remove();
    $("#child-rules tr.no-rules, #parent-rules tr.no-rules").hide();

    // display the child rules for the selected category
    $.each(objGrammar.categories[category_id].rules, function (r) {

		var rule_id = objGrammar.categories[category_id].rules[r].rule_id;
		var objRule = objGrammar.rules[rule_id];

		$('#child-rules').append(drawRule(objRule));

	});

    // display the parent rules for the selected category
	$.each(objGrammar.categories[category_id].references, function (r) {

		var rule_id = objGrammar.categories[category_id].references[r].rule_id;
		var objRule = objGrammar.rules[rule_id];

		$('#parent-rules').append(drawRule(objRule));

	});


    // display the "no rules" message if there are no child and/or parent rules
    // for the selected category
    if ($("#child-rules tr.rule").length == 0) {
        $("#child-rules tr.no-rules").show();
    }
    if ($("#parent-rules tr.rule").length == 0) {
        $("#parent-rules tr.no-rules").show();
    }    
}

/**
 * When a category is selected on the Grammar jsTree, this function is called.
 * This function displays the selected category detail and shows the associated rules.
 * @param id
 */
function selectCategory(id) {

	//Not sure why Russell was setting this to null, but it messed up adding a textarea
	//$("td.category-data").html("");
	gCategoryID = id;
	
	
	var category = objGrammar.categories[id];
	
	$("#category_letter").html(category.letter);
	
	$("#category_description").html(category.description);
	$('textarea#cat_desc_text').val(category.description_text);
	
	//$("#category_description_text").html(category.description_text);
		
	$("#category_genbank").html(category.genbank_label);
    $("#category_icon").html('<img style="padding-right: 10px;" align="absmiddle" width="24" src="' + category.image_url + '"/> ' + category.icon_name);

    if (gIsEditable) {
    	$('#edit-detail').button('enable');
    	$('#edit-detail').unbind('click');
    	$('#edit-detail').click(function(){ editCategory(id); });
    	
    	$('#attributes').button('enable');
    	$('#attributes').unbind('click');
    	$('#attributes').click(function(){ editAttributes(id); });

    	if (category.isDeletable == "false" || category.rules.length > 0 || category.references.length > 0) {
    		$('#delete-category').button('disable');
    	} else {
    		$('#delete-category').button('enable').unbind('click').click(function(){ deleteCategory(id); });
    	}
    	
    	
    } else {
    	$('#edit-detail, #delete-category, #attributes').button('disable');
    	$('#edit-detail, #delete-category, #attributes').unbind('click');
    }

    showCategoryRules(id);

}

/** 
 * 
 * @param id
 */
function initSemantic(id) {
	var url = "/grammar/index/edit-semantic/rule_id/" + id;
	
	$('#dialog-grammar')
	.html('')
	.append($("#loading").clone())
	.load(url)
	.dialog({
		width: 700,
		height: 400,
		title: "Add / Edit Semantic Action",
		modal: true,
		resizable: false,
		close: function() {$('#dialog').dialog('destroy');},
		buttons: {
			"Save": function() {
				saveSemantic(url);
				$("#dialog-grammar").dialog('close');
            	reloadPage();
				},
			"Cancel": function() {
				$(this).dialog("close");
			}
		}  
	});
	
}

/**
 * 
 * @param url
 */
function saveSemantic(url) {
	disableDialogButtons();
	var formdata = $("#form_semantic").serialize();
	
	
	$.ajax( {
		type: "POST",
		url : url,
		data : formdata,
		success : function(response) {
	        if (typeof(response) === "object") {
	        	
	        } else {
	            // It's a html snippet
	            $("#dialog-grammar.ui-dialog-content").html(response);
	            $("#image_set_browse").button();
	            enableDialogButtons();
	        } 
		}
	});

	return;
}

/**
 *  
 * @param id
 */
function initRules(id) {

	$("#category-start, #category-transform").html('');
	$('input#rule_code').val('');
	$('input#rule_id').val(id);

	if (id != 0) {

		var rule = objGrammar.rules[id];
		$('input#category_id').val(rule.category_id);
		$("#category-start").sortable("disable");

		$('#category-available .cat-' + rule.category_id).clone().appendTo('#category-start');

		if (objGrammar.rules[id].transform) {
			$.each(objGrammar.rules[id].transform, function(key, val) {
				$('#category-available .cat-' + val.category_id).clone().appendTo('#category-transform');
			});
		}
		dropCategory();
		$('#edit-rule input[name="code"]').val(rule.code);

	} else {
		if (gCategoryID != "") {
			$('input#category_id').val(gCategoryID);
			$("#category-start").sortable("disable");
			$('#category-available .cat-' + gCategoryID).clone().appendTo('#category-start');
			dropCategory();
		} else {
			$("#category-start").sortable("enable");
		}
	}

	$("#category-available div").draggable( {
		connectToSortable : ".category-sortable",
		helper : "clone",
		revert : "invalid",
		containment : "#rule-editor",
		cursor : "move",
		stop : function(event, ui) {
			dropCategory();
		}
	});

	$("#category-start").droppable( {
		drop : function(event, ui) {
			$(this).sortable("disable");
			dropCategory();
		}
	});

	$("#category-start, .category-sortable").sortable( {
		containment : "#category-transform",
		axis : "y",
		cursor : "move"
	});

	$('#rule-editor').dialog( {
		width : 800,
		minHeight : 500,
		title : "Add / Edit Rule",
		modal : true,
		resizable : false,
		close : function() {
			$('#dialog').dialog('destroy');
		},
		buttons : {
			"Save" : function() {saveRule(); },
			"Close" : function() {
				$(this).dialog("close");
			}
		}
	});

}

function dropCategory() {
	$("div.removable").find("img.cancel-rule").show();
	$(".cancel-rule").unbind('click');
	$(".cancel-rule").click(function() { removeCategory($(this).closest("div")); });
}

function removeCategory(element) {
	$(element).fadeOut("normal", function () {
		  $(element).remove();
	});

	if ($(element).parent('div').attr('id') == 'category-start') {
		$("#category-start").sortable("enable");
		$("#category-start").addClass("category-sortable");
	}
}

function redrawAvailableCategories() {

	$("div#category-available").html("");

    $.each(objGrammar.categories, function (c) {
    	var cat = objGrammar.categories[c];
    	var category = $('<div class="ui-state-default cat-' + cat.category_id + '" id="' + cat.category_id + '"/>');
    	var icon = $('<img class="category-icon" src="' + cat.image_url + '" class="elementIcon tooltip"/>');
    	category.append(icon);
    	category.append(cat.label);
    	category.append($('<span style="float: right"><img class="cancel-rule" src="/images/cancel.png" style="display: none;" /></span>'));

    	$("div#category-available").append(category);
    });
}

function deleteRule(id) {
	var url = '/api/rules/delete/rule_id/' + id;

	if (confirm('Are you sure you want to delete this rule?')) {
		$.ajax({
		    type: 'GET',
		    url: url,
		    dataType: 'json',
		    success: function(data) {
				showMessage('#msg-rules', 'The rule has been removed.');
				reloadPage();
			},
		    async: false
		});
	}
}

function saveRule() {

	var url = "/grammar/index/edit-rule/";
	var missing_fields = new Array();
	disableDialogButtons();
	if ($("#category-start").hasClass("category-sortable")) {
		$("#edit-rule input[name='category_id']").val($('#category-start').sortable("toArray"));
	}
	$("#edit-rule input[name='transform']").val($('#category-transform').sortable("toArray"));


	// need to validate the rule and make sure everything is filled out
	if ($("#edit-rule input[name='code']").val() == "") {
		missing_fields.push("Rule Code");
	}
	if ($("#edit-rule input[name='category_id']").val() == "") {
		missing_fields.push("Transfer From Category");
	}
	//if ($("#edit-rule input[name='transform']").val() == "") {
	//	missing_fields.push("Transfer To Categories");
	//}
	
	if (missing_fields.length == 0) {

		$.ajax( {
			type: "POST",
			url : url,
			data: $("#edit-rule").serialize(),
			success : function(response) {
				showMessage('#msg-rules', response.message);
				$('#rule-editor').dialog("close");
				reloadPage();
				showCategoryRules(gCategoryID);
			}
		});

	} else {
		var msg = "The following fields are missing: \n\n";
		$.each(missing_fields, function(i) {
			msg += "   " + missing_fields[i] + "\n";
		});
		enableDialogButtons();
		alert(msg);
		
	}
}

function editGrammar(grammar_id) {
	
    $('#dialog-grammar')
        .html('')
        .append($("#loading").clone())
        .load('/grammar/index/edit-grammar/id/' + grammar_id, function () {
            $("#image_set_browse").button();
            $("#grammar-tabs").tabs();
            $("#ctbg-accordion").accordion({ autoHeight: false, collapsible: true });
         })
        .dialog({
            width: 575,
            height: 500,
            title: "Edit Grammar",
            modal: true,
            resizable: true,
            close: function() {$('#dialog').dialog('destroy'); },
            buttons: {
            	"Convert": function() {
            		convertGrammar(grammar_id);
            		reloadPage();
            		$(this).dialog('close');
					
            	},
                "Save": function() {
			        saveGrammar('/grammar/index/edit-grammar/id/' + grammar_id);
			        $("#dialog-grammar").dialog('close');
					reloadPage();
            	},
            	"Cancel": function() {
            	    $(this).dialog("close");
                }
            }  
        });
}

function exportGrammar(grammar_id) {
	
    $('#dialog-grammar')
        .html('')
        .append($("#loading").clone())
        .load('/grammar/index/export/id/' + grammar_id, function () {
         })
        .dialog({
            width: 575,
            height: 325,
            title: "Export Grammar",
            modal: true,
            resizable: true,
            close: function() {$('#dialog').dialog('destroy'); },
            buttons: {
            	"Export": function() {
            		doExport('/grammar/index/export/id/' + grammar_id);
			        //$("#export").submit();
			        //$("#dialog-grammar").dialog('close');
					//reloadPage();
            	},
            	"Cancel": function() {
            	    $(this).dialog("close");
                }
            }  
        });
}

function convertGrammar(grammar_id) {
	var msg;
	
	var is_attribute = $("#form_grammar #is_attribute").val();
	
	if (is_attribute == 1) {
		msg = "Are you sure you want to convert this attribute grammar to a non-attribute grammar?  All attributes, rule semantic actions, and parts attribute values will be cleared and it will not be possible to restore them.  Proceed?";
	} else {
		msg = "Convert this non-attribute grammar to an attribute grammar?";
	}
	
	if (confirm(msg)) {
		var url = '/grammar/index/convert-grammar/id/' + grammar_id;
		disableDialogButtons();
		$.ajax( {
			type: "POST",
			url : url,
			success : function(response) {
				if (typeof(response) === "object") {
					//enableDialogButtons();
					//reloadPage();
				} else {
					// It's a html snippet
					$("#image_set_browse").button();
					enableDialogButtons();
	        } 
		}
	});
	}
	return;
	
} 

function saveGrammar(url) {
	disableDialogButtons();
	var formdata = $("#form_grammar").serialize()+"&"+$("#grammar-attributes").serialize();
	$.ajax( {
		type: "POST",
		url : url,
		data : formdata,
		success : function(response) {
	        if (typeof(response) === "object") {
	        	//enableDialogButtons();
	        } else {
	            // It's a html snippet
	            $("#dialog-grammar.ui-dialog-content").html(response);
	            $("#image_set_browse").button();
	            enableDialogButtons();
	        } 
		}
	});

	return;
}

function doExport(url) {
	//disableDialogButtons();
	var formdata = $("#form_grammar").serialize();
	$.ajax( {
		type: "POST",
		url : url,
		data : formdata,
		success : function(response) {
	        if (typeof(response) === "object") {
	        	enableDialogButtons();
	        } else {
	            // It's a html snippet
	            $("#dialog-grammar.ui-dialog-content").html(response);
	            enableDialogButtons();
	        } 
		}
	});

	return;
}

function saveCodeTbgenerated(url) {
	disableDialogButtons();
	var formdata = $("#form_code").serialize();
	$.ajax( {
		type: "POST",
		url : url,
		data : formdata,
		success : function(response) {
	        if (typeof(response) === "object") {
	        	
	        } else {
	            // It's a html snippet
	            $("#dialog-grammar.ui-dialog-content").html(response);
	            $("#image_set_browse").button();
	            enableDialogButtons();
	        } 
		}
	});

	return;
}

function deleteGrammar(id) {

	var url = '/api/grammar/delete/id/' + id;
	
	var has_libraries = $("#grammar-wrapper #has_libraries").val();

	if (confirm('Are you sure you want to delete this grammar?')) {
		if (has_libraries > 0) {
			if (!(confirm('This grammar has libraries, parts, and/or designs associated with it which will also be deleted if this grammar is deleted.  Proceed?'))) {
				return;
			}
		}
		
		startLoading(); 
		$.ajax( {
			type: "POST",
			url : url,
			success : function(response) {
				alert(response.message);
				if (response.success == 1) {
					location.href = '/parts';
				}
			},
			failure : function(response) {
				alert(response);
			}
		});			
	}
}

function editCategory(categoryId) {

	var url = '/grammar/index/edit-category/';

	if (categoryId == -1) {
		url += 'grammar_id/' + gGrammarID;
	} else {
		url += 'id/' + categoryId;
	}

    $('#dialog-category')
        .html('')
        .append($("#loading").clone())
        .load(url, function() {
            $("#form_category #icon_name").find('option').each(function() {
            	if ($(this).val() != '')
            		$(this).attr('title', objGrammar.icon_set_url + "/" + $(this).val());
            });
            $("#form_category #icon_name").msDropDown();})
        .dialog({
            width: 500,
            height: 350,
            title: "Edit Category",
            modal: true,
            resizable: false,
            close: function() {$('#dialog').dialog('destroy');},
            buttons: {
                "Save": function() {
                    saveCategory();
                },
                "Cancel": function() {
                    $(this).dialog("close");
                }
            }  
        });
}



function saveCategory() {

	var url = '/grammar/index/edit-category/';
	disableDialogButtons();
	$('#dialog-category').append($("#loading").clone());
	$.ajax({
        type: "POST",
        url: url,
        data: $("#form_category").serialize(),
        success: function(response) {
            if (typeof(response) === "object") {
            	$("#dialog-category").dialog('close');
            	gCategoryID = response.data.category_id;
            	showMessage('#msg-category', response.message);
            	reloadPage();
            } else {
                // It's a html snippet
                $("#dialog-category.ui-dialog-content").html(response);
                $("#form_category #icon_name").msDropDown();
                enableDialogButtons();
            } 
        }
  });
  return;
}

function deleteCategory(id) {

	var url = '/api/category/delete/category_id/' + id;

	if (confirm('Are you sure you want to delete this Category?')) {
		startLoading(); 
		$.ajax({
			type: "POST",
		    url: url,
		    success: function(data) {
				showMessage('#msg-category', data.message);
				reloadPage();
				selectCategory(-1);
			}
		});
	}
}

function removeCodeTbgenerated(code) {
	if (confirm('Are you sure you want to delete this Code to be Generated unit?')) {
		var element = document.getElementById("ctbg_"+code); 
		element.parentNode.removeChild(element); 
		
		element = document.getElementById("h3_"+code);
		element.parentNode.removeChild(element);
		
		alert("This deletion will not take effect until the form is saved.");
	}
}

//function addCodeTbgenerated() {
	//$("#ctbg-accordion").append('<h3 id="h3_'+codeInt+'"><a href="#">Code to be Generated: New</a></h3><div id="ctbg_'+codeInt+'"><table cellpadding="3" cellspacing="2">'+
	//		'<tr><td><label for="type'+codeInt+'">type</label><input type="text" id="type'+codeInt+'" belongs_to="code_tbgenerated" /></td></tr>'+
	//		'<tr><td><label for="code'+codeInt+'">code</label><textarea id="code'+codeInt+'" rows="8" cols="75" belongs_to="code_tbgenerated"></textarea></td></tr>'+
	//		'</table></div>');
//	var newdiv = document.createElement('div');
//	var form=document.getElementById("grammar-attributes"); 
	
//    newdiv.innerHTML = '<h3 id="h3_'+codeInt+'"><a href="#">Code to be Generated: New</a></h3><div id="ctbg_'+codeInt+'"><table cellpadding="3" cellspacing="2">'+
//			'<tr><td><label for="type'+codeInt+'">type</label><input type="text" id="type'+codeInt+'" /></td></tr>'+
//			'<tr><td><label for="code'+codeInt+'">code</label><textarea id="code'+codeInt+'" rows="8" cols="75"></textarea></td></tr>'+
//			'</table></div>';
//    document.getElementById("ctbg-accordion").appendChild(newdiv);
//    counter++;

//	alert("Current codeInt = "+codeInt);
//	codeInt = codeInt + 1;	
//}

function addCodeTbgenerated(grammar_id) {
	var url = '/grammar/index/add-code/';

	url += 'grammar_id/' + grammar_id;
	
	if (confirm("Adding new code will cause the Edit Grammar page to be closed.  Save changes and proceed?")) {
		saveGrammar('/grammar/index/edit-grammar/id/' + grammar_id);
		$('#dialog-grammar')
        	.html('')
        	.append($("#loading").clone())
        	.load(url)
        	.dialog({
        		width: 500,
        		height: 300,
        		title: "Add Code to Be Generated",
        		modal: true,
        		resizable: false,
        		close: function() {$('#dialog').dialog('destroy');},
        		buttons: {
        			"Save": function() {
        				saveCodeTbgenerated(url);
        				$(this).dialog("close");
        				reloadPage();
        			},
        			"Cancel": function() {
        				$(this).dialog("close");
        				editGrammar(grammar_id);
        			}
        		}  
        	});
	}
}

function editAttributes(categoryId) {

	var url = '/grammar/index/edit-attributes/';

	if (categoryId == -1) {
		url += 'grammar_id/' + gGrammarID;
	} else {
		url += 'id/' + categoryId;
	}

    $('#dialog-attributes')
        .html('')
        .append($("#loading").clone())
        .load(url, function() {
            })
        .dialog({
            width: 500,
            height: 300,
            title: "Edit Category Attributes",
            modal: true,
            resizable: false,
            close: function() {$('#dialog').dialog('destroy');},
            buttons: {
            	"Add": function() {
            		$("#dialog-attributes").dialog('close');
                    addCategoryAttribute(categoryId);
                },
                "Edit": function() {
                	if (editCategoryAttribute(categoryId)) {
                		$("#dialog-attributes").dialog('close');
                	}	
                },
                "Delete": function() {
                	if (deleteCategoryAttribute(categoryId)) {
                		$("#dialog-attributes").dialog('close');
                	}
                },
                "Done": function() {
                    $(this).dialog("close");
                }
            }  
        });
}

function addCategoryAttribute(categoryId) {
	var url = '/grammar/index/edit-attribute/';

	if (categoryId == -1) {
		url += 'grammar_id/' + gGrammarID;
	} else {
		url += 'category_id/' + categoryId;
	}
	
	$('#dialog-attribute')
        .html('')
        .append($("#loading").clone())
        .load(url, function() {
        		$('#selected_categories').multiselect2side({moveOptions: false, labelsx: "", labeldx: ""});
        		$("#selected_categories p.RemoveOne").click(function() {});
        		$("button").button();
            })
        .dialog({
            width: 700,
            height: 400,
            title: "Add Category Attribute",
            modal: true,
            resizable: false,
            close: function() {$('#dialog').dialog('destroy');},
            buttons: {
            	"Save": function() {
                	saveCategoryAttribute(categoryId);
                },
                "Cancel": function() {
                    $(this).dialog("close");
                    editAttributes(categoryId);
                }
            }  
        });
}

function editCategoryAttribute(categoryId) {
	var url = '/grammar/index/edit-attribute/';
	
	var attribute_id = $('#category_attributes').val();
	
	if (attribute_id == null) {
		alert("No attribute has been selected for editing.");
		return(false);
	} else {
		url += 'id/' + attribute_id;
		$('#dialog-attribute')
        .html('')
        .append($("#loading").clone())
        .load(url, function() {
        		$("#selected_categories").multiselect2side({moveOptions: false, labelsx: "", labeldx: ""});
        		$("button").button();
            })
        .dialog({
            width: 700,
            height: 400,
            title: "Edit Category Attribute",
            modal: true,
            resizable: false,
            close: function() {$('#dialog').dialog('destroy');},
            buttons: {
            	"Save": function() {
                	saveCategoryAttribute(categoryId);
                },
                "Cancel": function() {
                    $(this).dialog("close");
                    editAttributes(categoryId);
                }
            }  
        });
		return(true);
	}
}

function saveCategoryAttribute(categoryId) {

	var url = '/grammar/index/edit-attribute/';
	disableDialogButtons();
	$('#dialog-attribute').append($("#loading").clone());
	$.ajax({
        type: "POST",
        url: url,
        data: $("#form_attribute").serialize(),
        success: function(response) {
            if (typeof(response) === "object") {
            	$("#dialog-attribute").dialog('close');
            	enableDialogButtons();
            	editAttributes(categoryId);
            } else {
                // It's a html snippet
                $("#dialog-attribute.ui-dialog-content").html(response);
                enableDialogButtons();
            } 
        }
  });
  return;
}

function deleteCategoryAttribute(categoryId) {
	var attribute_id = $('#category_attributes').val();
	var url = '/api/attribute/delete/id/' + attribute_id;
	var attribute_text = $('#category_attributes option:selected').text();
	
	if (attribute_id == null) {
		alert("No attribute has been selected for deletion.");
		return(false);
	} else {
		if (confirm('Are you sure you want to delete attribute '+attribute_text+' and all of its associated part values?')) {
			$.ajax({
				type: "POST",
				url: url,
				success: function(data) {
					$("#dialog-attributes").dialog('close');
					enableDialogButtons();
					editAttributes(categoryId);
					return(true);
				}
			});
		} else {
			return(false);
		}	
	}
}

function showImageSet(imageSet) {
	$(".div-icons").hide();
	$("#" + imageSet).fadeIn();
}

function loadImageBrowser(selector, imageSet) {

	$("#image-browser")
	    .html("")
        .load('/grammar/index/images/', 
        	  function () {
                   $("#browse-icon-set").change(function() {showImageSet($(this).val())});
               	   $("#browse-icon-set").val(imageSet);
               	   showImageSet($("#browse-icon-set").val());
         })
        .dialog({
        	width: 600,
        	height: 400,
        	title: "Browse Images",
        	modal: true,
        	resizable: false,
        	close: function() {$('#dialog').dialog('destroy'); },
        	buttons: {"Select": function() {
									$("#form_grammar #icon_set").val($("#browse-icon-set").val());
									$(this).dialog("close");
        	 					},
        	 		  "Close": function() {
        	 						$(this).dialog("close");
        	 					}
	             	 }  
         });

}

function parseGrammar() {

  $('#div-parser')
      .dialog({
        width: 800,
        height: 475,
        title: "Test Grammar",
        modal: true,
        resizable: false,
        close: function() {$('#dialog').dialog('destroy'); },
        buttons: {"Start Over": function() {
        	startParser();
        },
        "Done": function() {
                       $(this).dialog("close");
                  }
                 }  
       });
  startParser();
}

function disenableEditButtons() {

	if (!gIsEditable) {
        $("#edit-detail").button("disable");
        $("#attributes").button("disable");
        $("#delete-category").button("disable");
        $("#btn-add-rule").button("disable");
        $("#new-category").button("disable");
        $("#edit-grammar").button("disable");
        $("#delete-grammar").button("disable");
        $("#attributeCode").button("disable");
	}
	
	if (!gIsDeletable) {
		$("#delete-grammar").button("disable");
	}
}

function reloadPage() {
	startLoading();
	refreshCategoryTree();
	getGrammar(objGrammar.grammar_id);
}

function startLoading() {

	$('#loading')
	    .dialog({
	      width: 150,
	      height: 30,
	      modal: true,
	      resizable: false,
	      dialogClass: 'dialogLoading'
	     });

}

function stopLoading() {
	$('#loading').dialog("close");
}

function initGrammarEditor() {

	startLoading();

	$('select#grammar-list')
         .selectmenu({"width" : "250px"})
         .change(function() {startLoading(); location.href = "/grammar/index/index/id/" + $(this).val(); });

    $("#edit-grammar").click(function() { editGrammar(gGrammarID); });
    $("#delete-grammar").click(function() { deleteGrammar(gGrammarID); });
    $("#new-category").click(function() { editCategory(-1); });
    $("#btn-add-rule").click(function() { initRules(0); });
    $("#attributeCode").click(function() { alert("Got this far!"); });

    $("#edit-detail").button("disable");
    $("#delete-category").button("disable");
    $("#attributes").button("disable");

    $("#btn-parse-grammar").click(parseGrammar);

    $("#open_all").click(function () {
        $("#categorytree").jstree("open_all");
    });

    $("#close_all").click(function () {
        $("#categorytree").jstree("close_all");
    });

    $('.img-edit').live("click", function () {
        initRules($(this).attr('id')); 
    });
    
    $('.img-semantic').live("click", function () {
        initSemantic($(this).attr('id')); 
    });

    $('.img-delete').live("click", function () {
        deleteRule($(this).attr('id')); 
    });

    $("#image_set_browse").live("click", function(e) {
         e.preventDefault();
         loadImageBrowser("#image_set_browse", $("#form_grammar #icon_set").val());
     });

    disenableEditButtons();

    loadCategoryTree();
    getGrammar(gGrammarID);

}