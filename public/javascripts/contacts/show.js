/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {

    //    $(".simple_form").hide();

    //    $(".contact_note").bind("dblclick", function() {
    //        var value = $(this).find("dd.content").text();
    //        $(this).hide();
    //        $("#contact_note").val(value);
    //        $(".simple_form").show();
    //        $(":submit").css("display", "none");
    //        $("#contact_note").focus();
    //    });
    //
     $('.lead_list_detail').collapsorz({
        minimum: 3
    });
    $('#contact_note').live('blur', function() {
        
        $('#contact_submit').parents('form').submit();
    });
//    $( "#filter-type" ).buttonset();
//    $("#filter-type >label").first().trigger("click");
//    $("#filter-type >input").first().trigger("click");
//    $('.simple_form').submit(function() {
//
//        $(".contact_note > dd.content").text($("#contact_note").val());
//        $('.simple_form').hide();
//        $('.contact_note').show();
//        $(this).callRemote();
//    });

});