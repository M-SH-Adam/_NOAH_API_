import 'dart:convert';

import 'package:ark_2/models/pets_model.dart';
import 'package:ark_2/models/profile_model.dart';
import 'package:ark_2/models/request_model.dart';
import 'package:http/http.dart' as http;
import 'package:ark_2/app/global_variables.dart';

class SetDataToDB{
  String phone = "01092159256";

  void sendProfileData(User user) async{
    String url = "https://arkapp010.000webhostapp.com/editProfile.php";
    var body = user.toJson();
    final response = await http.post(Uri.parse(url), body: body);

    //print("Phone " + user.lastName.toString() + " FirstName " + user.firstName.toString() + " Address " + user.address.toString()
      //  + " Email " +  user.email.toString() + " Birthdate " + user.birthdate.toString());
    if (response.statusCode == 200) {
      print("response.body" + response.body);
      // _ShowDialog("Updated Successfully");
    } else {
      print("Updated Failed" + response.body);
      //_ShowDialog("Updated Failer");
    }
  }
}