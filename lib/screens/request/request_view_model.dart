import 'dart:async';

import 'package:ark_2/classes/formsFunction/MapFunctions.dart';
import 'package:ark_2/screens/my_animals/myAnimals_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../app/global_variables.dart';
import '../../app/routes.dart';
import '../../repository/location_repository.dart';
import '../../theme/custom_assets.dart';
import '../../viewModels/base_model.dart';

class RequestViewModel extends ChangeNotifier {
  StreamSubscription? _animalSubscription; // ignore: unused_field
  static List<Map<String, dynamic>> _animals = [];
  List selectedAnimals = [];
  final items = _animals
      .map((animal) => MultiSelectItem(animal, animal['Name']))
      .toList();

  final requestFormKey = GlobalKey<FormBuilderState>();
  String? selected;
  GoogleMapController? controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Set<Polyline> polyline = {};
  Position? position;
  List<LatLng> polylineCoordinates = [];
  LatLng? pickUpLatLng;
  LatLng? destinationLatLng;
  BitmapDescriptor? markerIcon;

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  Map<String, dynamic> fromAddressData = {};
  Map<String, dynamic> toAddressData = {};

  RequestViewModel() {
    _setMarkerIcon();
    _getPosition();
    _listenOnAnimal();
  }

  _listenOnAnimal() {
    _animalSubscription = eventBus.on<GetAnimals>().listen((event) {
      _getMyAnimals(event.animals);
    });
  }

  _getMyAnimals(List<Map<String, dynamic>> animals) {
    _animals = animals;
    notifyListeners();
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
    notifyListeners();
  }

  selectMapPoint(BuildContext context, String locationName) async {
    var result = await Navigator.pushNamed(context, Routes.selectMapPoint);
    if (result != null) {
      if (locationName == "from") {
        fromAddressData = result as Map<String, dynamic>;
        fromController.text = "${result["address"]}";
        pickUpLatLng = result["latLng"];
      } else {
        toAddressData = result as Map<String, dynamic>;
        toController.text = "${result["address"]}";
        destinationLatLng = result["latLng"];
      }
      _checkMarkers();
      notifyListeners();
    }
  }

  _checkMarkers() {
    if (pickUpLatLng != null && destinationLatLng != null) {
      polylineCoordinates = [];
      polyline = {};
      _getPolyline();
    }
  }

  _getPolyline() async {
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      Global.googleMapApiKey,
      PointLatLng(pickUpLatLng!.latitude, pickUpLatLng!.longitude),
      PointLatLng(destinationLatLng!.latitude, destinationLatLng!.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _setFinalMarkers();
    _addPolyLine();
  }

  _setFinalMarkers() {
    var pickUpMarker = MapFunctions().getMarker(pickUpLatLng!, "pickup");
    var destinationMarker =
        MapFunctions().getMarker(destinationLatLng!, "destination");
    markers = {};
    markers[pickUpMarker.markerId] =
        pickUpMarker.copyWith(iconParam: markerIcon);
    markers[destinationMarker.markerId] =
        destinationMarker.copyWith(iconParam: markerIcon);
    _setPolyCamera();
  }

  _setPolyCamera() {
    LatLngBounds bounds;
    if (pickUpLatLng!.latitude > destinationLatLng!.latitude &&
        pickUpLatLng!.longitude > destinationLatLng!.longitude) {
      bounds =
          LatLngBounds(southwest: destinationLatLng!, northeast: pickUpLatLng!);
    } else if (pickUpLatLng!.longitude > destinationLatLng!.longitude) {
      bounds = LatLngBounds(
          southwest:
              LatLng(pickUpLatLng!.latitude, destinationLatLng!.longitude),
          northeast:
              LatLng(destinationLatLng!.latitude, pickUpLatLng!.longitude));
    } else if (pickUpLatLng!.latitude > destinationLatLng!.latitude) {
      bounds = LatLngBounds(
          southwest:
              LatLng(destinationLatLng!.latitude, pickUpLatLng!.longitude),
          northeast:
              LatLng(pickUpLatLng!.latitude, destinationLatLng!.longitude));
    } else {
      bounds =
          LatLngBounds(southwest: pickUpLatLng!, northeast: destinationLatLng!);
    }
    controller!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 3,
        jointType: JointType.round);
    this.polyline.add(polyline);
    notifyListeners();
  }

  void changeSelected(String type) {
    selected = type;
    notifyListeners();
  }

  void confirmSelectedAnimals(List values) {
    selectedAnimals = values;
    print(selectedAnimals);
    notifyListeners();
  }
}
