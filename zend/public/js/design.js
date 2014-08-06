 /*
 * design.js
 * Author: Russell Hertzberg
 * Date: March 1, 2011
 *
 * This javascript library contains functionality that is relevant to the
 * design page in the GenoCAD system.
 *
 */

/*************************************************************************************
 * Global Variables 
 *************************************************************************************/
var grammar = new Object();
var history_arr = new Array(); 
var gHistoryIndex = -1;
var gSelectedIndex = -1;
var history_elements = new Array();
var elmWidth = 48;
var elements;
var element_index = 0;
var auto_selected_part_id;


/**************************************************************************************
 * Retrieves parts for the given category and selected library, if the parts
 * have not already been retrieved from the database.
 * 
 * @param category
 */
function getCategoryParts(category) {

	var library_id = $('#library_id option:selected').val();
	var sUrl = "/api/library/getparts/library_id/" + library_id + "/forma/json/category_id/" + category.category_id;
	if (typeof category.parts == 'undefined') {

		$.ajax({
		    type: 'GET',
		    url: sUrl,
		    dataType: 'json',
		    success: function(data) { category.parts = data.parts; },
		    async: false
		});
	}

}

/**************************************************************************************
 * Retrieves the selected Grammar from the database, clears the design and 
 * populates the library select list.  If there is only one available library, 
 * it will be selected and the category parts will be retrieved.
 * 
 */
function getGrammar() {

	var grammar_id = $('#grammar_id').val();
	var sUrl = "/api/grammar/grammar/id/" + grammar_id;

	$.ajax({
	    type: 'GET',
	    url: sUrl,
	    dataType: 'json',
	    success: function(data) {
			grammar = data.grammar;
			populateLibraryList();
		},
	    async: false
	});

}

/**************************************************************************************
 * Retrieves the Library records for the selected Grammar and populates
 * the library select list on the screen.
 * 
 */
function populateLibraryList() {

	var select = $('#library_id');

	$(select).removeAttr('disabled');
	$(select)
    	.find('option')
    	.remove()
    	.end()
		.append('<option value="-1"> - Select Library - </option>');

	$.each(grammar.libraries, function(k) {
		$(select).append('<option value="' + grammar.libraries[k].library_id + '">' + grammar.libraries[k].name + '</option>');
	});

}


/**************************************************************************************
 * Initializes the Design screen and is called when the page is loaded
 * 
 */
function initDesign() {

	$('#thecontainer').html('');
	$('#history').html('');
	elements = new Array();
	history_arr = new Array();
	gHistoryIndex = -1;
	gSelectedIndex = -1;
	history_elements = new Array();
	adjustContainerWidth();
	$('div#status').hide();
	setDesignTitle('New Design');

	$('#library_id').attr('disabled', 'disabled');

}


/**************************************************************************************
 * This function is executed when the user chooses a grammar from the design page
 * 
 */
function selectGrammar() {
	
	var grammar_id = $('#grammar_id').val();
	getGrammar();

	// if there is only one library, the automatically select it...
	if (grammar.libraries.length == 1) {
		$("#library_id option:last").attr('selected', 'selected');
		startDesign();
	} else {
		$('#library_id').removeAttr('disabled');
	}

}

/**************************************************************************************
 * This function is executed when the user chooses a library from the design page
 * 
 * NOTE: this simply calls startDesign().  Instead of directly calling startDesign
 * from the onChange event in the library select list, we'll call this function in the
 * event additional code should be executed related to the selection of a library.
 */
function selectLibrary() {

	startDesign();

}

/**************************************************************************************
 * This method 
 * @return
 */

function startDesign() {

	initDesign();

	$.each(grammar.categories, function(k) {
		if (grammar.categories[k].category_id == grammar.starting_category_id) {

			$('#thecontainer').append(createNode(grammar.categories[k]));
			applyToolTips();

			var element = new Object();
			element.cat = grammar.categories[k].letter;
			element.category_id = grammar.categories[k].category_id;
			element.part = "";
			element.part_id = "";
			elements.push(element);
		}
	});

	addHistoryStep();
	$('#btn_new').button("enable");
	$('#grammar_id').attr('disabled', 'disabled');
	$('#library_id').attr('disabled', 'disabled');
}

/**
 * 
 */
