import 'dart:convert';
//import 'dart:html';
import 'package:ark_2/classes/variables/Request.dart';
import 'package:ark_2/models/request_model.dart';
import 'package:http/http.dart' as http;

import '../../app/global_variables.dart';

class pet_controller{

  Future<List<Requests>?> sendPetData(Requests request) async {
    String url = "https://arkapp010.000webhostapp.com/addRequest.php";
    var body = request.toJson();
    final response = await http.post(Uri.parse(url), body: body);
    print("<>>>>>>>" + body.toString());
    if (response.statusCode == 200) {
      print("Updated Successfully" + response.body);
      //_ShowDialog("Updated Successfully");
    } else {
      print("Updated Failed" + response.body);
      //_ShowDialog("Updated Failed");
    }
  }
}

Future<void> _fetchAnimals() async {
  const apiUrl = 'https://';
  List<Request>? Requests;
  Request request = new Request();
  final response = await http.get(Uri.parse(apiUrl));
  final data = json.decode(response.body);

  if(data != null){
    for (Request request in data) {
      Requests?.add(request);
    }
    //Global.globleRequests = Requests;
  }
}