$(document).ready(function() {

    $(".optionCompanyList").css('display', 'none');
    var selectionCompany = false;

    function clearCompanyform() {
        $("#lead_company_id").val("");
        $("#lead_company").val("");
        $("#lead_company_attributes_title").val("");
        $("#lead_company_attributes_industry_id").val("");
        $("#lead_company_attributes_phones_attributes_0_phone_type_id").val("");
        $("#lead_company_attributes_phones_attributes_0_phone_number").val("");
        $("#lead_company_attributes_phones_attributes_0_id").val("");
        $("#lead_company").parent("div").find("a").remove();
    }

    function clearContactform() {
        $(this).parent("div").find("a").remove();
        $('#lead_contact_id').val("");
        $("#lead_contact_attributes_phones_attributes_0_phone_type_id").val("");
        $("#lead_contact_attributes_phones_attributes_0_phone_number").val("");
        $("#lead_contact_attributes_phones_attributes_0_id").val("");
        $("#lead_contact_attributes_emails_attributes_0_id").val("")
        $("#lead_contact_attributes_emails_attributes_0_email_type_id").val("");
        $("#lead_contact_attributes_emails_attributes_0_email").val("");
        $("#lead_contact_attributes_emails_attributes_0_id").val("");
        $("#lead_contact_attributes_messengers_attributes_0_id").val("");
        $("#lead_contact_attributes_messengers_attributes_0_messenger_type_id").val("");
        $("#lead_contact_attributes_messengers_attributes_0_messenger_service_id").val("");
        $("#lead_contact_attributes_messengers_attributes_0_title").val("");

    }

    $('#lead_company').autocomplete({
        minLength: 1,
        source:function(request, response) {
            $.getJSON("/companies", request, function(data, status, xhr) {
                if (data.length > 0) {
                    response($.map(data, function(item) {
                        return {
                            label: item.company.title,
                            value: item.company
                        }
                    }));
                } else {
                    response([
                        {
                            label: $('#lead_company').val(),
                            value: null
                        }
                    ]);
                }
            });
        },
        focus: function(event, ui) {
            selectionCompany = false;
            $(event.target).val(ui.item.label);
            return false;
        },
        open:function(event, ui) {
            selectionCompany = false;
            $(this).parent("div").find("a").remove();
            $("#lead_company_id").attr("value", "");
            return false;
        },
        close:function(event, ui) {
            if (!selectionCompany) {
                $(this).parent("div").find("a").remove();
                $(this).val("");
            }
        }
        ,
        select: function(event, ui) {
            selectionCompany = true;
            if (ui.item.value == null) {
                $(event.target).trigger('autocompletenotfound', ui);
                event.preventDefault();
                event.stopPropagation();
                event.stopImmediatePropagation();
                return false;
            } else {
                $(this).parent("div").append("<a id='toggle-edit-company' href='#'>Edit</a>");
                $(event.target).val(ui.item.label);
                return false;
            }
        }
    }).data("autocomplete")._renderItem = function(ul, item) {
        if (item.value == null) {
            return $("<li></li>")
                    .data("item.autocomplete", item)
                    .append("<a>Create New <strong>" + item.label + "</strong></a>")
                    .appendTo(ul);
        } else {
            return $("<li></li>")
                    .data("item.autocomplete", item)
                    .append("<a><span class='auto-column'>" + item.label + "</span></a>")
                    .appendTo(ul);
        }

    };
    var selectionContact = false;

    $('#lead_contact').autocomplete({
        minLength: 1,
        source:function(request, response) {

            $.getJSON("/contacts", request, function(data, status, xhr) {
                if (data.length > 0) {
                    response($.map(data, function(item) {
                        return {
                            label: item.contact.first_name + ' ' + item.contact.last_name,
                            value: item.contact,
                            companies: item.contact.companies
                        }
                    }));
                } else {
                    response([
                        {
                            label: $('#lead_contact').val(),
                            value: null
                        }
                    ]);

                }
            });
        },
        focus: function(event, ui) {
            selectionContact = false;
            $(event.target).val(ui.item.label);
            return false;
        },
        open:function(event, ui) {
            selectionContact = false;
            $(this).parent("div").find("a").remove();
            $("#lead_company").val("");
            $("#lead_company").parent("div").find("a").remove();
            return false;
        },
        close:function(event, ui) {
            if (!selectionContact) {
                $(this).parent("div").find("a").remove();
                $(this).val("");
            }
        }
        ,
        select: function(event, ui) {
            selectionContact = true;
            if (ui.item.value == null) {
                $(event.target).trigger('autocompletenotfound', ui);
                //        if($("#new_contact_dialog")){$("#new_contact_dialog").parents("div.ui-dialog").toggle("blind");}

                event.preventDefault();
                event.stopPropagation();
                event.stopImmediatePropagation();
                return false;
            } else {
                $(event.target).val(ui.item.label);

                return false;
            }
        }
    }).data("autocomplete")._renderItem = function(ul, item) {
        if (item.value == null) {
            return $("<li></li>")
                    .data("item.autocomplete", item)
                    .append("<a>Create New <strong>" + item.label + "</strong></a>")
                    .appendTo(ul);
        } else {
            li = $('<li />');
            li.data("item.autocomplete", item);
            c1 = "<span class='auto-column'>" + item.value.first_name + " " + item.value.last_name + "</span>";
            if (item.value.emails.length > 0)
                c2 = "<span class='auto-column small'>" + item.value.emails[0].email + "</span>";
            else
                c2 = "<span class='auto-column small'>No email specified</span>";
            if (item.value.companies.length > 0)
                c3 = "<span class='auto-column small'>" + item.value.companies[0].title + "</span>";
            else
                c3 = "<span class='auto-column small'>No company specified</span>";
            li.append('<a>' + c1 + c2 + c3 + '</a>');
            li.appendTo(ul);
            return li;
        }
    };
    $('#lead_contact_attributes_first_name').removeAttr('required').removeClass('required');
    $('#lead_contact_attributes_last_name').removeAttr('required').removeClass('required');
    $('#lead_company_attributes_title').removeAttr('required').removeClass('required');

    $("form#new_lead").submit(function(e) {
        if ($("form#new_lead").data('validator').checkValidity()) {
            return true
        }
        else {
            return false;
        }
    });
    //    $("#opportunity-wizard > div > div input,#opportunity-wizard > div > div select").removeAttr('required').removeClass("required");
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


    // 1st argument provides the function matcher


    $('#lead_company').bind('autocompleteselect', function(event, ui) {
        if (ui.item.value != null) {
            $('#lead_company_attributes_title').removeAttr('required').removeClass('required');
            $('#lead_company_id').val(ui.item.value.id);
            $(this).parent("div").find("a").remove();

            // var a = $(this).parent("div").append("<a id='"+ui.item.value.id+"' href='/companies/"+ui.item.value.id+"/edit'>Edit</a>");


            // var a = $(this).parent("div").append("<a id='"+ui.item.value.id+"' href='/companies/"+ui.item.value.id+"/edit'>Edit</a>");

        }
    });

    $('#lead_company').bind('autocompletenotfound', function(event, ui) {

        $('#lead_company_attributes_title').attr('required', 'required').addClass('required');
        $(this).parent("div").find("a").remove();
        $('#lead_company_id').val("")
        $("#lead_company_attributes_industry_id").val("");
        $("#lead_company_attributes_phones_attributes_0_phone_type_id").val("");
        $("#lead_company_attributes_phones_attributes_0_phone_number").val("");
        $("#lead_company_attributes_phones_attributes_0_id").val("");

        new_company(event, ui.item.label);
    });

    $('#lead_contact').bind('autocompleteselect', function(event, ui) {
        clearContactform();
        clearCompanyform();
        if (ui.item.value != null) {
            $('#lead_contact_attributes_first_name').removeAttr('required').removeClass('required');
            $('#lead_contact_attributes_last_name').removeAttr('required').removeClass('required');
            $('#lead_contact_id').val(ui.item.value.id);
            $("#lead_contact_attributes_first_name").css('border', '1px solid #888888').val(ui.item.value.first_name);
            $("#lead_contact_attributes_last_name").css('border', '1px solid #888888').val(ui.item.value.last_name);

            if (ui.item.value.phones.length > 0) {
                $("#lead_contact_attributes_phones_attributes_0_phone_type_id").val(ui.item.value.phones[0].phone_type_id);
                $("#lead_contact_attributes_phones_attributes_0_phone_number").val(ui.item.value.phones[0].phone_number);
                $("#lead_contact_attributes_phones_attributes_0_id").val(ui.item.value.phones[0].id);
            }
            if (ui.item.value.emails.length > 0) {
                $("#lead_contact_attributes_emails_attributes_0_id").val(ui.item.value.emails[0].id);
                $("#lead_contact_attributes_emails_attributes_0_email").val(ui.item.value.emails[0].email);
                $("#lead_contact_attributes_emails_attributes_0_email_type_id").val(ui.item.value.emails[0].email_type_id);
            }
            if (ui.item.value.messengers.length > 0) {
                $("#lead_contact_attributes_messengers_attributes_0_id").val(ui.item.value.messengers[0].id);
                $("#lead_contact_attributes_messengers_attributes_0_messenger_type_id").val(ui.item.value.messengers[0].messenger_type_id);
                $("#lead_contact_attributes_messengers_attributes_0_messenger_service_id").val(ui.item.value.messengers[0].messenger_service_id);
                $("#lead_contact_attributes_messengers_attributes_0_title").val(ui.item.value.messengers[0].title);
            }
            $('#lead_opportunities_attributes_0_source_title').val($('#lead_contact').val());
            $('#lead_opportunities_attributes_0_source_title').attr('readonly', true);
            $("#lead_contact").parent("div").find("a").remove();
            $("#lead_contact").parent("div").append("<a id='toggle-edit-contact' href='#'>Edit</a>");
            if (ui.item.companies) {
                if (ui.item.companies.title != "") {
                    /*
                     $("#lead_company").val(ui.item.companies[1].title);

                     $("#lead_company_attributes_title").val(ui.item.companies[1].title);
                     $("#lead_company_attributes_industry_id").val(ui.item.companies[1].title);
                     $("#lead_company_attributes_phones_attributes_0_phone_type_id").val("");
                     $("#lead_company_attributes_phones_attributes_0_phone_number").val("");
                     $("#lead_company_id").val(ui.item.companies[1].id);
                     $("#lead_company").parent("div").append("<a id='toggle-edit-company' href='#'>Edit</a>");
                     */
                    /* for(i=0;i<= ui.item.companies.length;i++){
                     $('#showcompanies').
                     append($("<option></option>").
                     attr("value", ui.item.companies[i].id).
                     text(ui.item.companies[i].title)

                     );
                     }*/
                    if (1 < ui.item.companies.length) {
                        $(".optionCompanyList").css({
                            'display':'block',
                            'margin-bottom' : '18px'
                        });
                        $(".input.string.required:nth-child(2)").show();
                        $.each(ui.item.companies, function(key, value) {
                            $('#lead_contact_companies').
                                    append($("<option></option>").
                                    attr("value", value.id).
                                    text(value.title)

                                    );

                        });
                        $("#lead_company").val(ui.item.companies[0].title);
                        $("#lead_company_id").val(ui.item.companies[0].id);
                        $("#lead_company").parent("div").append("<a id='toggle-edit-company' href='#'>Edit</a>");
                        $("#lead_company_attributes_title").val(ui.item.companies[0].title);
                        $("#lead_company_attributes_industry_id").val(ui.item.companies[0].title);

                    } else if (ui.item.companies.length > 0) {
                        $("#lead_company").val(ui.item.companies[0].title);

                        $("#lead_company_attributes_title").val(ui.item.companies[0].title);
                        $("#lead_company_attributes_industry_id").val(ui.item.companies[0].title);
                        $("#lead_company_attributes_phones_attributes_0_phone_type_id").val("");
                        $("#lead_company_attributes_phones_attributes_0_phone_number").val("");
                        $("#lead_company_attributes_phones_attributes_0_id").val("");
                        $("#lead_company_id").val(ui.item.companies[0].id);
                        $("#lead_company").parent("div").append("<a id='toggle-edit-company' href='#'>Edit</a>");

                    }
                    //$("#lead_company").parent("div").append("<a href='/companies/"+ui.item.companies.id+"/edit' id=''>Edit</a>");
                }
            }


            //            $(this).parent("div").find("a").remove();
            //            var a = $(this).parent("div").append("<a id='"+ui.item.value.id+"' href='/contacts/"+ui.item.value.id+"/edit'>Edit</a>");
        }
    });
    $('#lead_contact_companies').change(function() {
        $("#lead_company").val("");
        $("#lead_company_id").val($('#lead_contact_companies option:selected').val());
        $("#lead_company").val($('#lead_contact_companies option:selected').text());
        $("#lead_company_attributes_title").val($('#lead_contact_companies option:selected').text());
        $("#lead_company_attributes_industry_id").val($('#lead_contact_companies option:selected').val());
    });

    $('#lead_contact').bind('autocompletenotfound', function(event, ui) {
        $('#lead_contact_attributes_first_name').attr('required', 'required').addClass('required');
        $('#lead_contact_attributes_last_name').attr('required', 'required').addClass('required');

        clearContactform();
        new_contact(event, ui.item.label);
    });


    //    $("#lead_created_effective").bind('change',function(){
    //        currentDate = new Date($(this).val());
    //        currentDate.setMonth((currentDate.getMonth()+1), currentDate.getDate());
    //        $("#lead_expiry_date").datepicker('setDate',currentDate);
    //    });

    //    $("#opportunity-form").hide();
    //
    //    $("#inline-opportunity").live("click", function(e){
    //        $("#opportunity-form").children().each(function(){
    //            $(this).trigger("keyup");
    //        });
    //        $("#opportunity-form").toggle("blind");
    //        if($(this).text() == "Show Form"){
    //            $(this).text("Hide Form");
    //        }else if($(this).text() == "Hide Form"){
    //            $(this).text("Show Form");
    //        }
    //        e.preventDefault();
    //    });


    //save & create opportunity
    $("#lead_company").bind("blur", function(event, ui) {
        if ($("#lead_company").val() == "")
            clearCompanyform();
    });


    $("#lead_opportunity_submit").live("click", function(e) {
        $("#query").attr("value", "create_opportunity");
        //$("#lead_opportunity").parents("form").submit();
        ///e.preventDefault();
    });


    $("#new_contact").hide();
    $("#new_company").hide();
    $("#new_contact").draggable();
    $("#new_company").draggable();

    $("#save-contact").live("click", function() {
        if ($("#lead_contact_attributes_first_name").val().length > 0 && $("#lead_contact_attributes_last_name").val().length > 0) {
            $("#lead_contact").val($("#lead_contact_attributes_first_name").val() + " " + $("#lead_contact_attributes_last_name").val())
            $("#new_contact").toggle("blind");
            $("#lead_contact").parent("div").find("a").remove();
            $("#lead_contact").parent("div").append("<a id='toggle-edit-contact' href='#'>Edit</a>");
            $("#lead_company").focus();
        }
        else {
            ($("#lead_contact_attributes_first_name").val().length == 0 ) ? $("#lead_contact_attributes_first_name").css('border', '1px solid #F00') : $("#lead_contact_attributes_last_name").css('border', '1px solid #F00');
        }
    });
    $("#save-company").live("click", function() {
        if ($("#lead_company_attributes_title").val().length > 0) {
            $("#lead_company").val($("#lead_company_attributes_title").val());
            $("#new_company").toggle("blind");
            $("#lead_company").parent("div").find("a").remove();
            $("#lead_company").parent("div").append("<a id='toggle-edit-company' href='#'>Edit</a>");
            $("#lead_lead_status_id").focus();
        }
        else {
            $("#lead_company_attributes_title").css('border', '1px solid #F00');
        }
    });
//        $("#toggle-edit-contact").live("click", function(){
//        $("#new_contact_dialog").parents("div.ui-dialog").toggle("blind");
//    });
//
//    $("#toggle-edit-company").live("click", function(){
//        $("#new_company_dialog").parents("div.ui-dialog").toggle("blind");
//    });

    $("#toggle-edit-contact").live("click", function() {
        $("#new_contact").toggle("blind");
    });
    $("#toggle-edit-company").live("click", function() {
        var valueId = $("#lead_company_id").val();
        var requestedURL = "/companies/" + valueId;
        $("#lead_company_attributes_title").val($("#lead_company").val());
        if (valueId != '') {
            $.getJSON(requestedURL, function(data) {
                $("#lead_company_attributes_industry_id").val(data.company.industry_id);
                if (data.company.phones.length > 0) {
                    $("#lead_company_attributes_phones_attributes_0_phone_type_id").val(data.company.phones[0].phone_type_id);
                    $("#lead_company_attributes_phones_attributes_0_phone_number").val(data.company.phones[0].phone_number);
                    $("#lead_company_attributes_phones_attributes_0_id").val(data.company.phones[0].id);
                }
                $("#new_company").toggle("blind");
            });
        }
        else
            $("#new_company").toggle("blind");
    });

    $("#clear-contact").live("click", function() {
        $("#new_contact").toggle("blind");
        if ($('#lead_contact_id').val() == "") {
            $("#lead_contact").val("");
            $("#lead_contact_attributes_first_name").val("");
            $("#lead_contact_attributes_last_name").val("");
            $("#lead_contact_attributes_phones_attributes_0_phone_type_id").val("");
            $("#lead_contact_attributes_phones_attributes_0_phone_number").val("");
            $("#lead_contact_attributes_emails_attributes_0_email_type_id").val("");
            $("#lead_contact_attributes_emails_attributes_0_email").val("");
            $("#lead_contact_attributes_messengers_attributes_0_messenger_type_id").val("");
            $("#lead_contact_attributes_messengers_attributes_0_messenger_service_id").val("");
            $("#lead_contact_attributes_messengers_attributes_0_title").val("");
            $("#lead_contact").parent("div").find("a").remove();
        }

        $("#lead_contact").focus();
    });
    $("#clear-company").live("click", function() {
        $("#new_company").toggle("blind");
        if ($('#lead_company_id').val() == "") {
            $("#lead_company").val("");
            $("#lead_company_attributes_title").val("");
            $("#lead_company_attributes_industry_id").val("");
            $("#lead_company_attributes_phones_attributes_0_phone_type_id").val("");
            $("#lead_company_attributes_phones_attributes_0_phone_number").val("");
            $("#lead_company").parent("div").find("a").remove();
        }

        $("#lead_company").focus();
    });

});
function new_contact(event, value) {
    var check = $("#lead_contact").val().split(" ");
    $("#new_contact").show();

    $("#lead_contact_attributes_first_name").css('border', '1px solid #888888').val(check[0]).focus();
    $("#lead_contact_attributes_last_name").css('border', '1px solid #888888').val(check[1]);
}
function new_company(event, value) {
    var title = $("#lead_company").val();
    $("#new_company").show();
    $("#lead_company_attributes_title").css('border', '1px solid #888888').val(title).focus();
}
function trim(str) {
    return str.replace(/^\s+|\s+$/g, "");
}
