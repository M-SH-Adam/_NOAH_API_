import 'package:ark_2/app/global_variables.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationRepository{

  static Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.whileInUse ||  permission == LocationPermission.always){
      Position position = await Geolocator.getCurrentPosition();
      return position;
    }else {
      return Global.position;
    }
  }

}