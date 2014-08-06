/*
 * File:        parts_browser.js
 * Author:      Russell Hertzberg
 * Created:     07/17/2010
 * Description: Javascript source file to deal with the various components
 *              and widgets that are used in the GenoCAD Parts Browser.
 *
 */

var oPublicDT;
var oMylibDT;
var oMyPartsDT;
var oPlistDT;

var sBaseUrl;
var sGrammarTreeUrl = "/api/parts/grammar-tree";
var sMyLibraryTreeUrl = "/api/parts/library-tree/";
var sMyPartsTreeUrl = "/api/parts/mypartstree/";
var sMyCartTreeUrl = "/api/partslist/tree/";
var sMyLibrariesUrl = "/api/library/mylibraries/format/json/gid/";

var gGrammarId;

/*
 * Function:    initDataTable
 * Parameters:  elementID
 * 
 * This 
 */
function initDataTable(elementID) {

	return ($(elementID).dataTable( {
		"fnDrawCallback": function ( oSettings ) {
			if ( oSettings.aiDisplay.length == 0 ) {
				return;
			}
			var nTrs = $(elementID + ' tbody tr');
			var iColspan = nTrs[0].getElementsByTagName('td').length;
			var sLastGroup = "";
			for ( var i=0 ; i<nTrs.length ; i++ )
			{
				var iDisplayIndex = i; //oSettings._iDisplayStart + i;
				var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[1];

				if ( sGroup != sLastGroup )
				{
					var nGroup = document.createElement( 'tr' );
					var nCell = document.createElement( 'td' );
					nCell.colSpan = iColspan;
					nCell.className = "catgroup ui-widget-header ui-state-default";
					nCell.innerHTML = sGroup;
					nGroup.appendChild( nCell );
					nTrs[i].parentNode.insertBefore( nGroup, nTrs[i] );
					sLastGroup = sGroup;
				}
			}
			$('table' + elementID + ' .ui-icon-comment').tipTip({delay: 0});
	        $('.part-detail').click(function(e) {
	            e.preventDefault();
	            showPartDetail(this.id, false);
	        });
	        $('.part-edit').click(function(e) {
	            e.preventDefault();
	            showPartDetail(this.id, true);
	        });
		},

		"aLengthMenu": [[25, 50, 100, 100000], [25, 50, 100, "All"]],
        "iDisplayLength": 25, 
        "bJQueryUI": true,   
        "bProcessing": true, 
        "bServerSide": true, 
        "sAjaxSource": sBaseUrl, 
        "bAutoWidth": false,
		"sPaginationType": "full_numbers",
		"oLanguage": {
		    "sSearch": "Filter records:",
		    "sEmptyTable": "Please choose a Library or Category on the left.", 
		    "sZeroRecords": "No records to display",
		    "oPaginate" : { "sPrevious" : "Prev" }
		},
		"aoColumns": [
		   	       { "sTitle" : "<input type=\"checkbox\" class=\"check-all\" />", "sWidth" : "25px", "bSortable": false, "sClass" : "center" },
		   	       { "sTitle" : "Cat", "bVisible" : false},
		   	       { "sTitle" : "Part ID", "sWidth": "100px"},
		   	       { "sTitle" : "Part Name"},
		   	       { "sTitle" : "Modified", "sWidth": "65px", "sClass" : "center" },
		   	       { "sTitle" : "Long Desc", "bVisible" : false},
		   	       { "sTitle" : "", "sWidth" : "18px", "bSortable": false, "sClass" : "center" }
		   	    ],
		"aaSortingFixed": [[ 1, "asc"]], 
		"aaSorting": [[ 2, "asc" ]] 
		}

	 ));

}

function partChangeGrammar(grammar_id) {

    $('option', '#category_idms2side__dx').remove();
    $('option', '#category_idms2side__sx').remove();
    $('option', '#library_id').remove();

    $.getJSON(sMyLibrariesUrl + grammar_id, function(data) {
        var select = $('#library_id');
        $(select)
	    	.find('option')
	    	.remove();

	    $.each(data.libraries, function(k) {
	    	$(select).append('<option value="' + data.libraries[k].library_id + '">' + data.libraries[k].name + '</option>');
	    });

    });

    $.getJSON("/api/grammar/categories/grammar/" + grammar_id, function(data) {
        var select = $('#category_idms2side__sx');
        $(select)
	    	.find('option')
	    	.remove();
	
	    $.each(data.categories, function(k) {
	    	$(select).append('<option value="' + data.categories[k].category_id + '">' + data.categories[k].label + '</option>');
	    });

    });

}

