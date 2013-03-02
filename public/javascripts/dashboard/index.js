$(function() {
    $(".column").sortable({
        connectWith: '.column'
    });

    $(".portlet").addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
            .find(".portlet-header")
            .addClass("ui-widget-header ui-corner-all")
            .prepend('<span class="ui-icon ui-icon-minusthick"></span>')
            .end()
            .find(".portlet-content");

    $(".portlet-header .ui-icon").removeClass('.ui-icon-minusthick').addClass('.ui-icon-minus');
    $(".portlet-header .ui-icon").removeClass('.ui-icon-plusthick').addClass('.ui-icon-plus');
    $(".portlet-header .ui-icon").click(function() {
        $(this).toggleClass("ui-icon-minusthick").toggleClass("ui-icon-plusthick");
        $(this).parents(".portlet:first").find(".portlet-content").toggle();
    });

    $(".column").disableSelection();
});