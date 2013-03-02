$(document).ready(function() {

    var temp = 0;
    var url = window.location.href.split('/');
    url = url[url.length - 1];

    $("#accordion > div.pane").find("li > a").each(function() {
        var link = $(this).attr('href').toLowerCase().split("/");
        link = link[link.length-1];

        if (url == link) {
            temp = $(this).parents(".pane").prev().index();
            temp = temp / 2;
            return false;
        }
    });

    $("#accordion").tabs("#accordion div.pane", {
        tabs: 'h2',
        effect: 'slide',
        initialIndex: temp
    });
});