function populateLibraryList(gID) {

	gGrammarId = gID;

    $.getJSON(sMyLibrariesUrl + gID, function(data) {
        var select = $('#selectLibrary');

        $(select)
	    	.find('option')
	    	.remove()
	    	.end()
	    	.append('<option value="-1"> - Select Library - </option>');

	    $.each(data.libraries, function(k) {
	    	$(select).append('<option value="' + data.libraries[k].library_id + '">' + data.libraries[k].name + '</option>');
	    });

	    $(select).selectmenu();
    });

}

/*
 * Function: loadPublicParts
 * 
 *  
 */
function loadPublicParts(id) {

	var libID, catID;

	if (id.indexOf('/') === -1) {
	   libID = id;
	} else {
	   libID = id.substr(0, id.indexOf('/'));
	   catID = id.substr(id.indexOf('/') + 1);
	}

	var sourceUrl = sBaseUrl + "/libid/" + libID;

	if (typeof(catID) != "undefined") {
		sourceUrl = sourceUrl + "/catid/" + catID;
	}

	oPublicDT.fnReloadAjax(sourceUrl);

}

function disenableLibraryActionButtons(user_id) {
	if (user_id == 0) {
		$("div#library-actions").hide();
	} else {
		$("div#library-actions").show();
	}
}
/*
 * Function: loadLibraryParts
 * 
 *  
 */
function loadLibraryParts(id) {

	var libID, catID;

	if (id == "recycle") {
		sourceUrl = sBaseUrl + '/type/-1';
		$("#actions-orphaned").show();
		$("#div-libraries").hide();
	} else {
		if (id.indexOf('/') === -1) {
			libID = id;
		} else {
			libID = id.substr(0, id.indexOf('/'));
			catID = id.substr(id.indexOf('/') + 1);
		}

		var sourceUrl = sBaseUrl + "/libid/" + libID;

		if (typeof(catID) != "undefined") {
			sourceUrl = sourceUrl + "/catid/" + catID;
		}


		$.getJSON('/api/library/detail/format/json/id/' + libID, function(data) {
			  $('td#lib_name').html(data.library.name);
			  $('td#lib_descr').html(data.library.description);
			  if (bAuthenticated) {
				  $("#btn_library_copy").button("enable");
			  } else {
				  $("#btn_library_copy").button("disable");
			  }	  
			  disenableLibraryActionButtons(data.library.user_id);
		});

		gLibId = libID;

		$("#actions-orphaned").hide();
		$("#div-libraries").show();

	}

	oMylibDT.fnReloadAjax(sourceUrl);

}
/*
 * Function: loadOrphanedParts
 * 
 *  
 */
function loadOrphanedParts() {

	oMylibDT.fnReloadAjax(sBaseUrl + '/type/-1');
	$("#actions-orphaned").show();
	$("#div-libraries").hide();
}
/*
 * Function: loadMyPartsList
 * 
 * 
 */
function loadMyPartsList(id) {

	var gID, catID;

	if (id.indexOf('/') === -1) {
	   gID = id;
	} else {
	   gID = id.substr(0, id.indexOf('/'));
	   catID = id.substr(id.indexOf('/') + 1);
	}

	var sourceUrl = sBaseUrl + "/type/2" + "/gid/" + gID;
	
	if (typeof(catID) != "undefined") {
		sourceUrl = sourceUrl + "/catid/" + catID;
	}

	oMyPartsDT.fnReloadAjax(sourceUrl);

}

/*
 * Function: loadPartsList
 * 
 * 
 */
function loadPartsList(id) {

	var gID, catID;

	if (id.indexOf('/') === -1) {
	   gID = id;
	} else {
	   gID = id.substr(0, id.indexOf('/'));
	   catID = id.substr(id.indexOf('/') + 1);
	}
	
	var sourceUrl = sBaseUrl + "/gid/" + gID;
	
	if (typeof(catID) != "undefined") {
		sourceUrl = sourceUrl + "/catid/" + catID;
	}

	oPlistDT.fnReloadAjax(sourceUrl);
	populateLibraryList(gID);
	$("#partslist-actions :button").button( "option", "disabled", false );
}

/*
 * Function: getPartsListCount
 * 
 * 
 */
