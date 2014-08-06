 /*
 * grammar_test.js
 * Author: Russell Hertzberg
 * Date: November, 2011
 *
 * This javascript library contains functionality that is relevant to the
 * "test" functionality in the Grammar Editor.
 * 
 * There is quite a bit of overlap between this file and the design.js.  It 
 * would be ideal to merge these two files and adjust the code so that they work
 * appropriately.
 *
 */

/*************************************************************************************
 * Global Variables 
 *************************************************************************************/
var history_arr = new Array(); 
var gHistoryIndex = -1;
var gSelectedIndex = -1;
var history_elements = new Array();
var elmWidth = 48;
var elements;
var element_index = 0;
var auto_selected_part_id;


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


	wrapper.append(detail)
	       .append(divRules);
    
	return (element.append(wrapper));

}


function addNode(node, index) {

	$(node).hide();
	$('#thecontainer div.element').eq(index).after(node);
	$(node).animate({width:"toggle", opacity: 1}, 300, "linear");

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

	try {
	$.each(objGrammar.rules[rule_id].transform, function(k, v) {

		var cat_id = objGrammar.rules[rule_id].transform[k].category_id;
		var node = createNode(objGrammar.categories[cat_id]);				

		var element = new Object();
		element.cat = objGrammar.categories[cat_id].letter;
		element.category_id = cat_id;
		
		new_elements[i] = element;

		addNode(node, indx + i);
		i++;
	});
	} catch (err) {
	}

	$(element).remove();

	addElements(new_elements, indx);
	addHistoryStep();
	adjustContainerWidth();

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
		$.each(objGrammar.categories, function(c) {

			if (objGrammar.categories[c].category_id == step[k].category_id) {
				$('#thecontainer').append(createNode(objGrammar.categories[c]).animate({width:"toggle", opacity: 1}, 300, "linear"));
				
			}

		});
	});

	elements = step;
	adjustContainerWidth();
	setCurrentHistory(index);

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

function initParser() {

    $('#thecontainer').html('');
    $('#history').html('');
    elements = new Array();
    history_arr = new Array();
    gHistoryIndex = -1;
    gSelectedIndex = -1;
    history_elements = new Array();
    adjustContainerWidth();


}
/**************************************************************************************
 * This method 
 * @return
 */

function startParser() {

    initParser();

    $.each(objGrammar.categories, function(k) {

        if (objGrammar.categories[k].category_id == objGrammar.starting_category_id) {
            $('#thecontainer').append(createNode(objGrammar.categories[k]));

            var element = new Object();
            element.cat = objGrammar.categories[k].letter;
            element.category_id = objGrammar.categories[k].category_id;
            element.part = "";
            element.part_id = "";
            elements.push(element);
        }
    });

    addHistoryStep();
}
