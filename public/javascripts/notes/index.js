$('document').ready(function() {

    $.getJSON(window.location.href + '/notes', function(data) {
        $('#xdoc-container').html(data.list);
    });    
});