function getPartsListCount() {

	$.ajax({
		  url: '/api/partslist/count/',
		  async: true,
		  dataType: "json",
		  success: function(data) {
		    $('#partslist_cnt').html(data.count);

		    if (data.count == 0) {
		    	if ($("#tabs").tabs('option', 'selected') == 3) {
		    		$("#tabs").tabs('select', 1);
		    	}
		    	$('#tabs').tabs("disable", 3);
		    } else {
		    	$('#tabs').tabs("enable", 3);
		    }
		  }
		});

}

/*
 * Function: removePartsFromLibrary
 * 
 * 
 */
function removePartsFromLibrary() {

	var data = $('#form-mylib').serialize();

	$.ajax({  
		url: "/parts/library/removeparts/id/" + gLibId,   
		type: "POST",  
		data: data,       
		cache: false,  
		success: function () {
					$('#library_tree').jstree('refresh');
					$(':checkbox').attr('checked', false);
		        }
	});

}

function emptyPartsList () {

	$.ajax({
		  url: '/parts/partslist/empty/',
		  success: function(data) {
			 getPartsListCount(); 
			oPlistDT.fnClearTable();
			$('#form-plist :checkbox').attr('checked', false);
			$('#partslist_tree').jstree('refresh');
		  }
		});

}


function mergeLibrary () {

	var data = $('#form-plist').serialize();

	$.ajax({  
		url: "/parts/partslist/merge/",
		async: false,
		type: "POST",  
		data: data,       
		cache: false,  
		success: function () {
					getPartsListCount();
					oPlistDT.fnClearTable();
					$('#form-plist :checkbox').attr('checked', false);
					$('#partslist_tree').jstree('refresh');
					$('#library_tree').jstree('refresh');
		        }
	});

}

function clearLibrary () {
	$("#btn_library_copy").button("disable");
	$("div#library-actions").hide();
	$('td#lib_name').html('Choose Library');
	$('td#lib_descr').html('');
}

/*
 * Function: removePartsFromList
 * 
 * 
 */
function removePartsFromList() {

	var data = $('#form-plist').serialize();

	$.ajax({  
		url: "/parts/partslist/remove/",
		type: "POST",  
		data: data,       
		cache: false,  
		success: function () {
					getPartsListCount();
					oPlistDT.fnClearTable();
					$('#form-plist :checkbox').attr('checked', false);
					$('#partslist_tree').jstree('refresh');
				}         
	
	});
}

/*
 * Function: addToPartsList
 * 
 * 
 */
function addToPartsList(formID) {

	var data = $(formID).serialize();
	
	if (data.indexOf("id") < 0) {
		alert("No parts are selected.")
		return;
	}

	$.ajax({  
		url: "/parts/partslist/add/", 
		type: "POST",  
		data: data,       
		cache: false,  
		success: function () {
					getPartsListCount();
					$(':checkbox').attr('checked', false);
					$('#partslist_tree').jstree('refresh');
		        }
	});

}

/*
 * Function: exportToFasta
 * This function exports the selected parts to the fasta format
 */
function exportToFasta(formID) {

	
	var data = $(formID).serialize();
	
	if (data.indexOf("part_id") < 0) {
		alert("No parts are selected.")
		return;
	}
		
	// I don't want to have to do it this way, but need to talk to Russell about how to add actions to existing controllers
	
	location.href="/parts/index/export?type=0&"+data;
	$(':checkbox').attr('checked', false);
	
	//$.ajax({  
	//	url: "/export_parts.php",  
	//	target: "#",
	//	type: "POST",  
	//	data: data,       
	//	cache: false,  
	//	success: function () {
					//getPartsListCount();
	//				$(':checkbox').attr('checked', false);
	//				$('#partslist_tree').jstree('refresh');
	//	        }
	//});

}

/*
 * Function: exportToTabDelim
 * This function exports the selected parts to a tab-delimited format
 */
function exportToTabDelim(formID) {

	
	var data = $(formID).serialize();
	
	if (data.indexOf("part_id") < 0) {
		alert("No parts are selected.")
		return;
	}
	
	// I don't want to have to do it this way, but need to talk to Russell about how to add actions to existing controllers
	
	location.href="/parts/index/export?type=1&"+data;
	$(':checkbox').attr('checked', false);
	
	//$.ajax({  
	//	url: "/export_parts.php",  
	//	target: "#",
	//	type: "POST",  
	//	data: data,       
	//	cache: false,  
	//	success: function () {
					//getPartsListCount();
	//				$(':checkbox').attr('checked', false);
	//				$('#partslist_tree').jstree('refresh');
	//	        }
	//});

}

