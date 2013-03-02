$(document).ready(function() {
//$('#menu-strip').hide();
$('body > section > header').css('height', '47px')
    Array.max = function(array) {
        return Math.max.apply(Math, array);
    };
    Array.min = function(array) {
        return Math.min.apply(Math, array);
    };

    var list = $('.sidetabs-tabs > ul');
    list.find('li > a').live('click', function() {
        list.find('li > a.selected').removeClass('selected');
        $(this).addClass('selected');
    });

    $('a[href="#"]').live('click', function(e) {
        e.preventDefault();
    });

    $("#filter-type").buttonset();
    $("#filter-type >label").first().trigger("click");
    $("#filter-type >input").first().trigger("click");

    var h1 = $('#left-bar').height();
    var h2 = $('section.main > article').height();
    var h = h1 > h2 ? h1 : h2;
    $('#left-bar,section.main > article').css('min-height', h);

    $('body').ajaxStart(function() {
        $('#loader').show();
    });
    $('body').ajaxStop(function() {
        $('#loader').hide();
    });
    $('#quick-search-go').live('click', function(e) {
        var ev = new $.Event("keypress");
        ev.keyCode = 13;
        $('#qfilter').trigger(ev);
        $('#showfilter').trigger(ev);
    });
    $('form').attr('novalidate', 'novalidate');

    $('form').validator().bind("onBeforeFail", function(e, els) {
        //els.css('border','1px solid #F00');
    });

    $.tools.validator.fn(".select .required", function(input, value) {
        return value.length >= 1 ? true : {
            en: "Please select this Mandatory field"
        };
    });

    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd'
    });

    $('.datepicker').datepicker();

    $('.timepicker').timeEntry();


    if ($('p.notice').html() == "") {
        $('p.notice').hide();
    }

    if ($('p.alert').html() == "") {
        $('p.alert').hide();
    }

    $("button").live("click", function() {
        return false;
    });

    //$("select").combobox();

    $("fieldset.collapsible").collapse();
    $("fieldset.collapsibleClosed").collapse({
        closed : true
    });

    // ------------------------------------------------------
    // Form Tabs
    // ------------------------------------------------------
    $('.form-tabs-container > ul.form-tabs').tabs('.form-tabs-container > div.form-tabs-panes > div',
    {
        history: true,
        effect: 'slide',
        fadeOutSpeed: "slow"
    });
    var form_tabs_api = $(".form-tabs-container > ul.form-tabs").data("tabs");

    $('.form-tabs-next-button').click(function() {
        if (!$(this).hasClass('disabled')) {
            $('.form-tabs-back-button').removeClass('disabled');
            form_tabs_api.next();
            if (form_tabs_api.getIndex() == 3) {
                $('.form-tabs-next-button').addClass('disabled');
            }
        }
    });

    $('.form-tabs-back-button').click(function() {
        if (!$(this).hasClass('disabled')) {
            $('.form-tabs-next-button').removeClass('disabled');
            form_tabs_api.prev();
            if (form_tabs_api.getIndex() == 0) {
                $('.form-tabs-back-button').addClass('disabled');
            }
        }
    });

    if (form_tabs_api != null) {
        form_tabs_api.onClick(function(index) {
            (form_tabs_api.getIndex() == 0 ) ? $('.form-tabs-back-button').addClass('disabled') : $('.form-tabs-back-button').removeClass('disabled');
            (form_tabs_api.getIndex() == $('.form-tabs-container > ul.form-tabs li').size() - 1 ) ? $('.form-tabs-next-button').addClass('disabled') : $('.form-tabs-next-button').removeClass('disabled');
        });
    }

    // --------------------------------------------------------------------
    // Options menu
    // --------------------------------------------------------------------

    $('dl.options > dt > a').live('click', function() {
        var previous = $('dl.options.active');
        $('dl.options.active dd > ul').fadeOut();
        $('dl.options.active').removeClass('active');
        var id1 = $(this).parents('.list-row').attr('id');
        var id2 = previous.parents('.list-row').attr('id');

        if (id1 != undefined || id2 != undefined) {
            if (id1 != id2) {
                $(this).parents('dl.options').first().addClass('active').find('dd > ul').fadeIn();
            }
        } else {
            $(this).parents('dl.options').first().addClass('active').find('dd > ul').fadeIn();
        }

    });

    //---------------------------------------------
    // Hide Flash Messages
    //---------------------------------------------

    setTimeout("$('.alert').hide('fade')", 2000);
    setTimeout("$('.notice').hide('fade')", 2000);


    //-----------------------------------------------------
    // Global click Handler
    //-----------------------------------------------------
    $(document).bind('click', function(e) {
        // Lets hide the menu when the page is clicked anywhere but the menu.
        var $clicked = $(e.target);
        if (! $clicked.parents().hasClass("options")) {
            $(".options").removeClass('active');
            $('.options dd > ul').hide();
        }
    });

    $('#x_doc_list span.options > a.edit').live('click', function(event) {
        var li = $(this).parents('li.x-doc-item');
        $.getScript($(this).attr('href'), function(data) {
            _data_old = li.find(' > dd').html();
            li.find(' > dd').html(data);
            li.find(' > dd').show('blind');
        });
        event.preventDefault();
    });

    $("form").live("onFail", function(e, errors) {
        // we are only doing stuff when the form is submitted
        //        if (e.originalEvent.type == 'submit') {
        // loop through Error objects and add the border color
        $.each(errors, function() {
            var input = this.input;
            input.trigger("focus");
            return false;
        });
        //        }
    });

    // -------------------------------------------------
    // Close the Thick View
    // -------------------------------------------------
    $('.thick-view-close').live('click', function(evt) {
        closeThickView($(this).attr('id'));
        evt.preventDefault();
    });

});

