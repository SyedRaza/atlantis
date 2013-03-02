$(document).ready(function() {

    list = $('#contact_selector > ul');
    list.find('li > a').live('click', function() {
        list.find('li > a.selected').removeClass('selected');
        $(this).addClass('selected');
    });

    $( "#filter-type" ).buttonset();

    $('#contact_selector > ul li:nth-child(1) > a').click();

    $('#qfilter').live("keydown", (function(e) {
        if (e.keyCode == 13){
        $.getScript("contacts/?filter=" + $(".filter-type > input:checked").attr("id") + "&value=" + $(this).val(), function() {
            $('#contact_selector > ul > li').find("a.selected").removeClass("selected");
        });
        return false;
        }
        $("form").submit(function(){
            return false;
        });
    }));

    $(".filters > a").bind("click", function(){
        $('#contact_selector > ul > li').find("a.selected").removeClass("selected");
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
    $("#contacts > ul > li.options").live("click", function(){
        $(this).find("#xdoc_type_menu").css("float", "left");
        $(this).find("#xdoc_type_menu a > span").removeClass("ui-icon ui-icon-document").text("").css("padding", "2px");
    });



});