/*
 * Function:    loadBrowserTree
 * Parameters:  elementID, url
 * 
 * This function loads the jsTree at the passed elementID with json_data
 * that is loaded from the url parameter.
 */
function loadBrowserTree (elementID, url) {

	$(elementID)
	  .jstree({
		"types" : {
			"valid_children" : [ "root" ],
			"types" : {
				"root" : {
					"hover_node" : false,
					"select_node" : function() { return false; },
					"close_node" : true
				},
				"rootx" : {
					"valid_children" : [ "default" ],
					"hover_node" : false,
					"select_node" : false,
					"close_node" : true
				}
			}
		},
		"json_data" : {
		    "ajax" : { "url" : url }
	    },
	    "progressive_render" : true,
		"plugins" : [ "themes", "json_data", "ui", "types"]
	});
	
	 $(elementID).jstree("set_theme","classic");

}

function loadLibrariesTree() {

	clearLibrary();
	url = sMyLibraryTreeUrl + "private/";
	if ($('#check_user_libraries_only').attr("checked")) {
		url += "1";
	} else {
		url += "0";
	}
    loadBrowserTree("#library_tree", url);

    $('#library_tree').bind("select_node.jstree", 
		function (event, data) {
			loadLibraryParts(data.rslt.obj.attr("id"));
   		}
    );
}
function switchTab(index) {
	if (!bAuthenticated && index == 2) {
		window.location = '/login?reqlogin=My%20Parts&refurl=/parts/?tab=myparts';
		return;
	}

	$("#panel_grammar").hide();
	$("#panel_parts_mylib").hide();
	$("#panel_parts_myparts").hide();
	$("#panel_parts_plist").hide();
	
	
	switch (index) {
		case 0:
			$("#panel_grammar").show();
			break;
		case 1:
			$("#panel_parts_mylib").show();
			$("#actions-orphaned").hide();
			break;
		case 2:
			$("#panel_parts_myparts").show();
			break;
		case 3:
			$("#panel_parts_plist").show();
			break;
		case 4:	
			
			$("#check_user_libraries_only:checkbox").attr("checked", true);
			switchTab(1);
			break;
	}

}


function showLibraryForm(url, title)
{
    
    $('#dialog')
        .append($loading.clone())
        .load(url)
        .dialog({
            width: 550,
            minHeight: 300,
            title: title,
            modal: true,
            resizable: false,
            close: function() {$("#dialog").html(''); $('#dialog').dialog('destroy'); },
            buttons: {"Save": function() { 
            	$(":button:contains('Save')").button("disable"); 
            	saveLibrary(url); 
            }, "Cancel": function() { $(this).dialog("close"); }}
        });
}
 
function saveLibrary(url) {
  $.ajax({
    type: "POST",
    url: url,
    data: $("#library").serialize(),
    success: function(response) { 
	  if (typeof(response) === "object") {
    	  $("#form_messages").html(response.response).show().delay(2000).fadeOut(400);
		  $("#dialog").dialog('close');
          $('#library_tree').jstree('refresh');
          populateLibraryList(gGrammarId);
		 } else {
		 // It's a html snippet
       $("#dialog.ui-dialog-content").html(response);
		 }
    }
  });
  return;
}