function newDesign() {
	if (confirm('Are you sure?  This will clear your current design.')) {
		initDesign();


		$('input#design_id').val('');
		$('input#design_name').val('');
		$('#design_description').val('');
		
		$('#grammar_id').removeAttr('disabled');
		$('#library_id').attr('disabled', 'disabled');
		$("#grammar_id option:first").attr('selected', 'selected');
		$("#library_id option:first").attr('selected', 'selected');
	}
}

/**
 * This function appends parts to the parts div on the design screen.  The 
 * function will only display up to 100 parts at a time and was done so in 
 * order to improve the performance.  If there are more than 100 parts that need
 * to be displayed, a "Show More" link will be appended at the end of the list
 * and the user can click on that to draw more parts.
 *
 * @param parts
 * @param category
 * @param index
 *
 */
function showParts(parts, category, index) {
	
	var num_parts = 25;
	var max_index = index + num_parts;
	// assemble the parts list for the parts block
	part_list = $('<ul class="list-terminal"/>');

	// loop through each category part and add it to the parts list
	for (var i = index; i < category.parts.length; i++) {
		var part = $('<li class="part" id="' + category.parts[i].id + '"><a class="tooltip" id="' + category.parts[i].part_id + '" title="' + category.parts[i].description + '">' + category.parts[i].part_id + '</a></li>');
		$(part).click(function() { selectPart(this); } );
		part_list.append(part);

		if (i >= max_index) {
			var more1 = $('<button class="show_more tooltip" title="Show More">...</button>').button({icons: {primary: "ui-icon-circle-plus"}});
			var more = $('<li class="show_more"><a class="tooltip" title="Show More">MORE...</a></li>');
			more.click(function() {
				$(this).remove();
				showParts(parts, category, index + num_parts);
				applyToolTips();
			});
			part_list.append(more);
			break;
		}

	}

	parts.append(part_list);

}

/**************************************************************************************
 *  
 * This function basically draws the necessary html for a given category.
 *
 * The basic structure of the generated HTML is as follows:
 * 
 * <div class="element">
 *     <div class="elemWrapper">
 *         <div class="detail"/>
 *         <div class="rules" />
 *         <div class="parts" />
 *         <div class="part"/>
 *     </div>
 * </div>
 *
 * @param category
 * @return string (node)
 * 
 */

function createNode(category) {

	auto_selected_part_id = null;

	var element = $('<div class="element"/>');
	var wrapper = $('<div class="elemWrapper" />');
	var detail = $('<div class="detail" />');
	var divRules = $('<div class="rules"/>');
	var divParts = $('<div class="parts"/>');
	var divPart = $('<div class="part"/>');

	element.addClass('pattern-' + category.letter);

	// assemble the category detail block which includes the title and icon
	detail.append($('<h3 class="elementLetter">' + category.letter + '</h3>'));
	var icon = $('<img src="' + category.image_url + '" class="elementIcon tooltip">');
	icon.attr('title',category.description);
	detail.append(icon);

	// assemble the sub-categories
	divRules.attr('style', 'display: block');
	var rule_cnt = 0;

    // loop through the category rules and add them to the rules DIV 
    $.each(category.rules, function(k, v) {

        rule_cnt++;

		// assemble the rule list item (li)
        var rule = $('<li class="tooltip" ><a>' + category.rules[k].code + '</a></li>');
        rule.attr('title', 'Change to ' + category.rules[k].change_to + ' ()');
		rule.click(function () {
			transformCategory($(this).parent().parent().parent().get(0), category.rules[k].rule_id);
		});

		// append the rule li to the subcategories block
		divRules.append(rule);
	});

	// if there are no rules, hide the subcategories block
	if (rule_cnt == 0) {
		divRules.attr('style', 'display: none');
	}

    // retrieve the parts for the given category
	getCategoryParts( category );

	if (category.parts.length == 0) {

		// if there are no parts, hide the terminals block
		divParts.attr('style', 'display: none');
		divPart.attr('style', 'display: none;');

	} else if (category.parts.length == 1 && rule_cnt == 0) {

		// if there is only one part for the category and there are no subcategories,
		// then automatically "select" the part
		//update the elements array to indicate the selected part
		divPart.text(category.parts[0].part_id );
		divPart.attr('title', category.parts[0].description);
		divPart.addClass('no-parts');
		auto_selected_part_id = category.parts[0].id;
		divParts.attr('style', 'display: none');

	} else {

		showParts(divParts, category, 0);
	
		// CODE
		divPart.attr('style', 'display: none;');

	}

	wrapper.append(detail)
	       .append(divRules)
		     .append(divParts)
	       .append(divPart);
    
	return (element.append(wrapper));

}

