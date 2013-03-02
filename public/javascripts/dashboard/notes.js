/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    var selected = null;

    $("#notes_selector > ul li > a").each(function(el, i) {
        $(this).removeAttr('data-remote');
    });

    $("#notes_selector > ul li > a").live("click", function(e) {
        $('#qfilter').val('');
        var attr = $(this).attr("id");
        var link = $(this);
        $.getJSON($(this).attr('href'), function(data) {
            $('.notes-container').html(data.list);
            $('aside#left-bar #quick-filter').html(data.filter);
        });
        $("#notes_selector a").removeClass('selected');
        link.addClass('selected');
        e.preventDefault();
    });

    $('#notes_selector > ul li:nth-child(1) > a').click();

    $("#quick-filter  li > a, #clear_filters").live("click", function(e) {
        $.getJSON($(this).attr("href"), function(data) {
            $('.notes-container').html(data.list);
            $('aside#left-bar #quick-filter').html(data.filter);
        });
        e.preventDefault();
    });

    $('#qfilter').live('qfilterLoaded', function(event, data) {
        $('.notes-container').html(data.list);
        $('aside#left-bar #quick-filter').html('');
    });

    $(".filters > a").bind("click", function() {
        $('#notes_selector > ul > li').find("a.selected").removeClass("selected");
    });
});
