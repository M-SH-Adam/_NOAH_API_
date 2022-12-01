import 'dart:convert';
//import 'dart:html';
import 'package:ark_2/app/global_variables.dart';
import 'package:ark_2/models/profile_model.dart';
import 'package:http/http.dart' as http;

class profile{
  Future<List<User>> getProfile() async{
    String uri = "https://arkapp010.000webhostapp.com/get.php";
    final response  = await http.get(Uri.parse(uri));
    return userFromJson(response.body);
  }

  Future<List<User>?> sendData(User user) async {
    String url = "https://arkapp010.000webhostapp.com/editProfile.php";
    var body = user.toJson();
    final response = await http.post(Uri.parse(url), body: body);

    print("Phone " + user.lastName.toString() + " FirstName " + user.firstName.toString() + " Address " + user.address.toString()
        + " Email " +  user.email.toString() + " Birthdate " + user.birthdate.toString());
    if (response.statusCode == 200) {
      print("response.body" + response.body);
      // _ShowDialog("Updated Successfully");
    } else {
      print("Updated Failed" + response.body);
      //_ShowDialog("Updated Failer");
    }
  }
}

Future<dynamic> getUserInfo() async {
  String url = 'https://arkapp010.000webhostapp.com/get.php';
  final response = await http.post(Uri.parse(url), body: {
    "phone": Global.phone,
  });

  if (response.body != 'No record found.') {
    Map<String, dynamic> list =
    new Map<String, dynamic>.from(json.decode(response.body));
    User userInfo = User.fromJson(list);
  }
}