function closeThickView(id) {
    var li = $("li#show-details-" + id);
    li.hide('blind', null, 500, function() {
        li.remove();
        $('li#list-row-' + id).show('blind', function() {
            $('.ui-effects-wrapper').remove();
        });
    });
}

function openThickView(id, html) {
    $('li.show-details').each(function() {
        closeThickView($(this).attr('id').replace('show-details-', ''));
    });
    var li = $("li#list-row-" + id);

    var dt = $("<li />");
    dt.attr('id', 'show-details-' + id);
    dt.attr('class', 'show-details');
    dt.hide();
    dt.html(html);
    li.after(dt);
    li.hide('blind', null, 200, function() {
        dt.show('blind', null, 500, function() {
            $('.ui-effects-wrapper').remove();
        });
    });
}

function makeSameWidth(selector1, selector2) {
    var size = $(selector1 + ' li').size();
    var w = 0;
    for (var i = 0; i < size; i++) {
        w = $(selector1 + ' > li:nth-child(' + i + ')').width();
        $(selector2 + " > li:nth-child(" + i + ")").each(function() {
            $(this).width(w);
        });
    }
}

function initialize_filters(id) {
    if (id == "showfilter") {
        $("#showfilter form").submit(function() {
            return false;
        });
        $('#showfilter').live("keypress", function(e) {
            if (e.keyCode == 13) {
                $.getJSON(window.location.href + "/notes/?filter=" + $(".filter-type > input:checked").attr("id") + "&value=" + $(this).val(), function(data) {
                    $(".notes-container").replaceWith(data.list);
                    $("aside#left-bar #quick-filter").html(data.filter);
                    $('#notes_selector > ul > li').find("a.selected").removeClass("selected");
                });
                return false;
            }

        });
    } else {
        $("#qfilter form").submit(function() {
            return false;
        });
        $('#qfilter').live("keypress", function(e) {
            if (e.keyCode == 13) {
                var form = $(this).parents("form");
                if (form.attr("data-method") == "json") {
                    $.getJSON(form.attr("action") + "/?filter=" + $(".filter-type > input:checked").attr("id") + "&value=" + $(this).val(), function(data) {
                        $('#qfilter').trigger('qfilterLoaded', data);
                    });
                } else {
                    $.getScript(form.attr("action") + "/?filter=" + $(".filter-type > input:checked").attr("id") + "&value=" + $(this).val());
                }
                return false;
            }

        });
    }
}