/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){

    //$("#opportunity-wizard").hide();
    $("#filter-me").hide();
    $('.auto').combobox();
    $("#all-leads").hide();
    $("#all-vteams").hide();

    if($("#opportunity_source_title").val() != ""){
        $("#heading").text("Edit Opportunity Against "+$("#opportunity_source_type").val()+" ( " + $("input[name=opportunity[source_title]]").val() + " )");
        $("input[name=opportunity[source_title]]").attr("readonly", "readonly");
        $("#opportunity-wizard").show();
        $("#filter-me").show();
        $(".source").hide();
        if($("#opportunity_source_type").val() == "Lead"){
            $("#all-vteams").hide();
            $("#all-leads").show();
        }else if($("#opportunity_source_type").val() == "Vteam"){
            $("#all-leads").hide();
            $("#all-vteams").show();
        }
        $("#all-leads > a").live("click", function(e){
            e.preventDefault();
            $("input[name=opportunity[source_type]]").val("Lead");
            $("input[name=opportunity[source_title]]").val($(this).text());
            $("input[name=opportunity[source_title]]").attr("readonly", "readonly");
            $("input[name=opportunity[source_id]]").val($(this).attr("id"));
            //$("#opportunity-wizard").tabs("#opportunity-wizard", {history: true,effect: 'slide',    fadeOutSpeed: "slow"});
            if($("#opportunity-wizard").css("display") == "none"){
                $("#opportunity-wizard").slideToggle("slow");
            }
            $("#heading").text("Edit Opportunity Against Lead ( " + $("input[name=opportunity[source_title]]").val() + " )");
        });

        $("#all-vteams > a").live("click", function(e){
            e.preventDefault();
            //alert($(".source a.selected").text())
            $("input[name=opportunity[source_type]]").val("Vteam");
            $("input[name=opportunity[source_title]]").val($(this).text());
            $("input[name=opportunity[source_title]]").attr("readonly", "readonly");
            $("input[name=opportunity[source_id]]").val($(this).attr("id"));
            //$("#opportunity-wizard").tabs("#opportunity-wizard", {history: true,effect: 'slide',    fadeOutSpeed: "slow"});
            if($("#opportunity-wizard").css("display") == "none"){
                $("#opportunity-wizard").slideToggle("slow");
            }
            $("#heading").text("Edit Opportunity Against Vteam ( " + $("input[name=opportunity[source_title]]").val() + " )");
        });
    }else{

        $(".source > a").bind("click", function(e){
            e.preventDefault();

            if($(this).parent().attr("id")== "by-lead"){
                //alert("by lead")
                $(this).addClass("selected");
                $(".source").slideToggle("slow");
                $("#all-leads").show();
                $("#filter-me").slideToggle("slow");
                //$("#opportunity-wizard").show();
            }else if($(this).parent().attr("id") == "by-vteam"){
                //alert("by-vteam")
                $(this).addClass("selected");
                $(".source").slideToggle("slow");
                $("#all-vteams").show();
                $("#filter-me").slideToggle("slow");
            }
        });

        $("#qfilter").keyup(function(){
            if($("#all-leads").css("display") == "block"){
                var parent = "#all-leads"
                filter(parent +' > a', $(this).val(), parent);
            }else if($("#all-vteams").css("display") == "block"){
                var parent = "#all-vteams"
                filter(parent +' > a', $(this).val(), parent);
            }
            //alert(parent)
        });

        $("#all-leads > a").live("click", function(e){
            e.preventDefault();
            $("input[name=opportunity[source_type]]").val("Lead");
            $("input[name=opportunity[source_title]]").val($(this).text());
            $("input[name=opportunity[source_title]]").attr("readonly", "readonly");
            $("input[name=opportunity[source_id]]").val($(this).attr("id"));
            //$("#opportunity-wizard").tabs("#opportunity-wizard", {history: true,effect: 'slide',    fadeOutSpeed: "slow"});
            if($("#opportunity-wizard").css("display") == "none"){
                $("#opportunity-wizard").slideToggle("slow");
            }
        });

        $("#all-vteams > a").live("click", function(e){
            e.preventDefault();
            //alert($(".source a.selected").text())
            $("input[name=opportunity[source_type]]").val("Vteam");
            $("input[name=opportunity[source_title]]").val($(this).text());
            $("input[name=opportunity[source_title]]").attr("readonly", "readonly");
            $("input[name=opportunity[source_id]]").val($(this).attr("id"));
            //$("#opportunity-wizard").tabs("#opportunity-wizard", {history: true,effect: 'slide',    fadeOutSpeed: "slow"});
            if($("#opportunity-wizard").css("display") == "none"){
                $("#opportunity-wizard").slideToggle("slow");
            }
        });
    }



});

function filter(selector, query, parent) {
    query = $.trim(query); //trim white space
    query = query.replace(/ /gi, '|'); //add OR for regex query
    $(selector).each(function() {
        ($(this).text().search(new RegExp(query, "i")) < 0) ? $(this).parents(parent).hide('fade').removeClass('visible') : $(this).parents(parent).show('fade').addClass('visible');
    });
} 


