import 'dart:convert';

import 'package:ark_2/app/global_variables.dart';
import 'package:ark_2/classes/variables/User.dart';
import 'package:http/http.dart' as http;

class DataBase {
  static bool error = false, sending = false, success = false;
  static String msg = "";

  static Future<dynamic> getUserInfo() async {
    String url = 'https://arkapp010.000webhostapp.com/get.php';
    final response = await http.post(Uri.parse(url), body: {
      "phone": Global.phone,
    });
    if (response.body != 'No record found.') {
      Map<String, dynamic> list =
      new Map<String, dynamic>.from(json.decode(response.body));
      User userInfo = User(list);
    }
  }

  static Future<void> sendNewRegistrationData(String url) async {
    String phpurl = url;
    var res = await http.post(Uri.parse(phpurl), body: {
      "phone": Global.phone,
      "firstName": Global.firstName,
      "lastName": Global.lastName
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        //refresh the UI when error is recieved from server
        sending = false;
        error = true;
        msg = data["message"]; //error message from server
      } else {
        sending = false;
        success = true; //mark success and refresh UI with setState
      }
    } else {
      //there is error
      error = true;
      msg = "Error during sending data.";
      sending = false;
      //mark error and refresh UI with setState
    }
    print("sent");
    reset();
  }

  static void reset() {
    error = false;
    sending = false;
    success = false;
    msg = "";
  }
}
