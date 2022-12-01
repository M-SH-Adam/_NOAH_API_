import 'dart:convert';
//import 'dart:html';
import 'package:ark_2/app/global_variables.dart';
import 'package:ark_2/models/pets_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class pet_controller{

  Future<List<Pets>?> sendPetData(Pets pet) async {
    String url = "https://arkapp010.000webhostapp.com/editProfile.php";
    var body = pet.toJson();
    final response = await http.post(Uri.parse(url), body: body);
    print("<!>>>>>>>" + body.toString());
    if (response.statusCode == 200) {
      print("Updated Successfully" + response.body);
      //_ShowDialog("Updated Successfully");
    } else {
      print("Updated Failed" + response.body);
      //_ShowDialog("Updated Failed");
    }
  }

  void getPetData() async{
    String url = "https://arkapp010.000webhostapp.com/phoneuser.php";
    final response = await http.post(Uri.parse(url), body: {
      "Phone": "01092159256",
    });

    if (response.statusCode == 200) {
      print("<<<>>> " + Global.phone);
      print("<<<>>> " + response.body);
      //_ShowDialog("Updated Successfully");
    } else {
      print("Updated Failed" + response.body);
      //_ShowDialog("Updated Failed");
    }
  }
}


Future<void> _fetchAnimals() async {
  const apiUrl = 'https://';
  List<Pets>? animals;
  Pets pet = new Pets();
  final response = await http.get(Uri.parse(apiUrl));
  final data = json.decode(response.body);

  if(data != null){
    for (Pets animal in data) {
      animals?.add(animal);
    }
    Global.globleAnimals = animals;
  }
}