/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    var source_title = "";
    $("#filter-me").hide();
    $("#all-vteams").hide();
    $("#all-leads").hide();
    $("input.datepicker").datepicker();
    $(".filter").combobox();
    $(".filter").hide();
    var heading_start = "";
    if ($("#opportunity_source_title").text() != "") {
        heading_start = $("#heading").text();
        $("#heading").text(heading_start + " against " + $("#opportunity_source_title option:selected").text() + " (" + $("#opportunity_source_type").val() + ")");
    }

    if ($("#opportunity_source_title").text() != "") {
        $('.auto').combobox();
        $("#all-leads").hide();
        $("#all-vteams").hide();
        $("#back").hide();
        $("#opportunity_source_title").live("focus", function() {
            $(".tooltip").slideToggle("slow");
        });
        $("#cancel").live("click", function() {
            $(".tooltip").hide("blind");
        });
        $("a.back").live("click", function(e) {
            e.preventDefault();
            $(".selected").hide();
            $(".selected").removeClass("selected");
            //$("input.selected").remove();
            $(".source").show("blind");
        });
        $(".selected").live("autocompleteselect", function(event, ui) {
            source_title = ui.item.value;
        });

        $("#ok").live("click", function(e) {
            if ($(".selected").attr("id") == "all-vteams" && source_title != "") {
                $("#heading").text("New Opportunity against " + source_title + " ( Vteam )");
            } else if ($(".selected").attr("id") == "all-leads" && source_title != "") {
                $("#heading").text("New Opportunity against " + source_title + " ( Lead )");
            }
            $("input[name=opportunity[source_title]]").val(source_title);
            $("input[name=opportunity[source_title]]").attr("readonly", "readonly");
            if (source_title != "")
                $(".tooltip").hide("fade");
            $(".selected > select.filter").find("option").each(function() {
                if ($(this).text() == source_title) {
                    $("input[name=opportunity[source_id]]").val($(this).attr("id"));
                    return false;
                }
            });
            e.preventDefault();
        });


        $("div.tooltip").find("span.source > a").bind("click", function(e) {
            if ($(this).parent().attr("id") == "by-lead") {
                $(".source").hide("fade");
                //$("#all-leads").text("Select Lead");
                $("input.filter").show();
                $("#all-leads").addClass("selected");
                $(".selected").show("blind");
                $("input[name=opportunity[source_type]]").val("Lead");
                e.preventDefault();
            } else if ($(this).parent().attr("id") == "by-vteam") {
                $(".source").hide();
                $("input.filter").show();
                //$("#all-vteams").text("Select Vteam");
                $("#all-vteams").addClass("selected");
                $(".selected").show("fade");
                $("input[name=opportunity[source_type]]").val("Vteam");
                e.preventDefault();
            }
            e.preventDefault();
        });


    } else {

        $('.auto').combobox();
        $("#all-leads").hide();
        $("#all-vteams").hide();
        //$("#cancel").hide();
        $("#back").hide();

        $("#opportunity_source_title").live("focus", function() {
            $(".tooltip").slideToggle("slow");
        });

        $("#cancel").live("click", function() {
            $(".tooltip").hide("fade");
        });

        $("a.back").live("click", function(e) {
            e.preventDefault();
            $(".selected").hide();
            $(".selected").removeClass("selected");
            $("input[name=opportunity[source_type]]").val("");
            $("input[name=opportunity[source_title]]").val("");
            $("input[name=opportunity[source_id]]").val('');
            $("#heading").text("Create New Opportunity");
            //$("input.selected").remove();
            $(".source").show("blind");
        });

        $(".selected").live("autocompleteselect", function(event, ui) {
            //            if($(".selected").attr("id")=="all-vteams"){
            //                $("#heading").text("Create Opportunity Against Vteam ( " + ui.item.value + " )");
            //            }else if($(".selected").attr("id")=="all-leads"){
            //                $("#heading").text("Create Opportunity Against Lead ( " + ui.item.value + " )");
            //            }
            source_title = ui.item.value;
            //            $("input[name=opportunity[source_title]]").val(ui.item.value);
            //            $("input[name=opportunity[source_title]]").attr("readonly", "readonly");
            //            $(".selected > select.filter").find("option").each(function(){
            //                if( $(this).text() == ui.item.value ){
            //                    $("input[name=opportunity[source_id]]").val($(this).attr("id"));
            //                    return false;
            //                }
            //            });
        });

        $("#ok").live("click", function(e) {
            if ($(".selected").attr("id") == "all-vteams" && source_title != "") {
                $("#heading").text("New Opportunity against " + source_title + " ( Vteam )");
            } else if ($(".selected").attr("id") == "all-leads" && source_title != "") {
                $("#heading").text("New Opportunity against " + source_title + " ( Lead )");
            }
            $("input[name=opportunity[source_title]]").val(source_title);
            $("input[name=opportunity[source_title]]").attr("readonly", "readonly");
            if (source_title != "")
                $(".tooltip").hide("fade");
            $(".selected > select.filter").find("option").each(function() {
                if ($(this).text() == source_title) {
                    $("input[name=opportunity[source_id]]").val($(this).attr("id"));
                    return false;
                }
            });
            e.preventDefault();
        });

        $("div.tooltip").find("span.source > a").bind("click", function(e) {
            if ($(this).parent().attr("id") == "by-lead") {
                $(".source").hide();
                $("input.filter").show();
                //$("#all-leads").text("Select Lead");
                $("#all-leads").addClass("selected");
                $(".selected").show("fade");
                $("input[name=opportunity[source_type]]").val("Lead");
                e.preventDefault();
            } else if ($(this).parent().attr("id") == "by-vteam") {
                $(".source").hide();
                $("input.filter").show();
                //$("#all-vteams").text("Select Vteam");
                $("#all-vteams").addClass("selected");
                $(".selected").show("fade");
                $("input[name=opportunity[source_type]]").val("Vteam");
                e.preventDefault();
            }
            e.preventDefault();
        });
    }
    $("#opportunity_created_effective").bind('change', function() {
        currentDate = new Date($(this).val());
        currentDate.setMonth((currentDate.getMonth() + 1), currentDate.getDate());
        $("#opportunity_expiry_date").datepicker('setDate', currentDate);

    });
    $("#opportunity_source_type").change(function() {
        if ($(this).val() == 'Vteam') {
            $(".select.Vteam").removeClass('hidden');
            $(".select.Lead").addClass('hidden');
            $("#heading").text(heading_start + " against " + $("#opportunity_source_title.Vteam option:selected").text() + " (" + $("#opportunity_source_type").val() + ")");
            $("#opportunity_source_title.Vteam").trigger("change");
        }
        else {
            $(".select.Lead").removeClass('hidden');
            $(".select.Vteam").addClass('hidden');
            $("#heading").text(heading_start + " against " + $("#opportunity_source_title.Lead option:selected").text() + " (" + $("#opportunity_source_type").val() + ")");

        }
    });
    $("input.Vteam,input.Lead").live("blur", function() {
        if ($("#opportunity_source_type").val() == "Vteam")
            $("#opportunity_source_id").val($("#opportunity_source_title.Vteam").find("option:selected").val());
        else if ($("#opportunity_source_type").val() == "Lead")
            $("#opportunity_source_id").val($("#opportunity_source_title.Lead").find("option:selected").val());
        $("#heading").text(heading_start + " against " + $(this).val() + " (" + $("#opportunity_source_type").val() + ")");
    });
    $("#opportunity_source_type").change(function() {
        if ($(this).val() == 'Vteam') {
            $("select.Vteam").removeClass('hidden');
            $("select.Lead").addClass('hidden');
            $("#heading").text(heading_start + " against " + $("#opportunity_source_title.Vteam option:selected").text() + " (" + $("#opportunity_source_type").val() + ")");
            $("#opportunity_source_title.Vteam").trigger("change");
        }
        else {
            $(".select.Lead").removeClass('hidden');
            $(".select.Vteam").addClass('hidden');
            $("#heading").text(heading_start + " against " + $("#opportunity_source_title.Lead option:selected").text() + " (" + $("#opportunity_source_type").val() + ")");

        }
    });
    $("select.Vteam,select.Lead").change(function() {
        $("#opportunity_source_id").val($(this).val());
        $("#heading").text(heading_start + " against " + $(this).find("option:selected").text() + " (" + $("#opportunity_source_type").val() + ")");
    });


    $("select#opportunity_source_title.Lead").combobox();
    $("select#opportunity_source_title.Vteam").combobox();
});