/* jQuery googleMap Copyright Dylan Verheul <dylan@dyve.net>
 * Licensed like jQuery, see http://docs.jquery.com/License
 *
 * Modified By: Raza Khalid
 */
$(document).ready(function() {

    $.gMap = {
        map : null,
        geoCode : function(address, callback) {
            $.gMapData.geocoder.geocode({ 'address': address}, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    return results[0].geometry.location;
                    callback(results[0].geometry.location.lat(), results[0].geometry.location.lng(), address);
                } else {
                    return null;
                }
            });
        },
        geoCodeAndMark : function(address, callback) {
            $.gMapData.geocoder.geocode({ 'address': address}, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    var marker = new google.maps.Marker({
                        position: results[0].geometry.location,
                        map: $.gMap.map,
                        title:"Hello World!"
                    });
                    $.gMap.map.setCenter(results[0].geometry.location);
                    callback(results[0].geometry.location.lat(), results[0].geometry.location.lng(), address);
                } else {
                    return null;
                }
            });
        }
    };

    $.gMapData = {
        geocoder : null,
        maps: {},
        marker: function(m) {
            if (!m) {
                return null;
            } else if (m.lat == null && m.lng == null) {
                return $.gMap.marker($.gMap.readFromGeo(m));
            } else {
                var marker = new google.maps.Marker(new google.maps.LatLng(m.lat, m.lng));
                if (m.txt) {
                    var infowindow = new google.maps.InfoWindow({
                        content: m.txt
                    });
                    google.maps.event.addListener(marker, 'click', function() {
                        infowindow.open(map, marker);
                    });
                }
                return marker;
            }
        },
        readFromGeo: function(elem) {
            var latElem = $(".latitude", elem)[0];
            var lngElem = $(".longitude", elem)[0];
            if (latElem && lngElem) {
                return { lat:parseFloat($(latElem).attr("title")), lng:parseFloat($(lngElem).attr("title")), txt:$(elem).attr("title") }
            } else {
                return null;
            }
        },
        mapNum: 1
    };

    $.fn.gMap = function (lat, lng, zoom, options) {

        if( !google ){
            return;
        } 

        // Google Map Initialization Options
        var myMapOptions = {
            mapOptions :{
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }
        };
        $.gMapData.geocoder = new google.maps.Geocoder();

        if ( options == null )
            options = myMapOptions;

        if (lat == null && lng == null && zoom == null && options == null) {
            $.gMap.map = $.gMapData.maps[this[0].id];
            return $.gMap;
        }


        // Default values make for easy debugging
        if (lat == null) lat = 37.4419;
        if (lng == null) lng = -122.1419;
        if (!zoom) zoom = 13;

        // Sanitize options
        if (!options || typeof options != 'object')    options = {};
        options.mapOptions = options.mapOptions || {};
        options.markers = options.markers || [];
        options.controls = options.controls || {};

        // Map all our elements
        return this.each(function() {
            // Make sure we have a valid id
            if (!this.id) this.id = "gMap" + $.gMapData.mapNum;
            $(this).attr('id', this.id);
            $.gMapData.mapNum = $.gMapData.mapNum + 1;
            // Create a map and a shortcut to it at the same time
            var map = $.gMapData.maps[this.id] = new google.maps.Map(this, options.mapOptions);
            // Center and zoom the map
            map.setCenter(new google.maps.LatLng(lat, lng));
            map.setZoom(zoom);
            // Add controls to our map
            for (var i = 0; i < options.controls.length; i++) {
                var c = options.controls[i];
                obj = eval("new google.maps." + c + "();");
                obj.map = map;
            }
            // If we have markers, put them on the map
            var marker = null;
            for (i = 0; i < options.markers.length; i++) {
                if (marker = $.gMapData.marker(options.markers[i])) marker.map = map;
                //if (marker = $.googleMap.marker(options.markers[i])) map.addOverlay(marker);
            }
        });

    };


});