/**************************************************************************************
 * This method is called when a user selects a terminal part for an element/cetagory
 * within the design page
 * 
 * @param part
 */
function selectPart(part) {

	// need to find the index of the element for which the part is being selected
	index = $(part).closest('div.element').index();

	// find the div block that stores the part [class=part]
	var divPart = $(part).closest('div.elemWrapper').find('div.part');

	// set the text for the code equal the the text of the selected part (part_id)
	// and bind the click event to the unselectPart function
	$(divPart).text($(part).text())
	       .click(function() { unselectPart($(divPart)); } );

	// collapse the sub categories and parts sections using animation
	var divElement = $('#thecontainer div.element').eq(index);
	$(divElement).find('div.parts').animate({height:"toggle", opacity: 1}, 200, "linear", function() { $(divElement).find('div.parts').hide();} );
	$(divElement).find('div.rules').animate({height:"toggle", opacity: 1}, 200, "linear", function() { $(divElement).find('div.rules').hide();} );
	
	// show the code div which displays the selected part
	$(divPart).text($(part).text());
	$(divPart).fadeIn();

	//update the elements array to indicate the selected part
	elements[index].part = $(part).text();
	elements[index].part_id = $(part).attr('id');
	
	// add a new step to the history panel
	addHistoryStep();
	checkStatus();

}

/**************************************************************************************
 * This method is called when a user un-selects a terminal part from an 
 * element/cetagory within the design page
 * 
 * @param code
 */
function unselectPart(part) {

	// need to find the index of the element for which the part is being unselected
	index = $(part).closest('div.element').index();

	// expand the subcategories and parts lists using animation
	var divRules = $(part).prev().prev();
	divRules.animate({height:"toggle", opacity: 1}, 300, "linear");
	if (divRules.html() == "") {
		divRules.hide();
	}

	$(part).prev('div.parts').animate({height:"toggle", opacity: 1}, 300, "linear");

	// hide the selected part (div.code) and unbind the click event 
	$(part).fadeOut();
	$(part).unbind( 'click');
	
	// update the elements array to indicate that there is no selected part
	elements[index].part = "";
	elements[index].part_id = "";

	// add a new step to the history panel
	addHistoryStep();
	checkStatus();

}

/**************************************************************************************
 * This method is called when a user un-selects a terminal part from an 
 * element/cetagory within the design page
 * 
 * @param code
 */
function addNode(node, index) {

	$(node).hide();
	$('#thecontainer div.element').eq(index).after(node);
	$(node).animate({width:"toggle", opacity: 1}, 300, "linear");

	applyToolTips();
	
}

/**************************************************************************************
 * When a new element is added to the design, the outer container width needs to
 * be adjusted so that it creates the horizontal scroll bar instead of wrapping
 * 
 */
function adjustContainerWidth() {
	var width = (elmWidth + 2) * elements.length;
	$('#thecontainer').attr('style', 'width: ' + width + 'px;' );
}

/**************************************************************************************
 * This function is called when a user selects one of the subcategories for an 
 * element.  This function removes the current element and replaces it with 
 * the elements defined by the change_to that the user chose.
 *   
 * 
 * @param element
 * @param change_to
 * 
 */
function transformCategory(element, rule_id) {

	var nodes = new Array();
	var indx = $(element).index();
	var new_elements = new Array();
	var i = 0;

	// added try-catch -- when the rule transform is empty, throws an error
	try {
		$.each(grammar.rules[rule_id].transform, function(k, v) {
			var cat_id = grammar.rules[rule_id].transform[k].category_id;
			var node = createNode(grammar.categories[cat_id]);				

			var element = new Object();
			element.cat = grammar.categories[cat_id].letter;
			element.category_id = cat_id;
			element.part = "";
			element.part_id = auto_selected_part_id;

			new_elements[i] = element;

			addNode(node, indx + i);
			i++;
		});
	} catch (err) {
	}	

	$(element).remove();

	clearToolTips();
	addElements(new_elements, indx);
	addHistoryStep();
	adjustContainerWidth();

	checkStatus();


}

/**************************************************************************************
 * This function creates the HTML for the given step index.
 *  
 * @param index
 *
 */
