jQuery(function ($) {
    var csrf_token = $('meta[name=csrf-token]').attr('content'),
    csrf_param = $('meta[name=csrf-param]').attr('content');

    $.fn.extend({
        /**
         * Triggers a custom event on an element and returns the event result
         * this is used to get around not being able to ensure callbacks are placed
         * at the end of the chain.
         *
         * TODO: deprecate with jQuery 1.4.2 release, in favor of subscribing to our
         *       own events and placing ourselves at the end of the chain.
         */
        triggerAndReturn: function (name, data) {
            var event = new $.Event(name);
            this.trigger(event, data);

            return event;
        },

        /**
         * Handles execution of remote calls firing overridable events along the way
         */
        callRemote: function () {
            var el = this;
            var event = el.triggerAndReturn('ajax:before');
            if (event.result !== false) {
                var method = event.data_method || el.attr('method') || el.attr('data-method') || 'GET',
                url = event.data_url || el.attr('action') || el.attr('href'),
                dataType = event.data_type || el.attr('data-type') || ($.ajaxSettings && $.ajaxSettings.dataType);
                if (url === undefined) {
                    throw "No URL specified for remote call (action or href must be present).";
                } else {
                    var data = el.is('form') ? el.serializeArray() : [];
                    $.ajax({
                        url: url,
                        data: data,
                        dataType: dataType,
                        type: method.toUpperCase(),
                        beforeSend: function (xhr, settings) {
                            if (settings.dataType === undefined || settings.dataType === 'rails') {
                                xhr.setRequestHeader('accept', '*/*;q=0.5, ' + settings.accepts.script);
                            }
                            el.trigger('ajax:loading', xhr);
                        },
                        success: function (data, status, xhr) {
                            el.trigger('ajax:success', [data, status, xhr]);
                            do_update(el, data, status, xhr);
                            do_append(el, data, status, xhr);
                        },
                        complete: function (xhr) {
                            el.trigger('ajax:complete', xhr);
                        },
                        error: function (xhr, status, error) {
                            el.trigger('ajax:failure', [xhr, status, error]);
                        }
                    });
                    el.trigger('ajax:after');
                }
            }
        }
    });

    /**
     * update handler
     */
    function do_update(el, data, status, xhr) {
        if (el.attr('data-update')) {
            $(el.attr('data-update')).hide('blind').html('');
            $(el.attr('data-update')).html(data).show('blind');
        }
    }

    /**
     * Append handler
     */
    function do_append(el, data, status, xhr) {
        if (el.attr('data-append')) {
            $(el.attr('data-append')).append(data);
        }
    }

    /*
     /**
     *  confirmation handler
     */
    /*
     $('a[data-confirm],input[data-confirm]').live('click', function () {
     var el = $(this);
     var event = el.triggerAndReturn('confirm');
     if (event.result !== false) {
     if (!confirm(el.attr('data-confirm'))) {
     return false;
     }
     }
     });
     */

    function allowAction(element) {
        var message = element.attr('data-confirm');
        return !message || confirm(message);
    }

    /**
     * remote handlers
     */
    $('form[data-remote]').live('submit', function (e) {
        if ($(this).data('validator')) {
            if ($(this).data('validator').checkValidity()) {
                $(this).callRemote();
            }
        } else {

            $(this).callRemote();
        }
        e.preventDefault();
    });

    $('a[data-remote],input[data-remote]').live('click', function (e) {
        var link = $(this);
        if (!allowAction(link)) return false;

        $(this).callRemote();
        e.preventDefault();
    });

    $('a[data-method]:not([data-remote])').live('click', function (e) {
        var link = $(this),
        href = link.attr('href'),
        method = link.attr('data-method'),
        form = $('<form method="post" action="' + href + '"></form>'),
        metadata_input = '<input name="_method" value="' + method + '" type="hidden" />';

        if (csrf_param != null && csrf_token != null) {
            metadata_input += '<input name="' + csrf_param + '" value="' + csrf_token + '" type="hidden" />';
        }

        form.hide()
        .append(metadata_input)
        .appendTo('body');

        e.preventDefault();
        form.submit();
    });

    /**
     * disable-with handlers
     */
    var disable_with_input_selector = 'input[data-disable-with]';
    var disable_with_form_selector = 'form[data-remote]:has(' + disable_with_input_selector + ')';

    $(disable_with_form_selector).live('ajax:before', function () {
        $(this).find(disable_with_input_selector).each(function () {
            var input = $(this);
            input.data('enable-with', input.val())
            .attr('value', input.attr('data-disable-with'))
            .attr('disabled', 'disabled');
        });
    });

    $(disable_with_form_selector).live('ajax:complete', function () {
        $(this).find(disable_with_input_selector).each(function () {
            var input = $(this);
            input.removeAttr('disabled')
            .val(input.data('enable-with'));
        });
    });
});