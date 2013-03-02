$(document).ready(function() {

    // Assign Google map to all map fields
    $('.address-map').each(function() {
        $(this).gMap($(this).parents('.field').find('#lat').val(), $(this).parents('.field').find('#lng').val(), 11);
    });

    count = 0;
    str = '<div class="links">';
    str += '<a href="#" class="small-icon add"></a>'
    str += '</div>'

    str2 = '<a href="#" class="small-icon del"></a>'

    $('.loopable-options > div#fields > div.field').each(function() {
        $(this).append(str);
    });
    $('.loopable-options > div#fields > div.field').each(function() {

        id = $(this).attr('id');
        id = id.split('_');
        id = eval(id[1])
        if (id != 0) {
            $(this).find('.links').append(str2);
        }
    });

    $('.loopable-options a.add').live('click', function() {
        $('.datepicker').datepicker('destroy');
        $('select.combobox').combobox('destroy');
        parent = $(this).parents('div.loopable-options');
        count = parent.find('#fields > .field').size();
        field = parent.find('div#fields > div#field_0').clone();
        field.attr('id', 'field_' + count);
        field.find('div').each(function() {
            if ($(this).attr('id')) {
                id = $(this).attr('id');
                id = id.split('_0');
                id = id.join('_' + count);
                $(this).attr('id', id);
            }
        });
        field.find('.address-map').gMap(-34.397, 150.644, 11);
        field.find('div.links').append('<a href="#" class="small-icon del"></a>');
        field.find('select,input').each(function() {
            var name = $(this).attr('name');
            name = name.split('[0]');
            $(this).attr('name', name.join('[' + count + ']'));
            id = $(this).attr('id');
            id = id.split('_0_');
            $(this).attr('id', id.join('_' + count + '_'));
            $(this).val('');
            if($(this).attr("type") == "checkbox"){
                $(this).val(0);
                $(this).attr("checked", false);
            }
        });
        //contact[phones_attributes][0][phone_type_id]
        parent.find('div#fields').append(field);

        field.show('blind');

        //field.find('.ui-advance-autocomplete').remove();
        field.find('.auto').combobox();

        $('select.combobox').combobox();
        $('.datepicker').datepicker();
        
        //autoComplete
//        if($(this).parents("div#companyInfo").attr("id") == "companyInfo"){
//        objAutoComplete = field.find('input.ui-advance-autocomplete');
//        if(objAutoComplete!=null)
//        {
//            objAutoComplete.autocomplete({
//                minLength: 1,
//                source:function(request, response) {
//                $.getJSON("/companies", request, function(data, status, xhr) {
//                    if (data.length > 0) {
//                    response($.map(data, function(item) {
//                        return {
//                        label: item.company.title,
//                        value: item.company
//                        }
//                        }));
//                    } else {
//                    response([
//                    {
//                        label: $('#companyInfo input.ui-advance-autocomplete').val(),
//                        value: null
//                        }
//                        ]);
//                    }
//                    });
//                },
//                focus: function(event, ui) {
//                $(event.target).val(ui.item.label);
//                return false;
//                },
//                select: function(event, ui) {
//                if (ui.item.value == null) {
//                $(event.target).trigger('autocompletenotfound', ui);
//                event.preventDefault();
//                event.stopPropagation();
//                event.stopImmediatePropagation();
//                return false;
//                } else {
//                $(event.target).val(ui.item.label);
//                return false;
//                }
//                }
//                }).data("autocomplete")._renderItem = function(ul, item) {
//                if (item.value == null) {
//                    return $("<li></li>")
//                    .data("item.autocomplete", item)
//                    .append("<a>Create New <strong>" + item.label + "</strong></a>")
//                    .appendTo(ul);
//                } else {
//                    return $("<li></li>")
//                    .data("item.autocomplete", item)
//                    .append("<a><span class='auto-column'>" + item.label + "</span></a>")
//                    .appendTo(ul);
//                }
//
//            };
//            objAutoComplete.bind('autocompleteselect', function(event, ui) {
//                if (ui.item.value != null) {
//                    $(this).parent().next().val(ui.item.value.id);
//                }
//            });
//
//            objAutoComplete.bind('autocompletenotfound', function(event, ui) {
//                new_company(event, ui.item.label);
//            });
//        }}
    //Autocomplete
    });

    $('.loopable-options a.del').live('click', function() {
        parent = $(this).parents('div.field');
        parent.find('input').each(function() {
            if ($(this).attr('name').indexOf('[_destroy]') > 0)
                $(this).val('true');
        });
        parent.hide('blind');
    });

});