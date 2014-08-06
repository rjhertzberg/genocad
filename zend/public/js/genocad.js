 /*
 * genocad.js
 * Author: Russell Hertzberg
 * Date: August 31, 2011
 *
 * This javascript library contains functionality that is relevant to the entire
 * GenoCAD system.
 *
 */

//Numeric only control handler
jQuery.fn.ForceNumericOnly =
function()
{
    return this.each(function()
    {
        $(this).keydown(function(e)
        {
            var key = e.charCode || e.keyCode || 0;
            // allow backspace, tab, delete, arrows, numbers and keypad numbers ONLY
            return (
                key == 8 || 
                key == 9 ||
                key == 46 ||
                key == 110 ||
                key == 190 ||
                (key >= 37 && key <= 40) ||
                (key >= 48 && key <= 57) ||
                (key >= 96 && key <= 105));

        });
    });
};


function load_help(module, controller, action) {
    $('#help')
        .load('/help', { 'mod': module, 'ctlr': controller, 'act': action })
        .dialog({
          width: 900,
          height: 500,
          title: "Help",
          modal: true,
          resizable: false,
          close: function() {$("#help").html(''); $('#help').dialog('destroy'); },
          buttons: {
              "Close": function() {
                   $(this).dialog("close");
              }
         }
        });
}

function disableDialogButtons() {
	$(".ui-dialog-buttonset button").button("disable");
}

function enableDialogButtons() {
	$(".ui-dialog-buttonset button").button("enable");
}

function disableFormSubmit() {
	$('form').submit(function(){
	    $('input[type=submit]', this).attr('disabled', 'disabled');
	    $('input[type=submit]', this).button("disable");
	});
}