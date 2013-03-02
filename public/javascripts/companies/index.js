/**
 * Created by .
 * User: Raza Khalid
 * Date: Jan 11, 2011
 * Time: 5:23:26 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function() {

    list = $('#companies_selector > ul');
    list.find('li > a').live('click', function() {
        list.find('li > a.selected').removeClass('selected');
        $(this).addClass('selected');
        $('#qfilter').val('');
    });
    $("#filter-type").buttonset();
    $('#companies_selector > ul li:nth-child(1) > a').click();

    $('#qfilter').live("keydown", (function(e) {
        if (e.keyCode == 13){
            $.getScript("companies/?filter=" + $(".filter-type > input:checked").attr("id") + "&value=" + $(this).val(), function() {
                $('#companies_selector > ul > li').find("a.selected").removeClass("selected");
            });
            return false;
        }
        $("form").submit(function(){
            return false;
        });
    }));

    $(".filters > a").bind("click", function() {
        $('#companies_selector > ul > li').find("a.selected").removeClass("selected");
    });


    //note management
    var ul = null;
    $("#xdoc_type_menu > a").live("click", function(){
        ul = $(this).parents("ul.list-row").attr("id");
        $(this).parents("ul").find("span.new_note").attr("id", "newxdoc");
    });

    $("form#new_x_doc").submit(function(){
        $("ul#"+ul).find("span.new_note").removeAttr("id");
    });

    $("#new-xdoc-cancel").live("click", function(){
        $("ul#"+ul).find("span.new_note").removeAttr("id");
    });
    $("#companies > ul > li.options").live("click", function(){
        $(this).find("#xdoc_type_menu").css("float", "left");
        $(this).find("#xdoc_type_menu a > span").removeClass("ui-icon ui-icon-document").text("").css("padding", "2px");
    });
});