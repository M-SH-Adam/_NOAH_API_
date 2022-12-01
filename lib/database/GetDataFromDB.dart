import 'dart:convert';

import 'package:ark_2/models/pets_model.dart';
import 'package:ark_2/models/profile_model.dart';
import 'package:ark_2/models/request_model.dart';
import 'package:http/http.dart' as http;
import 'package:ark_2/app/global_variables.dart';

class GetDataFromDB{
  String phone = "01092159256";

  void getData(){
    getProfileData();
    getPetData();
    getRequestData();
  }

  void getProfileData() async{
    String url = "https://arkapp010.000webhostapp.com/phoneuser.php";
    final response = await http.post(Uri.parse(url), body: {
      "Phone": phone,
    });
    if (response.statusCode == 200) {
      print("<<<getProfileData>>> " + response.body);
      Global.user = User.fromJson(jsonDecode(response.body)[0]);
      print("<<<firstName>>> " + Global.user.firstName.toString());
      print("<<<lastName>>> " + Global.user.lastName.toString());
      print("<<<getProfileData>>> " + response.body);
      //_ShowDialog("Updated Successfully");
    } else {
      print("Updated Failed" + response.body);
      //_ShowDialog("Updated Failed");
    }
  }

  void getPetData() async{
    String url = "https://arkapp010.000webhostapp.com/phoneuser.php";
    final response = await http.post(Uri.parse(url), body: {
      "Phone": phone,
    });
    if (response.statusCode == 200) {
      print("<<<getPetData>>> " + response.body);
      for(var item in jsonDecode(response.body))
        Global.globleAnimals?.add(item);
      //print("<<<globleAnimals>>> " + Global.globleAnimals[0].name.toString());
      print("<<<getPetData>>> " + response.body);
      //_ShowDialog("Updated Successfully");
    } else {
      print("Updated Failed" + response.body);
      //_ShowDialog("Updated Failed");
    }
  }

  void getRequestData() async{
    String url = "https://arkapp010.000webhostapp.com/phoneuser.php";
    final response = await http.post(Uri.parse(url), body: {
      "Phone": phone,
    });
    if (response.statusCode == 200) {
      //Requests requests = Requests.fromJson(jsonDecode(response.body));
      for(var item in jsonDecode(response.body))
        Global.globleRequests?.add(item);
      print("<<<getRequestData>>> " + Global.phone);
      print("<<<getRequestData>>> " + response.body);
      //_ShowDialog("Updated Successfully");
    } else {
      print("Updated Failed" + response.body);
      //_ShowDialog("Updated Failed");
    }
  }
}