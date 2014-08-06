 /*
 * simulation.js
 * Author: Russell Hertzberg
 * Date: August 31, 2011
 *
 */


/**
 * Calls the revalidate action in the design controller of the api module.  The 
 * action returns a JSON object that contains a message, which is shown in an alert.
 *
 * @param design_id
 */
function revalidateDesign(design_id) {

    $.ajax({
        type: 'GET',
        url: '/api/design/revalidate/id/' + design_id,
        dataType: 'json',
        success: function(data) {
            alert(data.message);
            location.reload();
        }
    });

}

function plotGrid(data, labels) {

	var options = {
	    seriesDefaults: {
        	lineWidth: 2.5,     // Width of the line in pixels.
        	shadow: true,       // show shadow or not.
        	shadowAngle: 45,    // angle (degrees) of the shadow, clockwise from x axis.
        	shadowOffset: 1.25, // offset from the line of the shadow.
        	shadowDepth: 3,     // Number of strokes to make when drawing shadow.  Each stroke offset by shadowOffset from the last.
        	shadowAlpha: 0.1,   // Opacity of the shadow.
        	showLine: true,     // whether to render the line segments or not.
        	showMarker: false   // render the data point markers or not.
    	},
    	axesDefaults: {
            pad: 0
    	},
    	series: labels,
    	legend: {
    		show: true,
    		xoffset: 20
        },
    	highlighter: {
            show: true,
            sizeAdjust: 7.5
        },
        cursor: {
        	show: true,
        	zoom: true,
        	tooltipLocation:'sw'
        },
        axes: {
            xaxis: {
              label: 'Time (in seconds)',
              labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
              numberTicks: 11,
              labelOptions: {
                  fontSize: '12px',
                  fontWeight: 'bold'
              },
              tickOptions: {
            	  formatString: "%0.2f"
              }
            },
            yaxis: {
              label: 'Particle Numbers',
              labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
              numberTicks: 11,
              pad: 1.2,
              labelOptions: {
                  fontSize: '12px',
                  fontWeight: 'bold'
              }
            }
        }
	};

	var choiceContainer = $("#series-choices");    
    choiceContainer.html("");

    var select = $('<select size="5" name="example-basic" multiple="multiple" title="Basic example" style="width: 300px; display: none;"/>');
	//	<option value="option1">Option 1</option>

	$.each(labels, function(key, val) {
		$(select).append('<option style="width: 300px;" value="' + key + '" selected="selected">' + val.label + '</option>');
    });

	$(choiceContainer).append(select);
	/*
    $.each(labels, function(key, val) {
        choiceContainer.append('<p><input type="checkbox" class="check" name="' + key + '" checked="checked" id="id' + key + '">' + '<label for="id' + key + '">' + val.label + '</label></p>');
    });
	*/

    //choiceContainer.find("select").click(function() {plotAccordingToChoices(data, labels, options)});
    $(select).multiselect({
    	selectedText: "# of # selected",
    	noneSelectedText: "Select Data Series to Display",
		click: function(){
			plotAccordingToChoices(data, labels, options);
		},
		checkAll: function(){
			plotAccordingToChoices(data, labels, options);
		},
		uncheckAll: function(){
			plotAccordingToChoices(data, labels, options);
		}
    });

	$.jqplot('chart', data, options);

    function plotAccordingToChoices(dataset, labels, options) {
        var data = [];
        options.series = [];

        $(select).multiselect("getChecked").each(function () {
            var key = $(this).attr("value");
            if (key && dataset[key]) {
                data.push(dataset[key]);
                options.series.push(labels[key]);
            }
        });
/*
        choiceContainer.find("input:selected").each(function () {
            var key = $(this).attr("value");
            if (key && dataset[key]) {
                data.push(dataset[key]);
                options.series.push(labels[key]);
            }
        });
*/
    	$("div#chart").html("");

        $.jqplot('chart', data, options);

    }


}

