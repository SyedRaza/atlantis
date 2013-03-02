$(document).ready(function() {
    
//    $('#contact_contact_status_id').combobox();
//    $('#contact_contact_type_id').combobox({allow_new:true});
//    $('#contact_contact_directory_id').combobox();
    $('.auto').combobox();
    // Initlize Google map location according to given address details
    $('.zip').live('blur', function() {
        root = $(this).parents('.field');
        address = root.find('#street').val() + ' ' + root.find('#city').val() + "," + root.find('#state').val() + ' ' + root.find('#zip').val() + ' , ' + root.find('#country :selected').text();
        root.find('.address-map').gMap().geoCodeAndMark(address, function(lat, lng, address) {
            root.find('#lat').val(lat);
            root.find('#lng').val(lng);
        });
    });

    $("div.messenger > div:first > span.hint:first").css("margin-left", "0px");
});