function drawHistoryStep(index) {

	var ul = $('<ul>');

	ul.attr('id', 'step_' + index)
	  .addClass('history-list-item')
	  .append($('<li>Step ' + (index + 1) + "" + '</li>'))
	  .click(function() { redrawElements(index); });

	$('#history').append(ul);
}

function setCurrentHistory(index) {
	$('.history-list-item').removeClass('current');
	$('ul#step_' + index).addClass('current');
}

/**
 * 
 * 
 */
function addHistoryStep() {

	var index;

	// need to check to see if the user has recently chosen a step from history
	// to determine if we need to add this as the step after the chosen step, or
	// if the step should be added to the end of the array
	if (gSelectedIndex != gHistoryIndex) {
		index = gSelectedIndex;
		gHistoryIndex = gSelectedIndex;
	} else {
		index = gHistoryIndex;
	}

	history_elements = history_elements.slice(0, index + 1);

	// remove all of the elements after the 
	$('#step_' + index).nextAll().remove();
 
	// now increment the index
	index++;

	history_arr[index] = index;
	history_elements.push(JSON.stringify(elements));

	drawHistoryStep(index);

	gHistoryIndex = index;
	gSelectedIndex = gHistoryIndex;
	setCurrentHistory(index);

	// need to fade out the design status because once a change is made to the
	// design, the status becomes unknown and the design will need to be revalidated
	$("#design-status").fadeOut();
}

/**
 * Will add the new_elements array starting at the provided index, replacing the
 * contents of the index with the new elements array
 * 
 * @param new_elements
 * @param index
 */
function addElements (new_elements, index) {

	var arr_before = elements.slice(0, index);
	var arr_after = elements.slice(index + 1);
	elements.splice(index, 1);
	elements = arr_before.concat(new_elements);
	elements = elements.concat(arr_after);

}

/**
 * When a user selects one of the history steps, the page calls this function
 * which will re-draw the elements array that can be found in the history array
 * at the given index
 * 
 * @param index
 * 
 */
function redrawElements(index) {

	// clear the container
	$('#thecontainer').html('');

	gSelectedIndex = index;

	var step = JSON.parse(history_elements[index]);

	$.each(step, function(k) {
		$.each(grammar.categories, function(c) {

			if (grammar.categories[c].category_id == step[k].category_id) {
				$('#thecontainer').append(createNode(grammar.categories[c]).animate({width:"toggle", opacity: 1}, 300, "linear"));
				
				if (step[k].part_id != '' && step[k].part_id != null) {
					$('#thecontainer div.element').eq(k).find('div.rules').animate({height:"toggle", opacity: 1}, 200, "linear").hide();
					$('#thecontainer div.element').eq(k).find('div.parts').animate({height:"toggle", opacity: 1}, 200, "linear").hide();
					var part = $('#thecontainer div.element').eq(k).find('div.part');

					var parts = grammar.categories[c].parts;

					$.each(parts, function(p) {
						if (parts[p].id == step[k].part_id) {
							$(part).text(parts[p].part_id)
							       .fadeIn();
							// if it's not an auto-selected part, then bind the click method
							// to the unselect part function
							if (auto_selected_part_id != step[k].part_id) {
								$(part).click(function() { unselectPart($(part)); } );
							}
						}
					});

				}
			}

		});
	});

	elements = step;
	applyToolTips();
	adjustContainerWidth();
	setCurrentHistory(index);

}

/**
 * applyToolTips
 */
function applyToolTips() {

	/**
	 * Commented this out because it was severely slowing down the design screen.
	 * The tooltip will continue to show up, but it won't be using the tipTip jquery
	 * plugin.  I would suggest looking into an alternative plugin if the default
	 * functionality does not suffice.
    **/

	//$('div.detail img, .tooltip').tipTip({delay: 200, defaultPosition: "right", fadeOut: 0});
}

/**
 * clearToolTips
 * 
 */
function clearToolTips() {
	$("div#tiptip_holder").hide();
}

/**
 * Simply sets the title of the design to the value of the "title" parameter
 * 
 * @param title
 */
function setDesignTitle(title) {
	$('#design-title').text(title);
}

/**
 * opens the "Save Design" dialog box
 * 
 */
