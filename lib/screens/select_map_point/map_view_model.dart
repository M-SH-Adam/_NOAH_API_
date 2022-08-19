import 'package:ark_2/app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../classes/formsFunction/MapFunctions.dart';
import '../../repository/location_repository.dart';
import '../../theme/custom_assets.dart';

class MapViewModel extends ChangeNotifier {
  GoogleMapController? controller;

  String locationAddress = "Search...";

  LatLng? locationLatLng;
  Position? myPosition;
  BitmapDescriptor? markerIcon;
  Marker? locationMarker;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  LatLng? markerPosition;
  Position? position;

  MapViewModel() {
    _setMarkerIcon();
    _getPosition();
  }

  _setMarkerIcon() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, CustomAssets.pinMarker);
  }

  void onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  _getPosition() async {
    Position myCurrentPosition = await LocationRepository.getCurrentLocation();
    position = myCurrentPosition;
    myPosition = myCurrentPosition;
    setMarker(LatLng(myCurrentPosition.latitude, myCurrentPosition.longitude));
  }

  void setMarker(LatLng latLng, {bool setAddress = true}) {
    String markerIdVal = 'location';
    locationLatLng = latLng;
    Marker pickUpMarker = _getMarker(latLng, markerIdVal);
    markers = {};
    markers[pickUpMarker.markerId] = pickUpMarker;
    locationMarker = pickUpMarker;
    _setPosition(latLng, setAddress: setAddress);
  }

  Marker _getMarker(LatLng latLng, String id) {
    final Marker marker = MapFunctions().getMovingMarker(
      latLng,
      id,
      (markerId, LatLng position) => _onMarkerDragEnd(markerId, position),
      (markerId, LatLng position) => _onMarkerDrag(markerId, position),
    );
    return marker.copyWith(iconParam: markerIcon);
  }

  _setPosition(LatLng latLng, {bool setAddress = true}) {
    position = Position.fromMap(
        {"latitude": latLng.latitude, "longitude": latLng.longitude});
    if (setAddress) {
      locationAddress = "${latLng.latitude} , ${latLng.longitude}";
    } else {
      print("change camera position");
      controller!.animateCamera(CameraUpdate.newLatLng(latLng));
    }
    notifyListeners();
  }

  void _onMarkerDrag(MarkerId markerId, LatLng newPosition) async {
    markerPosition = newPosition;
    notifyListeners();
  }

  void _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      markerPosition = null;
      notifyListeners();
    }
  }

  Future<void> handlePressButton(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: Global.googleMapApiKey,
      onError: onError,
      mode: Mode.overlay,
      types: [],
      language: "en",
      strictbounds: false,
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "eg")],
    );

    _displayPrediction(p);
  }

  Future _displayPrediction(Prediction? p) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: Global.googleMapApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      _setAddressData(detail);
    }
  }

  _setAddressData(PlacesDetailsResponse detail) {
    locationLatLng = LatLng(detail.result.geometry!.location.lat,
        detail.result.geometry!.location.lng);
    setMarker(locationLatLng!, setAddress: false);
    locationAddress = detail.result.formattedAddress!;
    notifyListeners();
  }

  void onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage);
  }
}
