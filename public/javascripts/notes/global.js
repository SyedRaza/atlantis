$('document').ready(function() {

    var url = window.location.href;
    url = url.split('/');
    var root_notes = true;
    if (url[4] != 'notes') {
        if (typeof(eval(url[4])) == "number") {
            root_notes = false;
            $.getScript(window.location.href + '/notes', function(data) {
                $('.notes-container').html(data);
            });
        }
    }


    $("#note_types_list").hide();
    $('#note_types_list a').live('click', function(event) {
        $.getScript($(this).attr('href'), function(data) {
            if ($('.new-note').css('display') != 'none') {
                $('.new-note').hide('blind', function() {
                    $('.new-note').html(data).show('blind');
                });
            } else {
                $('.new-note').html(data).show('blind');
            }
        });
        event.preventDefault();
    });

    $('#note_types_menu > a').live('click', function() {
        $('#note_types_menu > dl').show('fade');
    });

    $('#note_types_menu').live('mouseleave', function() {
        $('#note_types_menu > dl').hide('fade');
    });

    $('.notes-pagination a, #x_doc_pagination a').live('click', function(event) {
        if (root_notes) {
            $.getJSON($(this).attr('href'), function(data) {
                $('.notes-container').hide('fade').html(data.list).show('fade');
                $('aside#left-bar #quick-filter').html(data.filter);
            });
        } else {
            $.getJSON(window.location.href + $(this).attr('href'), function(data) {
                $('.notes-container').hide('fade').html(data.list).show('fade');
                $('aside#left-bar #quick-filter').html(data.filter);
            });
        }
        event.preventDefault();
    });

    $('.thick-view-options > dl a.display-new-note').live('click', function(event) {
        event.preventDefault();

        //$("#new-note-cancel").trigger("click");
        var inputBlock = $('#show-details-' + $(this).attr('id')).find('.new-note');

        $(this).parents("dl.active > dd > ul").toggle();
        $(this).parents("dl.active").removeClass("active");

        $.getScript($(this).attr('href'), function(data) {
            if (inputBlock.css('display') != 'none') {
                inputBlock.hide('blind', function() {
                    inputBlock.html(data).show('blind');
                });
            }
            else {
                inputBlock.html(data).show('blind');
            }

            $("#new-note-form > div.select").removeClass("optional").addClass("required");
            $("#new-note-form > div.select label").removeClass("optional").addClass("required");
            $("#new-note-form > div.select select").removeClass("optional").addClass("required");
            $("#new-note-form > div.text").removeClass("optional").addClass("required");
            $("#new-note-form > div.text textarea").removeClass("optional").addClass("required");
            $("form#new-note-form").validator();
        });


    });

    $('dl.options a.display-new-note').live('click', function(event) {
        var note_parent_id = $(this).attr('id');
        $('.list-row-new-note').hide('blind').remove();

        $.getScript($(this).attr('href'), function(data) {
            var li = $('<li />');
            li.hide();
            li.attr('id', 'list-row-new-note-' + note_parent_id);
            li.attr('class', 'new-note');
            li.html(data);
            $('#list-row-' + note_parent_id).after(li);
            li.show('blind');
            $('dl.options.active > dd > ul').fadeOut();
            $('dl.options.active').removeClass('active');

            $("#new-note-form > div.select").removeClass("optional").addClass("required");
            $("#new-note-form > div.select label").removeClass("optional").addClass("required");
            $("#new-note-form > div.select select").removeClass("optional").addClass("required");
            $("#new-note-form > div.text").removeClass("optional").addClass("required");
            $("#new-note-form > div.text textarea").removeClass("optional").addClass("required");
            $("form#new-note-form").validator();
        });
        event.preventDefault();
    });

    $('#new-note-cancel').live('click', function() {
        if ($(this).parents('.new-note').tagName() == "LI") {
            $(this).parents('.new-note').hide('blind').remove();
        } else {
            $(this).parents('.new-note').hide('blind').find('.new-note-form').remove();
        }
    });

    var _data_old = '';
    $('ul.notes-list span.options > a.edit').live('click', function(event) {
        var li = $(this).parents('li.note');
        $.getScript($(this).attr('href'), function(data) {
            _data_old = li.find('dl > dd').html();
            li.find('dl > dd').html(data);
            li.find('dl > dd').show('blind');
        });
        event.preventDefault();
    });

    $('#edit-note-cancel').live('click', function() {
        var obj = $(this).parents('li.note').find('dl > dd');
        obj.hide('blind', 100, function() {
            obj.html(_data_old);
            obj.show('blind', 200);
        });
    });

//    $("#x_doc_submit").live("click", function(e) {
//        e.stopImmediatePropagation();
//        if ($("form#new_x_doc").data("validator").checkValidity()) {
//            return true;
//        } else {
//            $(".required").css("border-color", "red");
//            return false;
//        }
//    });
});