function showPartForm(url)
{

  $('#dialog')
      .append($loading.clone())
      .load(url, function(text, status, xhr) {
    	  if (status == "success") {
    		  $("#category_id").multiselect2side({moveOptions: false, labelsx: "", labeldx: ""});
    		  $("#category_id p.RemoveOne").click(function() {});
    		  $("button").button();
    	  }
      })
      .dialog({
        width: 800,
        minHeight: 500,
        title: "Edit Part",
        modal: true,
        resizable: false,
        close: function() {$("#dialog").html(''); $('#dialog').dialog('destroy'); },
        buttons: {"Save": function() {
                      $(":button:contains('Save')").button("disable");
                      var id = $("form#part input#id").val();
                      var category_text = $("#category_id option:selected").text();

                      var design_count = $('#design_count').val();

                      if (category_text.indexOf('(MDL)') >= 0) {
                    	  $("#segment").val("||");
                      } 

                      if (design_count > 0) {
                          if (confirm("There are "+design_count+" designs using this part that may be affected or invalidated by this change.  Proceed with save?")) {
                              savePart(url);
                          } else {
                              $(":button:contains('Save')").button("enable");
                          }
                      } else {
                          savePart(url);
                      }
                      //showPartDetail(id, true);
                  },
                  "Delete": function() {
                	  
                	var design_count = $('#design_count').val();
                	var id = $("form#part input#id").val();
                	
                	var deleteUrl = "/parts/part/delete/id/" + id;
                	if (design_count > 0) {
                		alert("This part is included as part of a design, and therefore cannot be deleted.  If you wish to delete the part, please remove it from any designs that may be referencing it.");
                	} else {
                		if (confirm("Are you sure you want to delete this part?  It cannot be restored once it is deleted.")) {
                			deletePart(deleteUrl);
                			$(this).dialog("close");
                		}
                	}	
                  },
                  "Cancel": function() {
                	  var id = $("form#part input#id").val();
                	  if (id == "0") {
                		  $(this).dialog("close");
                	  } else {
                		  showPartDetail(id, true);
                	  }
                  }
                 }
      });

}

function addPartForm(url)
{
	

  $('#dialog')
      .append($loading.clone())
      .load(url, function(text, status, xhr) {
    	  if (status == "success") {
    		  $("#category_id").multiselect2side({moveOptions: false, labelsx: "", labeldx: ""});
    		  $("#category_id p.RemoveOne").click(function() {});
    		  $("button").button();
    	  }
      })
      .dialog({
        width: 800,
        minHeight: 500,
        title: "Add New Part",
        modal: true,
        resizable: false,
        close: function() {$("#dialog").html(''); $('#dialog').dialog('destroy'); },
        buttons: {"Save": function() {
        			  $(":button:contains('Save')").button("disable");
                      var id = $("form#part input#id").val();
                      var category_text = $("#category_id option:selected").text();

                      var design_count = $('#design_count').val();
                      
                      if (category_text.indexOf('(MDL)') >= 0) {
                    	  $("#segment").val("||");
                      } 

                      if (design_count > 0) {
                          if (confirm("There are "+design_count+" designs using this part that may be affected or invalidated by this change.  Proceed with save?")) {
                              savePart(url);
                          } else {
                              $(":button:contains('Save')").button("enable");
                          }
                      } else {
                          savePart(url);
                      }
                      //showPartDetail(id, true);
                  },
                  "Cancel": function() {
                	  var id = $("form#part input#id").val();
                	  if (id == "0") {
                		  $(this).dialog("close");
                	  } else {
                		  showPartDetail(id, true);
                	  }
                  }
                 }
      });

}

function showAttributeForm(url)
{

  $('#dialog')
      .append($loading.clone())
      .load(url, function(text, status, xhr) {
          if (status == "success") {
              $("#attribute-accordion").accordion({ autoHeight: true, collapsible: true });
              $(".parts-list").multiselect2side({moveOptions: false, labelsx: "", labeldx: ""});
              //$(".part-attribute").ForceNumericOnly();
          }
      })
      .dialog({
        width: 800,
        minHeight: 600,
        title: "Edit Part Attributes",
        modal: true,
        resizable: false,
        close: function() {$("#dialog").html(''); $('#dialog').dialog('destroy'); },
        buttons: {"Save": function() {
                      $(":button:contains('Save')").button("disable");
                      var id = $("input#part_id").val();
                      savePartAttribute(url);
                      //showPartDetail(id, true);
                  },
                  "Cancel": function() {
                      var id = $("input#part_id").val();
                      showPartDetail(id, true);
                  }
                 }
      });

}

function addMappingAttribute(part_id, attribute_id) 
{
	var url = "/parts/part/edit-mapped/part_id/"+part_id+"/attribute_id/"+attribute_id;
	$('#dialog')
    .append($loading.clone())
    .load(url)
    .dialog({
      width: 800,
      minHeight: 200,
      title: "Add Mapping Attribute",
      modal: true,
      resizable: false,
      close: function() {$("#dialog").html(''); $('#dialog').dialog('destroy'); },
      buttons: {"Save": function() {
                    $(":button:contains('Save')").button("disable");
                    var part_id = $("input#part_id").val();
                    var attribute_id = $("input#attribute_id").val();
                    saveMapAttribute(url);
                },
                "Cancel": function() {
                    var id = $("input#part_id").val();
                    showAttributeForm("/parts/part/edit-attribute/id/"+id);
                }
               }
    });
}

