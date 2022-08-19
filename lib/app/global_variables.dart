import '../classes/variables/Request.dart';
import 'package:geolocator/geolocator.dart';

class Global {
  static String appName = "Noah";
  static Request request = Request();
  static String phone = '', firstName = '', lastName =  '', email = '', address = '';
  static bool newUser = true;

  static final Position position = Position.fromMap({
    "latitude": 29.991779,
    "longitude": 31.1590126
  });

  static const googleMapApiKey = "AIzaSyCK-jhWPfhrHUIIdTN5oA3vuWvfrg48h7U";

  static void setUserData(var userData) {
    if(userData.length > 0){
      phone = userData[0].phone;
      firstName = userData[0].firstName;
      lastName = userData[0].lastName;
      email = userData[0].email;
    }
  }

  static void setStartLocation(String startLocation) {
    // request.startLocation = startLocation;
  }

  static void setEndLocation(String endLocation) {
    // request.startLocation = endLocation;
  }

  static void setCarType(String carType) {
    request.carType = carType;
  }

  static void setOffer(String offer) {
    request.offer = double.parse(offer);
  }

  static void setTripTime(String tripTime) {
    request.tripTime =double.parse(tripTime);
  }

  static void setComment(String comment) {
    request.comment = comment;
  }

}
