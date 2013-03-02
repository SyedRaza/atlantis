$(document).ready(function(){
    //    $("select").combobox();
    var heading_start = $("#heading").text()
    if ($("#vteam_lead_id option:selected").text() != "")
    $("#heading").text(heading_start +" against "+ $("#vteam_lead_id option:selected").text());
    
    $("#vteam_lead_id").combobox();
    $("input.select").bind("autocompleteselect",function(){
      $("#heading").text(heading_start +" against "+ $(this).val());
    });
    $(".datepicker").datepicker();

    $("#vteam_opportunity_submit").live("click", function(e){
        $("#query").attr("value", "create_opportunity");
    });
    $("select#vteam_lead_id").removeClass("required");
    $("input.select.required.ui-autocomplete-input.ui-widget..ui-advance-autocomplete").attr("required", "required");
    $('form').validator();
});
