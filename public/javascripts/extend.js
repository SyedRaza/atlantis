$(document).ready(function() {

    $.fn.setId = function () {
        var counter = 0; // or maybe new Date().getTime()
        return this.each(function() {
            var $this = $(this);
            if (!$this.attr('id')) $this.attr('id', '_' + counter++);
        });
    };

    $.fn.tagName = function() {
        return this.get(0).tagName;
    };

    $.fn.Loopable = function(options) {
        var defaults = {
            'container' : 'options-container',
            'event_target' : 'evt',
            'append_class' : 'append_class'
        };
        var opt = $.extend(defaults, options);
        return this.each(function() {
            var $this = $(this);
            var container = $('<div />').attr('id', opt.container);
            var obj_list = [];
            var count = 1;
            container.prependTo($this);
            $this.find('input, select').each(function() {
                if ($(this).attr('name').indexOf('[0]') > 0) {
                    obj_list.push(this);
                }
            });
            $(opt.event_target).keypress(function(e) {
                if (e.which == 13) {
                    for (var i = obj_list.length - 1; i >= 0; i--) {
                        obj = $(obj_list[i]).clone();
                        obj.val($(obj_list[i]).val());
                        obj.removeClass().addClass(opt.append_class);
                        obj.css('display', 'none');
                        obj.attr('name', obj.attr('name').replace('[0]', '[' + count + ']'));
                        obj.prependTo(container);
                        //obj.attr('style', getInlineCss(opt.append_class));
                        obj.fadeIn();
                    }
                    count++;
                    e.preventDefault();
                    $(this).val('');
                }
            });
        });
    };

    (function($) {
        $.extend($.fn, {
            makeCssInline: function() {
                this.each(function(idx, el) {
                    var style = el.style;
                    var properties = [];
                    for (var property in style) {
                        if ($(this).css(property)) {
                            properties.push(property + ':' + $(this).css(property));
                        }
                    }
                    this.style.cssText = properties.join(';');
                    $(this).children().makeCssInline();
                });
            },
            getCssInline: function() {

            }
        });
    }(jQuery));

    function getInlineCss(css_class) {
        var obj = $('<div />');
        obj.addClass(css_class);
        var style = obj.style;
        var properties = [];
        obj.each(function(idx, el) {
            var style = el.style;
            for (var property in style) {
                if ($(this).css(property)) {
                    properties.push(property + ':' + $(this).css(property));
                }
            }
        });
        return properties.join(';');
    }

});

function setExpose(obj) {
    if (obj == 'null') {
        exposed = null;
        obj = $('*:focus');
    }
    while (obj.tagName() != 'BODY') {
        obj = obj.parent();
        if (obj.tagName() == 'FIELDSET') {
            if (exposed != obj.attr('id') && exposed != null) {
                $.mask.close();
                setTimeout("setExpose('null')", 500);
            } else {
                exposed = obj.attr('id');
                obj.expose({color:'#0AA9E8', opacity:0.2});
            }
            break;
        } else if (obj.tagName() == 'FORM') {
            if (exposed != obj.attr('id') && exposed != null) {
                $.mask.close();
                setTimeout("setExpose('null')", 500);
            }
            exposed = obj;
            obj.expose({color:'#0AA9E8', opacity:0.2});
            break;
        }
    }
}
