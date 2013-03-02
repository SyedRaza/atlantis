var current_tab = null;
$(document).ready(function() {

    current_tab = -1;
    var api = $("#main-tabs ul.tabs").data("tabs");

    $('#main-tabs ul.tabs li').each(function(i) {
        var pane = $('#menu-strip nav.panes div:nth-child(' + (i + 1) + ')');
        var pane_width = pane.contents().width();
        var tab = $(this);

        // Left Aligned
        if (pane_width < (pane.width() / 2)) {
            pane.css('padding-left', tab.position().left);
        }
        // Right Aligned
        else if (pane_width > (pane.width() / 2)) {
            pane.css('padding-left', (tab.position().left - pane_width - 25));
        }
        //Center Aligned
        else {
            pane.css('padding-left', (tab.position().left - (pane_width / 2 )));
        }
        if ($(this).hasClass('current')) {
            $(this).removeClass('current');
            current_tab = i;
            return;
        }
    });
    $("#main-tabs ul.tabs").tabs("#menu-strip nav.panes > div", {
        event:'mouseover',
        effect: 'fade',
        fadeInSpeed: 200,
        fadeOutSpeed: 0,
        initialIndex: current_tab
    });
    var api = $("#main-tabs ul.tabs").data("tabs");
    var a = window.location.href.split("/");
    var b = [a[0],a[1],a[2]].join("/");
    $("#menu-strip nav.panes > div > a").each(function(j){
        //        console.log(b + $(this).attr('href'))
        //        console.log(window.location.href)
        if((b + $(this).attr('href')) == (window.location.href)){
            //            console.log("iv")
            $(this).addClass('current').show();
            $(this).parents("div").addClass('current').show();
            current_tab = $(this).parent("div").index();
            api.click(current_tab);
            return;
        }else{
            if("/" + a[3] == $(this).attr("href")){
                $(this).show();
                $(this).parents("div").addClass('current').show();
                current_tab = $(this).parent("div").index();
                api.click(current_tab);
                return;
            }
        }
    });

    $('#menu-strip').live('mouseleave',(function(e){
        api.click(current_tab);
        e.preventDefault();
    }));
});