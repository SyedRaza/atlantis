$(document).ready(function() {

    //    $('#contact_contact_status_id').combobox();
    //    $('#contact_contact_type_id').combobox({allow_new:true});
    //    $('#contact_contact_directory_id').combobox();
    $('.auto').combobox();
    $('select.combobox').combobox();
    // Initlize Google map location according to given address details
    $('.zip').live('blur', function() {
        //       root = $(this).parents('.field');
        //        address = root.find('#street').val() + ' ' + root.find('#city').val() + "," + root.find('#state').val() + ' ' + root.find('#zip').val() + ' , ' + root.find('#country :selected').text();
        //        root.find('.address-map').gMap().geoCodeAndMark(address, function(lat, lng, address) {
        //            root.find('#lat').val(lat);
        //            root.find('#lng').val(lng);
        //        });
        });
    /*
    function AddressedFeildMatcher(){
    return $('#addressInfo #fields>div').each(function(){
        trueCount = 0;
        emptyArrayList = new Array ();
        i = 0;
        $(this ).children('div').children('div').children('select,input').each(function (){
            if($(this ).val().length > 0 )
            {
                trueCount++;
            }
            else
            {
                emptyArrayList[i] = $(this);
                i++;
            }
        });
        console.log(emptyArrayList.length);
        if (trueCount > 0 && trueCount < 6)
        {
            return emptyArrayList;
        }
    });
    }
    */
    //    var selectionCompany = false;
    //    $('#companyInfo input.ui-advance-autocomplete').autocomplete({
    //        minLength: 1,
    //        source:function(request, response) {
    //        $.getJSON("/companies", request, function(data, status, xhr) {
    //            if (data.length > 0) {
    //            response($.map(data, function(item) {
    //                return {
    //                label: item.company.title,
    //                value: item.company
    //                }
    //                }));
    //            } else {
    //            response([
    //            {
    //                label: $('#companyInfo input.ui-advance-autocomplete').val(),
    //                value: null
    //                }
    //                ]);
    //            }
    //            });
    //        },
    //        focus: function(event, ui) {
    //
    //        selectionCompany = false;
    //        $(event.target).val(ui.item.label);
    //        return false;
    //        },
    //        open:function(event, ui) {
    //        selectionCompany = false;
    //        $(this).focus();
    //        $(this).parent("div").find("a").remove();
    //        return false;
    //        },
    //        close:function(event, ui) {
    //        if(!selectionCompany){
    //        $(this).parent("div").find("a").remove();
    //        $(this).val("");
    //        }
    //        }
    //        ,
    //        select: function(event, ui) {
    //        selectionCompany = true;
    //        if (ui.item.value == null) {
    //        $(event.target).trigger('autocompletenotfound', ui);
    //        event.preventDefault();
    //        event.stopPropagation();
    //        event.stopImmediatePropagation();
    //        return false;
    //        } else {
    //        $(event.target).val(ui.item.label);
    //        return false;
    //        }
    //        }
    //        }).data("autocomplete")._renderItem = function(ul, item) {
    //        if (item.value == null) {
    //            return $("<li></li>")
    //            .data("item.autocomplete", item)
    //            .append("<a>Create New <strong>" + item.label + "</strong></a>")
    //            .appendTo(ul);
    //            $(".ui-autocomplete .ui-menu ui-widget .ui-widget-content .ui-corner-all").focus();
    //        } else {
    //            return $("<li></li>")
    //            .data("item.autocomplete", item)
    //            .append("<a><span class='auto-column'>" + item.label + "</span></a>")
    //            .appendTo(ul);
    //            $(".ui-autocomplete .ui-menu ui-widget .ui-widget-content .ui-corner-all").focus();
    //        }
    //        $(".ui-autocomplete .ui-menu ui-widget .ui-widget-content .ui-corner-all").focus();
    //    };
    //
    //    $('#companyInfo input.ui-advance-autocomplete').bind('autocompleteselect', function(event, ui) {
    //        if (ui.item.value != null) {
    //            $(this).parent().next().val(ui.item.value.id);
    //        }
    //    });
    //
    //    $('#companyInfo input.ui-advance-autocomplete').bind('autocompletenotfound', function(event, ui) {
    //        new_company(event, ui.item.label);
    //    });
    //
    //
    //    $("#new_company").live("keydown", function(e){
    //        if(e.keycode == 13){
    //            $(this).parents("div.ui-dialog").hide("blind");
    //            return false;
    //        }
    //    });
    //
    //    $("#company_submit").live("click", function(e){
    //        $(this).parents("div.ui-dialog").hide("blind");
    //        return false;
    //    });
    //
    //    $("#new_contact").live("submit", function(){
    //        $("#new_company").trigger("submit");
    //    });

    //    $('#contact_company').bind('autocompleteselect', function(event, ui) {
    //        if (ui.item.value != null) {
    //            $('#contact_company_id').val(ui.item.value.id);
    //        }
    //        var a = $(this).parents("div").append("<a href='/contacts/"+ui.item.value.id+"/edit'>Edit</a>");
    //    });
    function new_company(event, value) {

        $.getScript('/companies/new', function(data) {
            $('#company_title').val(value);
        });
    }
    //    $("#addressInfo > div > div input,#opportunity-wizard > div > div select").removeAttr('required').removeClass("required");
    //
    //    function testFieldsValidation(el)
    //    {
    //        trueCount = 0;
    //
    //        inputList = $('#opportunity-wizard > div > div input,#opportunity-wizard > div > div select');
    //        for(i = 0; i < 6; i++)
    //        {
    //            if($(inputList[i]).val().length > 0 )
    //            {
    //                trueCount++;
    //            }
    //        }
    //        //        $('#opportunity-wizard > div > div input,select').each(function(){
    //        //           if($(this).val().lenght >  0 ) {
    //        //               trueCount++;
    //        //           }
    //        //        });
    //        return  (trueCount > 0 && trueCount < 6) ? false : true;
    //    }
    //    $.tools.validator.fn(
    //        "#opportunity-wizard > div > div input",
    //        "Please complete this mandatory field",
    //        function(el, v) {
    //            if( !testFieldsValidation(el) && ($(el).val().length == 0 ) )
    //                return false;
    //            else
    //                return true;
    //        });
    //    $.tools.validator.fn(
    //        "#opportunity-wizard > div > div select",
    //        "Please Select this mandatory field",
    //        function(el, v) {
    //            if( !testFieldsValidation(el) && ($(el).val().length == 0 ) )
    //                return false;
    //            else
    //                return true;
    //        });

    //    var currrenElementIndex = 0;
    //    var addressInfostateList = new Array ();
    //    var validated = false;
    //    var group
    //    function testOptionalFieldsValidation(el){
    //        var currentStateList = $("#addressInfo .field select, #addressInfo .field input[type!='hidden']") ;
    //        var sizeofCurrentStateList = currentStateList.length ;
    //        var numberOfAddressGroups = sizeofCurrentStateList / 6 ;
    //        var groupOfAddressInfoList = new Array ();
    //        var stateList = new Array();
    //        for(i = 0; i < sizeofCurrentStateList; i++){
    //            stateList[i] = ($(currentStateList[i]).val().length > 0 ) ?  true :  false;
    //        }
    //
    //        for( j = 0; j < numberOfAddressGroups; j++ )
    //        {
    //            var trueCount = 0;
    //            for( k = j*6; k < ((j + 1) * 6); k++ )
    //                ( stateList[k] ) ? trueCount++ : trueCount;
    //            groupOfAddressInfoList[k] = ( trueCount > 0 && trueCount < 6 ) ? true : false ;
    //        }
    //        currrenElementIndex++;
    //        for (l = 0; l < numberOfAddressGroups; l++ )
    //        {
    //            if(!groupOfAddressInfoList[l])
    //            {
    //
    //                console.log('Element Value'+(currrenElementIndex-1)+' '+stateList[currrenElementIndex-1]+'Address Group'+l)
    //                if((currrenElementIndex-1) < ((l+1)*6))
    //                {
    //                    return stateList[currrenElementIndex-1];
    //                }
    //            }else
    //            {
    //                return true;
    //            }
    //
    //        }
    //        validated = true;
    //        currrenElementIndex = sizeofCurrentStateList-1;
    //    }

        var fieldsSynced = false;
    
    function testOptionalFieldsValidation(el){
        if(!fieldsSynced){
            $.tools.validator.fn(
                $("#addressInfo .field select, #addressInfo .field input[type!='hidden']"),
                "Please Complete this mandatory field",
                function(el, v){
                    if( !testOptionalFieldsValidation(el) && ($(el).val().length == 0 ) )
                        return false;
                    else
                        return true;
                }
                );
            fieldsSynced = true;
        }
        group = getGroup(el);
        return validateGroup(group);
    }

    function getGroup(el){
        return $(el).parents('.field');
    }

    function validateGroup(group){
        var count = 0;
        $(group).find("input[type!='hidden'], select").each(function(){
            if( $(this).val() )
                count++;
        });
        if($(group).find("input[type!='hidden'], select").length == count || count == 0)
            return true;
        else
            return false;
    }
  
//        $.tools.validator.fn(
//            $("#addressInfo .field select, #addressInfo .field input[type!='hidden']"),
//            "Please Complete this mandatory field",
//            function(el, v){
//                if( !testOptionalFieldsValidation(el) && ($(el).val().length == 0 ) )
//                    return false;
//                else
//                    return true;
//            }
//            );
//
//    $('#addressInfo div.links .add').live('click',function(){
//        $('form').validator();
//        $.tools.validator.fn(
//            $("#addressInfo .field select, #addressInfo .field input[type!='hidden']"),
//            "Please Complete this mandatory field",
//            function(el, v){
//                if( !testOptionalFieldsValidation(el) && ($(el).val().length == 0 ) )
//                    return false;
//                else
//                    return true;
//            }
//            );
//        fieldsSynced = false;
//    });
    $('form').submit(function(){
        if($('form').data('validator').checkValidity())
        {
            return true;
        }
        else
        {
            return false;
        }
    });

});