function editMappingAttribute(part_id, attribute_id) {
	var url = "/parts/part/edit-mapped/part_id/"+part_id+"/attribute_id/"+attribute_id;
	var strAttribute = "#attribute-" + attribute_id;
	var part_attribute_id = $(strAttribute).val();
	
	if (part_attribute_id == null) {
		alert("No mapping has been selected for editing.");
		return(false);
	} else {
		url += '/id/' + part_attribute_id;
		$('#dialog')
	    .append($loading.clone())
	    .load(url)
	    .dialog({
	      width: 800,
	      minHeight: 200,
	      title: "Edit Mapping Attribute",
	      modal: true,
	      resizable: false,
	      close: function() {$("#dialog").html(''); $('#dialog').dialog('destroy'); },
	      buttons: {"Save": function() {
	                    $(":button:contains('Save')").button("disable");
	                    var part_id = $("input#part_id").val();
	                    var attribute_id = $("input#attribute_id").val();
	                    var part_attribute_id = $("input#part_attribute_id").val();
	                    saveMapAttribute(url);
	                },
	                "Cancel": function() {
	                    var id = $("input#part_id").val();
	                    showAttributeForm("/parts/part/edit-attribute/id/"+id);
	                }
	               }
	    });
		return(true);
	}
}

function removeMappingAttribute(part_id, attribute_id) {

	var url = "/parts/part/delete-mapped/part_id/"+part_id+"/attribute_id/"+attribute_id;
	var strAttribute = "#attribute-" + attribute_id;
	var part_attribute_id = $(strAttribute).val();
	url = url + "/id/"+part_attribute_id;

	if (confirm('Are you sure you want to delete this attribute mapping?')) {
		//startLoading(); 
		$.ajax({
			type: "POST",
		    url: url,
		    success: function(data) {
		    	showAttributeForm("/parts/part/edit-attribute/id/"+part_id);
			}
		});
	}
}

function showImportForm(url)
{

  $('#dialog')
      .append($loading.clone())
      .load(url)
      .dialog({
        width: 800,
        minHeight: 200,
        title: "Import Parts",
        modal: true,
        resizable: false,
        close: function() {$("#dialog").html(''); $('#dialog').dialog('destroy'); },
        buttons: {"Import File": function() {
        				var libraryId = $('#library_id').val();
        				var fileName = $('#import_file').val();
        				
        				if (libraryId == '') {
        					alert('You must select a library.');
        					return false;
        				}
        				
        				if (fileName == '') {
        					alert('You must select a file to import.');
        					return false;
        				}
        				
                       	$('#importparts').submit();
                   },
                  "Close": function() {
                	   $(this).dialog("close");
                  }
                 }  
       });

}

function showPartDetail(id, allow_edit)
{

  $('#dialog')
      .append($loading.clone())
      .load('/parts/part/detail/id/' + id, function(text, status, xhr) {
          if (status == "success") {
              $("#part :input").attr('disabled', true);
              $("#attribute-accordion").accordion({ collapsible: true });
              $("#part-tabs").tabs();
          }
      })
      .dialog({
        width: 800,
        minHeight: 500,
        title: "Part Detail",
        modal: true,
        resizable: false,
        close: function() {
          $("#dialog").html(''); 
          $('#dialog').dialog('destroy');
        },
        buttons: {
            "Close": function() {
                 $(this).dialog("close");
            }
       }
      });

  if (allow_edit) (
      $("#dialog").dialog( "option", "buttons", {
          "Edit": function() {
        	    if ($("#part-tabs").tabs('option', 'selected') == 1) {
                    showAttributeForm('/parts/part/edit-attribute/id/' + id);
                } else {
                	showPartForm('/parts/part/edit/id/' + id);
                }
          },
          "Close": function() {
              $(this).dialog("close");
         }
      })
  )
}

function savePart(url) {
    $.ajax({
        type: "POST",
        url: url,
        data: $("#part").serialize(),
        success: function(response) {
            if (typeof(response) === "object") {
                $("#form_messages").html(response.response).show().delay(2000).fadeOut(400);
                $("#dialog").dialog('close');
                $('#library_tree').jstree('refresh');
                $('#myparts_tree').jstree('refresh');
                
            } else {
                // It's a html snippet
                $("#dialog.ui-dialog-content").html(response);
                $("#category_id").multiselect2side({moveOptions: false, labelsx: "", labeldx: ""});
                $(":button:contains('Save')").button("enable");
            } 
        }
  });
  return;
}

