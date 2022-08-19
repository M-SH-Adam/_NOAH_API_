import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapFunctions {
  static GoogleMapController? _controller;
  static Set<Marker> _markers = {};

  static Widget buildMap() {
    //getLocation();
    return GoogleMap(
        zoomControlsEnabled: true,
        initialCameraPosition: const CameraPosition(
          target: LatLng(51.5, -0.09),
          zoom: 12.0,
        ),
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: _markers,
      );
  }

  Marker getMovingMarker(LatLng latLng, String id,Function _onMarkerDrag,Function _onMarkerDragEnd) {
    MarkerId markerId = MarkerId(id);
    final Marker marker = Marker(
      markerId: markerId,
      position: latLng,
      draggable: true,
      infoWindow: InfoWindow(title: id),
      onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
      onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );
    return marker;
  }

  Marker getMarker(LatLng latLng, String id) {
    MarkerId markerId = MarkerId(id);
    final Marker marker = Marker(
      markerId: markerId,
      position: latLng,
      draggable: false,
      infoWindow: InfoWindow(title: id),
    );
    return marker;
  }

  // static void getLocation() async {
  //   var location = await currentLocation.getLocation();
  //   currentLocation.onLocationChanged.listen((LocationData loc) {
  //     _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
  //       zoom: 12.0,
  //     )));
  //     _markers.add(Marker(
  //         markerId: const MarkerId('Home'),
  //         position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
  //   });
  // }
}
