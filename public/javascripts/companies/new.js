/**
 * Created by .
 * User: Syed Raza Khalid
 * Date: Jan 10, 2011
 * Time: 4:47:50 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function() {
    
    // Initlize Google map location according to given address details
    $('.zip').live('blur', function() {
        root = $(this).parents('.field');
        address = root.find('#street').val() + ' ' + root.find('#city').val() + "," + root.find('#state').val() + ' ' + root.find('#zip').val() + ' , ' + root.find('#country :selected').text();
        root.find('.address-map').gMap().geoCodeAndMark(address, function(lat, lng, address) {
            root.find('#lat').val(lat);
            root.find('#lng').val(lng);
        });
    });

    $('.auto').combobox();
    

    
});