function deletePart(url) {
	$.ajax({
        type: "POST",
        url: url,
        data: $("#part").serialize(),
        success: function(response) {
        	if (typeof(response) === "object") {
                $("#form_messages").html(response.response).show().delay(2000).fadeOut(400);
                $("#dialog").dialog('close');
                $('#library_tree').jstree('refresh');
                $('#myparts_tree').jstree('refresh');
                getPartsListCount(); 
    			oPlistDT.fnClearTable();
    			$('#partslist_tree').jstree('refresh');
                
            } else {
                // It's a html snippet
                $("#dialog.ui-dialog-content").html(response);
                $("#category_id").multiselect2side({moveOptions: false, labelsx: "", labeldx: ""});
                $(":button:contains('Save')").button("enable");
            } 
        }
  });
  return;
}

function savePartAttribute(url) {
    var part_id = $("#part_id").val();
    $.ajax({
        type: "POST",
        url: url,
        data: $("#part-attribute").serialize(),
        success: function(response) {
            if (typeof(response) === "object") {
                $("#form_messages").html(response.response).show().delay(2000).fadeOut(400);
                showPartDetail(part_id, true);
            } else {
                // It's a html snippet
                $("#dialog.ui-dialog-content").html(response);
                $("#attribute-accordion").accordion({ autoHeight: true, collapsible: true });
                $(":button:contains('Save')").button("enable");
            } 
        }
  });
  return;
}

function saveMapAttribute(url) {
    var part_id = $("#part_id").val();
    var attribute_id = $("#attribute_id").val();
    $.ajax({
        type: "POST",
        url: url,
        data: $("#map-attribute").serialize(),
        success: function(response) {
            if (typeof(response) === "object") {
                $("#form_messages").html(response.response).show().delay(2000).fadeOut(400);
                showAttributeForm("/parts/part/edit-attribute/id/"+part_id);
            } else {
                // It's a html snippet
                $("#dialog.ui-dialog-content").html(response);
                $("#attribute-accordion").accordion({ autoHeight: true, collapsible: true });
                $(":button:contains('Save')").button("enable");
            } 
        }
  });
  return;
}


function showGrammarDetail(id) {

	var sUrl = "/api/grammar/grammar-summary/id/" + id;
	$("a#manage-grammar").button("disable");

    $("#loading").position({
        my:        "top",
        at:        "top",
        of:        $("#div-grammar"), // or $("#otherdiv)
        collision: "fit"
    });

    $("#loading").show();
	$("#div-grammar").css({ opacity: 0.5 });
	$.ajax({
	    type: 'GET',
	    url: sUrl,
	    dataType: 'json',
	    success: function(data) {
			$('td#grammar_name').html(data.grammar.name);
			$('td#grammar_description').html(data.grammar.description);
			$('td#grammar_icon_set').html(data.grammar.icon_set);
			$('td#grammar_attributes').html(data.grammar.is_attribute_grammar);
			$('td#categories_cnt').html(data.grammar.cnt_categories);
			$('td#rules_cnt').html(data.grammar.cnt_rules);
			$('td#designs_cnt').html(data.grammar.cnt_designs);
			$('td#libraries_cnt').html(data.grammar.cnt_libraries);
			$('td#parts_cnt').html(data.grammar.cnt_parts);
			$("a#manage-grammar").attr("href", "/grammar/index/index/id/" + data.grammar.grammar_id);
			$("a#manage-grammar").button("enable");
			$("#loading").hide();
			$("#div-grammar").css({ opacity: 1 });
		}
	});
}

