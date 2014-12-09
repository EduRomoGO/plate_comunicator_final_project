var map;
function initialize() {
		var mapOptions = {
		zoom: 8,
		center: new google.maps.LatLng(-34.397, 150.644)
	};
	map = new google.maps.Map(document.getElementById('map_canvas'),mapOptions);
}

google.maps.event.addDomListener(window, 'load', initialize);



function push_pins_marker(latitude, longitude) {

	new google.maps.Marker({
		position: new google.maps.LatLng(latitude,longitude),
		map 	: map
	});

}