function plotGrid_flot(data) {
    
	var datasets = data;
	
	// initialize the color choices based on all of the available time series.
	// This will prevent colors from being reassigned when the user chooses
	// to show a different set of variables to be plotted on the chart.
    var i = 0;
    $.each(datasets, function(key, val) {
        val.color = i;
        ++i;
    });
    
    // insert checkboxes 
    var choiceContainer = $("#series-choices");
    choiceContainer.html("");
    $.each(datasets, function(key, val) {
        choiceContainer.append('<p><input type="checkbox" class="check" name="' + key +
                               '" checked="checked" id="id' + key + '">' +
                               '<label for="id' + key + '">'
                                + val.label + '</label></p>');
    });
    choiceContainer.find("input").click(plotAccordingToChoices);
    
    function plotAccordingToChoices(ranges) {
        var data = [];

        choiceContainer.find("input:checked").each(function () {
            var key = $(this).attr("name");
            if (key && datasets[key])
                data.push(datasets[key]);
        });

        var options = {
        		grid: {hoverable: true, clickable: true},
        		selection: { mode: "xy" },
                series: {
                    points: { show: false }
                },
                xaxis: {
                    axisLabel: 'time (in seconds)',
                    axisLabelUseCanvas: false
                },
                yaxis: {
                    axisLabel: 'particle numbers',
                    axisLabelUseCanvas: true
                }
            };
        if (data.length > 0) {
            $.plot($("#chart"), data, options );
        }
        
        function showTooltip(x, y, contents) {
        	$('<div style="max-width: 200px;" id="tiptip_holder"><div id="tiptip_arrow"><div id="tiptip_arrow_inner"></div></div><div id="tiptip_content">' + contents + '</div></div>').css ({
                position: 'absolute',
                display: 'none',
                top: y + 5,
                left: x + 5
            }).appendTo("body").fadeIn("200");

        }

        var previousPoint = null;

        $("#chart").bind("plothover", function (event, pos, item) {
            $("#x").text(pos.x.toFixed(2));
            $("#y").text(pos.y.toFixed(2));

                if (item) {
                    if (previousPoint != item.dataIndex) {
                        previousPoint = item.dataIndex;
                        
                        $("#tiptip_holder").remove();
                        var x = item.datapoint[0].toFixed(2),
                            y = item.datapoint[1].toFixed(2);
                        
                        showTooltip(item.pageX, item.pageY,
                                    "<span style='font-weight:bold';>" + item.series.label + "</span><br/>Particle Numbers = " + y + "<br/>Time (in seconds) = " + x);
                    }
                }
                else {
                    $("#tiptip_holder").remove();
                    previousPoint = null;            
                }
        });

    }

    plotAccordingToChoices();

    $("#chart").bind("selected", function (event, area) {

    	if (area.x2 - area.x1 < 0.00001)
            area.x2 = area.x1 + 0.00001;
        if (area.y2 - area.y1 < 0.00001)
            area.y2 = area.y1 + 0.00001;

        var data = [];

        choiceContainer.find("input:checked").each(function () {
            var key = $(this).attr("name");
            if (key && datasets[key])
                data.push(datasets[key]);
        });

        plot = $.plot(
            $("#chart"), data,
            $.extend(true, {}, {
                xaxis: { min: area.x1, max: area.x2 },
                yaxis: { min: area.y1, max: area.y2 }
            }));

    });

    $("#chart").bind("dblclick", function () {
        plotAccordingToChoices();
    });
}

/**
 * 
 *
 * @param design_id
 */
function runSimulation(design_id) {
	
	var int_time = $("input#int_time").val();
	var duration = $("input#duration").val();

	var url = '/simulate/index/run/id/' + design_id + '/int_time/' + int_time + '/duration/' + duration;

	$("#btn_run").button("disable").html("<img src='/images/loading_sm.gif' align='absmiddle' /> Running...").addClass("ui-state-error");
    $.ajax({
        type: 'GET',
        url: url,
        dataType: 'json',
        success: function(data) {
    		$("#chart").html("");
            $("#simulation").show();
            plotGrid(data.data, data.series);
            $("#btn_run").button("enable").html("Run Simulation").removeClass("ui-state-error");
        }
    });

}