function initPartsBrowser () {

    getPartsListCount();
    loadBrowserTree("#public_tree", sGrammarTreeUrl);
    loadLibrariesTree();
    loadBrowserTree("#myparts_tree", sMyPartsTreeUrl);
    loadBrowserTree("#partslist_tree", sMyCartTreeUrl);

    $('#public_tree').bind("select_node.jstree", 
		function (event, data) {
			showGrammarDetail(data.rslt.obj.attr("id"));
   		}
    );

    $('#library_tree').bind("select_node.jstree", 
		function (event, data) {
			loadLibraryParts(data.rslt.obj.attr("id"));
   		}
    );

    $('#myparts_tree').bind("select_node.jstree", 
		function (event, data) {
			loadMyPartsList(data.rslt.obj.attr("id"));
		}
    );
    $('#partslist_tree').bind("select_node.jstree", 
		function (event, data) {
			loadPartsList(data.rslt.obj.attr("id"));
		}
    );

    oPublicDT = initDataTable("#dt_public");
    oMylibDT = initDataTable("#dt_mylib");
    oPlistDT = initDataTable("#dt_plist");
    oMyPartsDT = initDataTable("#dt_myparts");

    oMyPartsDT.fnSettings().oLanguage.sEmptyTable = "Please choose a Grammar or Category on the left.";
    oPlistDT.fnSettings().oLanguage.sEmptyTable = "Please choose a Grammar or Category on the left.";

	$('.check-all').click(function () {
		checked_status = this.checked;
		$('#' + this.form.id + " :checkbox[name*='part_id']").each(function() {
			this.checked = checked_status;
		});
	});
	
	$('#check_user_libraries_only').click(function () {
		loadLibrariesTree();
	});

	/*********************************************
	 * My Libraries Buttons
	 *********************************************/
	$("#mylib_open_all").click(function () {
		$("#library_tree").jstree("open_all");
	});

	$("#mylib_close_all").click(function () {
		$("#library_tree").jstree("close_all");
	});

	$("#btn_library_remove").click(function() {
		if (confirm('Are you sure you want to remove the selected parts from this library?')) {
			removePartsFromLibrary();
		}
	});

	$('#btn_library_add, #btn_orphaned_add').click(function () {
		addToPartsList('#form-mylib');
     });

    $('#btn_library_edit').click(function(e) {
        e.preventDefault();
        showLibraryForm('/parts/library/edit/id/' + gLibId, "Edit Library");
    });
    $('#btn_library_copy').click(function(e) {
        e.preventDefault();
        showLibraryForm('/parts/library/clone/id/' + gLibId, "Copy Library");
    });
	$('#btn_library_delete').click(function () {
		if (confirm('Are you sure you want to delete this Library?')) {
			$.ajax({  
				url: "/parts/library/delete/id/" + gLibId,   
				type: "POST",  
				cache: false,  
				success: function (response) {
					if (typeof(response) === "object") {
						clearLibrary();
						oMylibDT.fnClearTable();
						$('#library_tree').jstree('refresh');	
					} else {
						alert("Library could not be deleted -- it has designs associated with it.  To delete the library, you must first delete the designs.");
					}
				}
			});
		}
	});

	/*********************************************
	 * My Parts Buttons
	 *********************************************/
	$("#btn_myparts_open_all").click(function () {
		$("#myparts_tree").jstree("open_all");
	});
	$("#btn_myparts_close_all").click(function () {
		$("#myparts_tree").jstree("close_all");
	});
	$('#btn_myparts_add_parts').click(function () {
		addToPartsList('#form-myparts');
     });
	$('#btn_myparts_fasta').click(function () {
		exportToFasta('#form-myparts');
     });
	$('#btn_myparts_tabdelim').click(function () {
		exportToTabDelim('#form-myparts');
     });
	$('#btn_myparts_import').click(function(e) {
		showImportForm('/parts/index/import', "Import parts");
     });
    $('#btn_myparts_new').click(function(e) {
        addPartForm("/parts/part/add/");
    });
	/*********************************************
	 * My Cart Buttons
	 *********************************************/
	$("#btn_plist_open_all").click(function () {
		$("#partslist_tree").jstree("open_all");
	});

	$("#btn_plist_close_all").click(function () {
		$("#partslist_tree").jstree("close_all");
	});

	$('#btn_plist_empty').click(function () {
		if (confirm('Are you sure you want to empty your Parts List?')) {
			emptyPartsList();
		}
	});

	$('#btn_plist_remove').click(function () {
		if (confirm('Are you sure you want to remove these parts from your Parts List?')) {
			removePartsFromList();
		}
	});

	$('#btn_plist_merge').click(function () {
		mergeLibrary();
     });

    $('#lib_new, #btn_plist_newlib').click(function(e) {
        showLibraryForm("/parts/library/add/", "Add New Library");
    });
    
    $('#btn_export_fasta').click(function () {
    	exportToFasta('#form-plist');
     });
    
	$('#btn_export_tab').click(function () {
		exportToTabDelim('#form-plist');
     });

    $('#btn_library_part').click(function(e) {
        addPartForm("/parts/part/add/library_id/" + gLibId);
    });

}
