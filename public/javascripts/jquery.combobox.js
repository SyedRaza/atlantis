(function($, undefined) {

    $.widget("ui.combobox", {
        options : {
            allow_new : false
        },
        _create : function() {

            var self = this;
            var auto_obj = new Object();
            auto_obj.delay = 0;
            auto_obj.minLength = 0;

            var select = this.element;
            select.hide();
            var selected = this.element.children(":selected");
            var value = selected.val() ? selected.text() : "";
            var input = $('<input />');
            if (select.attr('class'))
                input.attr('class', select.attr('class'));
            if (select.attr('size'))
                input.attr('size', select.attr('size'));
            input.insertAfter(select);
            this.input = input;

            auto_obj.source = function(request, response) {
                var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
                var match = false;

                response(select.children("option").map(function(i, value) {
                    var text = $(this).text();
                    if (this.value && ( !request.term || matcher.test(text) )) {
                        match = true;
                        return {
                            label: text.replace(
                                    new RegExp(
                                            "(?![^&;]+;)(?!<[^<>]*)(" +
                                                    $.ui.autocomplete.escapeRegex(request.term) +
                                                    ")(?![^<>]*>)(?![^&;]+;)", "gi"
                                            ), "<strong>$1</strong>"),
                            value: text,
                            option: this
                        };
                    }
                    if (!match && i == select.children("option").size() - 1 && self.options.allow_new) {
                        return {
                            label:'Create new <strong>' + input.val() + '</strong>',
                            value: input.val(),
                            option: null
                        };
                    }
                }));
            };

            // Select event of Auto complete
            auto_obj.select = function(event, ui) {
                if (!ui.item.option) {
                    // Trigger the event for value not found
                    $(select).trigger('autocompletenotfound', $(this).val());
                }
                if (ui.item.option.value != "0") {
                    ui.item.option.selected = true;
                    self._trigger('autocompleteselect', event, {
                        item:ui.item.option
                    });
                    self._trigger("selected", event, {
                        item: ui.item.option
                    });
                } else {
                    text = $(ui.item.option).text();
                    self.options.new_selected(text.replace('Create New ', ''));
                    select.find(':last').text('');
                    input.val('');
                    input.data("autocomplete").term = "";
                }
            };

            // Change event of auto complete
            auto_obj.change = function(event, ui) {

                if (!ui.item) {
                    var matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex($(this).val()) + "$", "i"),
                            valid = false;
                    select.children("option").each(function() {
                        if ($(this).text().match(matcher)) {
                            this.selected = valid = true;
                            return false;
                        }
                    });
                    if (!valid) {
                        // Trigger the event for value not found
                        $(select).trigger('autocompletenotfound', $(this).val());

                        // remove invalid value, as it didn't match anything
                        $(this).val("");
                        select.val("");
                        input.data("autocomplete").term = "";
                        return false;
                    }
                }
            };

            input.val(value)
                    .autocomplete(auto_obj)
                    .addClass('ui-widget ui-advance-autocomplete');
            input.data("autocomplete")._renderItem = function(ul, item) {
                return $("<li></li>")
                        .data("item.autocomplete", item)
                        .append("<a>" + item.label + "</a>")
                        .appendTo(ul);
            };

            // Open menu on focus 
            $(input).bind('focus', function() {
                $(this).autocomplete('search');
            });
        },
        destroy: function() {
            this.input.remove();
            this.element.show();
            $.Widget.prototype.destroy.call(this);
        }
    });

    $.extend($.ui.combobox, {
        escapeRegex: function(value) {
            return value.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&");
        },
        filter: function(array, term) {
            var matcher = new RegExp($.ui.autocomplete.escapeRegex(term), "i");
            return $.grep(array, function(value) {
                return matcher.test(value.label || value.value || value);
            });
        }
    });
}(jQuery));