import 'package:google_maps_flutter/google_maps_flutter.dart';

class Request{
  late LatLng startLocation;
  late LatLng endLocation;
  String carType = "";
  double offer = 0;
  DateTime requestTime = DateTime.now();
  double tripTime = 0;
  String comment = "";
}