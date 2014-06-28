// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require underscore
//= require gmaps/google
//= require foundation
//= require_tree .
$(function() {
  $(document).foundation();

var directionsDisplay = new google.maps.DirectionsRenderer();
var directionsService = new google.maps.DirectionsService();

function calcRoute() {
  var origin      = new google.maps.LatLng( 30.2671500, -97.7430600
);
  var destination = new google.maps.LatLng(42.850033, -85.6500523);
  var request = {
      origin:      origin,
      destination: destination,
      travelMode:  google.maps.TravelMode.DRIVING
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
  });
}

calcRoute();

var handler = Gmaps.build('Google');
handler.buildMap({ internal: {id: 'directions'}}, function(){
  directionsDisplay.setMap(handler.getMap());
});
    


    
    
    
// handler = Gmaps.build('Google');
// handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
//   markers = handler.addMarkers([
//     {
//       "lat": 0,
//       "lng": 0,
//       "picture": {
//         "url": "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
//         "width":  36,
//         "height": 36
//       },
//       "infowindow": "hello!"
//     }
//   ]);
//   handler.bounds.extendWith(markers);
//   handler.fitMapToBounds();
// });
});


