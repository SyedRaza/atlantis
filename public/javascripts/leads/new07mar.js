$(document).ready(function() {
    var selectionCompany = false;
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
        if(!selectionCompany){
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
        if($("#new_company_dialog")){
        $("#new_company_dialog").parents("div.ui-dialog").remove();
        $("#new_company_dialog").remove();
        }
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
                companies: item.contact.companies[0]
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
        if(!selectionContact){
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
        if($("#new_contact_dialog")){
        $("#new_contact_dialog").parents("div.ui-dialog").remove();
        $("#new_contact_dialog").remove();
        }
        if(ui.item.companies){
        if(ui.item.companies.title !=""){
        $("#lead_company").val(ui.item.companies.title);
        $("#lead_company_id").val(ui.item.companies.id);
        $("#lead_company").parent("div").append("<a href='/companies/"+ui.item.companies.id+"/edit' id=''>Edit</a>");
        }
        }
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

    $("#contact_submit").live("click", function(){
        if($("#contact_first_name").val().length!=0 && $("#contact_last_name").val().length!= 0){
            $(this).parents("div.ui-dialog").hide("blind");
            $("#lead_contact").parent("div").find("a").remove();
            var a = $("#lead_contact").parent("div").append("<a id='toggle-edit-contact' href='#'>Edit</a>");
            $("#lead_company").focus();
            $("#lead_contact").val($("#contact_first_name").val() +" "+ $("#contact_last_name").val());
        }else{
            if($("#contact_first_name").val().length == 0){
                $("#contact_first_name").css("border-color","red");
                $("#contact_first_name").focus();
            }
            if($("#contact_last_name").val().length == 0){
                $("#contact_last_name").css("border-color","red");
                $("#contact_last_name").focus();
            }
        }
        return false;
    });

    $("#new_contact").live("keydown", function(e){

        if(e.keycode == 13 && ($("#contact_first_name").val().length!=0 && $("#contact_last_name").val().length!= 0)){
            $(this).parents("div.ui-dialog").hide("blind");
            $("#lead_company").focus();
            $("#lead_contact").parent("div").find("a").remove();
            var a = $("#lead_contact").parent("div").append("<a id='toggle-edit-contact' href='#'>Edit</a>");
            $("#lead_contact").val($("#contact_first_name").val() + $("#contact_last_name").val());
        }else{
            if($("#contact_first_name").val().length == 0){
                $("#contact_first_name").css("border-color","red");
                $("#contact_first_name").focus();
            }
            if($("#contact_last_name").val().length == 0){
                $("#contact_last_name").css("border-color","red");
                $("#contact_last_name").focus();
            }
        }
    });

    $("#toggle-edit-contact").live("click", function(){
        $("#new_contact_dialog").parents("div.ui-dialog").toggle("blind");
    });

    $("#new_company").live("keydown", function(e){
        if(e.keycode == 13 && $("#company_title").val().length!= 0){
                $(this).parents("div.ui-dialog").hide("blind");
                $("#lead_company").parent("div").find("a").remove();
                var a = $("#lead_company").parent("div").append("<a id='toggle-edit-company' href='#'>Edit</a>");
                $("#lead_lead_status_id").focus();
                $("#lead_company").val($("#company_title").val());
        }else{
            if($("#company_title").val().length == 0){
                $("#company_title").css("border-color", "red");
                $("#company_title").focus();
            }
        }
    });

    $("#company_submit").live("click", function(){
        if($("#company_title").val().length!= 0){
            $("#lead_company").val($("#company_title").val());
            $(this).parents("div.ui-dialog").hide("blind");
            $("#lead_lead_status_id").focus();
            $("#lead_company").parent("div").find("a").remove();
            var a = $("#lead_company").parent("div").append("<a id='toggle-edit-company' href='#'>Edit</a>");
            }else{
                    if($("#company_title").val().length == 0){
                    $("#company_title").css("border-color", "red");
                    $("#company_title").focus();
                }
            }
            return false;
    });

    $("#toggle-edit-company").live("click", function(){
        $("#new_company_dialog").parents("div.ui-dialog").toggle("blind");
    });
    //    var valid = false;
    $('form#new_lead').live("submit",function(event){
        if($(this).data("validator").checkValidity()){

            if($("#new_contact_dialog").length > 0){
                if(($("#contact_first_name").val().length!=0 && $("#contact_last_name").val().length!= 0)){
//                if($("#new_company_dialog")){$("#company_check").attr("value", "1");}
                $("#new_contact").trigger("submit", $("#new_company").trigger("submit"));
                }else{
                    $("#new_contact_dialog").parents("div.ui-dialog").toggle("blind").focus();
                    return false;
                }
            }
            if($("#new_company_dialog").length > 0){
                if($("#company_title").val().length!= 0){
                    console.log("company title check")
                    $("#lead_company_id").attr("value", "");
                    $("#company_check").val("1");
                    $("#new_company").trigger("submit", $("#new_contact").trigger("submit"));
                }else{
                    $("#new_company_dialog").parents("div.ui-dialog").toggle("blind").focus();
                    return false;
                }
            }
            event.stopPropagation();
            $("#new_lead").trigger("submit");
        }
    });

//    $("#lead_submit").live("click", function(e){
//        e.preventDefault();
////        if($(this).data("validator").checkValidity()){
//            if($("#new_contact_dialog") && $("#new_company_dialog")){
//                console.log("both")
//                $("#company_check").val("1");
////                $("#new_contact").trigger("submit", $("#new_company").trigger("submit"));
//            }else if($("#new_company_dialog")){
//                console.log("company")
//                $("#company_check").val("1");
////                $("#new_company").trigger("submit");
//            }else if($("#new_contact_dialog")){
//                console.log("contact")
////                $("#new_contact").trigger("submit");
//            }
////        if($("#new_company_dialog")){$("#new_company").trigger("submit");$("#company_check").val("1")}
//            e.stopPropagation();
////            $("#new_lead").trigger("submit");
////        }
//    });

    $("#new_lead").live("keydown", function(event){
        if(event.keycode == 13){
            if($(this).data("validator").checkValidity()){
                if($("#new_contact_dialog").length > 0){
                    $("#new_contact").trigger("submit", $("#new_company").trigger("submit"));
                }
//        if($("#new_company_dialog")){$("#new_company").trigger("submit");}
                event.stopPropagation();
                $("#new_lead").trigger("submit");
            }
        }
    });
    //    $("#new_lead").live("submit", function(e){
    //        if($("#new_contact_dialog")){$("#new_contact").trigger("submit");}
    //        if($("#new_company_dialog")){$("#new_company").trigger("submit");}
    //        var errors = $("#new_lead").data("validator").checkValidity();
    //        console.log($.tools.validator.checkValidity())
    //        return false;
    //    });
    //    $.tools.validator.fn("#new_lead", function(input, value) {
    //        if($("#new_contact_dialog")){$("#new_contact").trigger("submit");}
    //        if($("#new_company_dialog")){$("#new_company").trigger("submit");}
    //        return true;
    //    });

    $('#lead_company').bind('autocompleteselect', function(event, ui) {
        if (ui.item.value != null) {
            $('#lead_company_id').val(ui.item.value.id);
            $(this).parent("div").find("a").remove();
            var a = $(this).parent("div").append("<a id='"+ui.item.value.id+"' href='/companies/"+ui.item.value.id+"/edit'>Edit</a>");
        }
    });

    $('#lead_company').bind('autocompletenotfound', function(event, ui) {
        $(this).parent("div").find("a").remove();
        new_company(event, ui.item.label);
    });

    $('#lead_contact').bind('autocompleteselect', function(event, ui) {
        if (ui.item.value != null) {
            $('#lead_contact_id').val(ui.item.value.id);
            $('#lead_opportunities_attributes_0_source_title').val($('#lead_contact').val());
            $('#lead_opportunities_attributes_0_source_title').attr('readonly', true);
            $(this).parent("div").find("a").remove();
            var a = $(this).parent("div").append("<a id='"+ui.item.value.id+"' href='/contacts/"+ui.item.value.id+"/edit'>Edit</a>");
        }
    });

    $('#lead_contact').bind('autocompletenotfound', function(event, ui) {
        $(this).parent("div").find("a").remove();
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
    $("#lead_opportunity_submit").live("click", function(e){
        $("#query").attr("value", "create_opportunity");
    //$("#lead_opportunity").parents("form").submit();
    ///e.preventDefault();
    });

//company form change event
//    $("#company_title").live("", function(){
//
//        });

//    $('#lead_lead_status_id').combobox();
//    $('#lead_lead_source_id').combobox();
//    $('#lead_lead_type_id').combobox();

});
function new_contact(event, value) {
    if($("#new_contact_dialog")){
        $("#new_contact_dialog").parents("div.ui-dialog").remove();
        $("#new_contact_dialog").remove();
    }
    $.getScript('/contacts/new', function(data) {
        var check = value.split(" ");
        //        if (check.length > 1 ){var first = check.slice(0, check.length -1);}
        //        first.join(" ");
        $('#contact_first_name').val(check[0]);
        $('#contact_last_name').val(check[1]);
        $("form#new_contact").validator();
    });
}
function new_company(event, value) {
    if($("#new_company_dialog")){
        $("#new_company_dialog").parents("div.ui-dialog").remove();
        $("#new_company_dialog").remove();
    }
    $.getScript('/companies/new', function(data) {
        $('#company_title').val(value);
        $("form#new_company").validator();
    });
}
function trim(str) {
    return str.replace(/^\s+|\s+$/g,"");
}
