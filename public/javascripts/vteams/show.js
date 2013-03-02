$(document).ready(function() {
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

    $("div.bottom-border>ul.tabs").tabs("div#resource-allocation");

    $('.opportunity_list_detail').collapsorz({
        minimum: 3
    });

    $("div.bottom-border>ul.tabs a").live('click', function() {
        var href = $(this).attr('href');
        href = href.split("/");
        if (href[href.length - 1] == "notes") {
            $.getJSON($(this).attr('href'), function(data) {
                $('div#newxdoc').html('');
                $('div.new-note').html('');
                $('div#dynamic-ajax-container').html(data.list).show();
                $("div#resource_vteam_allocations").hide();
                $("div#vacations").hide();
                $("div#notes").show();
                $("div.error").remove();

            });
        } else if (href[href.length - 1] == "resource_vteam_allocations") {
            $.getScript($(this).attr('href'), function(data) {
                $('div#newxdoc').html('');
                $('div#dynamic-ajax-container').html(data).show();
                $("div#resource_vteam_allocations").show();
                $("div#notes").hide();
                $("div#vacations").hide();
                $(".close").hide();
                makeSameWidth('ul.list-headers', 'ul.list-row');
                $("div.error").remove();

            });
        } else if (href[href.length - 1] == "vacations") {
            $.getScript($(this).attr('href'), function(data) {
                $('div#newxdoc').html('');
                $('div#dynamic-ajax-container').html('');
                $('div#dynamic-ajax-container').html(data).show();
                $("div#resource_vteam_allocations").hide();
                $("div#vacations").show();
                $("div#notes").hide();
                $(".close").hide();
                makeSameWidth('ul.list-headers', 'ul.list-row');
                $("div.error").remove();
            });
        }

        $('#new-xdoc-cancel').trigger('click');
    });


    $('dl.options > dd a').live('click', function(e) {
        var link = $(this);
        $('#new-xdoc-cancel').trigger('click');
        $.getScript(link.attr('href'), function(data) {
            link.parents('ul.list-row').first().after(data);
            $(".datepicker").datepicker();
            $('form').attr('novalidate', 'novalidate');
            $('form').validator();


        });
        e.preventDefault();
    });


    $("#new-xdoc-cancel").live("click", function() {
        if ($(this).parent().parent().prev().closest('.list-row').length) {
            $(this).parent().prev().remove();
            $(this).parent().remove();
        }
        $('div#newxdoc').html('');
        $("div.error").remove();
    });

    $("#resource_vteam_allocations a").live('click', function(e) {
        $.getScript($(this).attr('href'), function(data) {
            $('div#newxdoc').hide().html(data).show();
            $(".datepicker").datepicker();
            $('form').attr('novalidate', 'novalidate');
            $('form').validator();
            $("#resource_vteam_allocation_resource_id").combobox();
            $(".message").remove();
            $(".ui-autocomplete-input").autocomplete({
                select: function(event, ui) {
                    $(".message").remove();

                    if (ui.item != null) {
                        value = ui.item.value.split(",");
                        ui.item.value = value[0];
                        $("#resource_vteam_allocation_resource_id")
                                .val(ui.item.option.value);
                        request = ui.item.option.value
                        $.getJSON("/resources/" + request, function(data, status, xhr) {
                            var resource = jQuery.parseJSON(data.resource);
                            var vteam = jQuery.parseJSON(data.vteam);

                            $("#resource_vteam_allocation_billing_rate")
                                    .val(resource.resource.billing_rate);
                            $("#resource_vteam_allocation_resource_type")
                                    .val(resource.resource.resource_type.title);
                            if (vteam != null) {
                                $(".ui-autocomplete-input").after("<span class='message'>"
                                        + value[0] + " already attached to "
                                        + " <a href= '/vteams/"
                                        + vteam.resource_vteam_allocation.vteam_id
                                        + "'>"
                                        + vteam.resource_vteam_allocation.vteam.name
                                        + "</a> Vteam</span>");
                            }
                        });
                    }
                }
            });
        });
        e.preventDefault();
    });
    
    $("a.plus").live('click', function(e) {
        $('.close').removeClass('ui-state-error');
        $('.close').addClass('ui-state-highlight');
        $('.close').addClass('plus')
        $('.close').find('.ui-icon-close')
                .removeClass('ui-icon-close')
                .addClass('ui-icon-plus');
        $('.close').removeClass('close');
        var link = $(this);
        $(this).removeClass('ui-state-highlight');
        $(this).addClass('ui-state-error');
        $(this).removeClass('plus');
        $(this).addClass('close')
        $(this).find('.ui-icon-plus').removeClass('ui-icon-plus').addClass('ui-icon-close');
        $('div.show-details').remove()
        $.getScript(link.attr('href'), function(data) {
            link.next().show();
            //link.hide();
            link.parents('ul.list-row').first()
                    .after("<div class= 'show-details'>" + data + "</div>");
            //            $("div.show-details .list-row:last")
            //            .css( "border-bottom"," 1px dotted #AAAAAA");
            $('.show_text').expander({
                slicePoint: 27,
                expandText: '[More]',
                userCollapseText: '[Less]'
            });

        });

        e.preventDefault();
    });

    $("#details > a").live("click", function() {
        $("#dynamic-ajax-container").find(".show-details")
                .prev().show('blind').find("li").show("blind");
        $("#dynamic-ajax-container").find(".show-details").hide("blind");
        $("#dynamic-ajax-container").find(".show-details").remove();
        $("#dynamic-ajax-container").find("div.ui-effects-wrapper").css("width", "680px");
    });
    $('input,select').parent('label');

    $("#vacations a").live('click', function(e) {
        $.getScript($(this).attr('href'), function(data) {
            $('div#newxdoc').hide().html(data).show();
            $(".datepicker:first").datepicker({
                onSelect: function(date, inst) {
                    $(".datepicker:last")
                            .datepicker("option", "minDate", date);
                }
            });
            $(".datepicker:last").datepicker();
            $('form').attr('novalidate', 'novalidate');
            $('form').validator();
        });
        e.preventDefault();

    });

    $(".close").live("click", function(e) {
        e.preventDefault();

        $('.plus').show();
        $('div.show-details').remove();
        $(this).removeClass('ui-state-error');
        $(this).addClass('ui-state-highlight');
        $(this).removeClass('close');
        $(this).addClass('plus');
        $(this).find('.ui-icon-close')
                .removeClass('ui-icon-close')
                .addClass('ui-icon-plus');
    });


});