function showSaveDesign()
{

	$('#form_design input:hidden[name=design_steps]').val(JSON.stringify(history_elements));
	$('#form_design input:hidden[name=design_library_id]').val($('#library_id').val());


	if ($('#design_id').val() != '') {

		if ($('#design_is_public').val() == '1') {
			var buttons = {
					"Save As New": function() { saveDesign(true); }, 
					"Cancel": function() { $(this).dialog("close"); }
				};
		} else {
			var buttons = {
					"Save": function() { saveDesign(false); }, 
					"Save As New": function() { saveDesign(true); }, 
					"Cancel": function() { $(this).dialog("close"); }
				};
		}
	} else {
		var buttons = {
			"Save Design": function() { saveDesign(true); }, 
			"Cancel": function() { $(this).dialog("close"); }
		}
	}
	
	$('#save_dialog')
		.dialog({
			width: 550,
			minHeight: 300,
			title: "Save Design",
			modal: true,
			resizable: false,
			close: function() {$('#save_dialog').dialog('destroy'); },  // Destroy the dialog.  Allows it to appear again if closed.
			buttons: buttons
	});

}

/**
 * Posts the design form to the save action of the design controller in the API module
 * 
 * The save action should return a JSON object that contains the design record and
 * any messages that need to be shown to the user
 * 
 */
function saveDesign(saveas) {

	disableDialogButtons();

	if (saveas) {
		$('#form_design input:hidden[name=design_id]').val('');
	}

	$.ajax({
	    type: "POST",
	    url: "/api/design/save/",
	    data: $("#form_design").serialize(),
	    success: function(response) {
			if (typeof(response) === "object") {
				$('#form_design input:hidden[name=design_id]').val(response.data.design_id);
				setDesignTitle(response.data.name);
			} else {
				enableDialogButtons();
				alert(response);
			}

			$('#save_dialog').dialog('destroy');
		},
		failure: function(response) {
			alert(response);
		}
	});
	
  return;
}

function redrawHistory(data) {
	
	// clear the history container
	$('ul#history').html('');

	history_arr = new Array();
	history_elements = new Array();

	$.each(data.data, function(i) {

		drawHistoryStep(i);

		elements = new Array();
		$.each(data.data[i], function (j) {
			elements.push(data.data[i][j]);
		});

		history_arr.push(i);
		history_elements.push(JSON.stringify(elements));

	});

	gHistoryIndex = history_arr.length;
	gSelectedIndex = gHistoryIndex;

	redrawElements(gHistoryIndex - 1);

}

/**
 * Retrieves and loads a saved design based on the design_id parameter
 * 
 * @param design_id
 * 
 */
function reloadDesign(design_id) {

	setDesignTitle('Loading...');

	$( "#processing" ).show();
	$( "#processing" ).dialog({
		modal: true,
		title: "Processing...",
		draggable: false,
		height: "75",
		closeOnEscape: false,
		open: function(event, ui) { $(".ui-dialog-titlebar-close").hide(); }

	});

	$.ajax({
		  url: "/api/design/load-design/id/" + design_id,
		  success: function (data) {
						getGrammar();

						$('#library_id').val(data.design.library_id);
						$('#grammar_id').attr('disabled', 'disabled');
						$('#library_id').attr('disabled', 'disabled');
						$('#btn_new').button("enable");
						
						redrawHistory(data);
						setDesignTitle(data.design.name);
						checkStatus();
						$( "#processing" ).dialog("destroy");
		  },
		  dataType: "json"
		});

}

/**
 * Loops through the element array to determine if the design is complete.  If 
 * each element has a part selected, then it is considered complete and the 
 * user interface should show the "Download" links that will allow the user
 * to export the design sequence.
 * 
 */
function checkStatus() {

	var bIncomplete = false;

	$.each(elements, function(i) {
		if (elements[i].part_id == "" || elements[i].part_id == null) {
			bIncomplete = true;
		}
	});
	
	if (!bIncomplete) {
		$('div#status').show();
	} else {
		$('div#status').hide();
	}

}

/**
 * 
 * @param format
 * 
 */
function downloadSequence(format) {

	var parts = new Array();
	var categories = new Array();
	var library_id = $('#library_id').val();
	var grammar_id = $('#grammar_id').val();
	var design_id = $('#design_id').val();

	//var design = JSON.stringify(history_elements[history_elements.length - 1]);

	$.each(elements, function(i) {
		parts.push(elements[i].part_id);
		categories.push(elements[i].category_id);
	});

	location.href = '/design/index/download-sequence?format=' + format + '&categories=' + categories.join("|") + '&terminals=' + parts.join("|") + '&library_id=' + library_id + '&grammar_id=' + grammar_id + '&design_id=' + design_id;// + '&design=' + design; 

}