import 'dart:convert';
import 'dart:html';
//import 'package:ark_2/screens/index.dart';
import 'package:ark_2/screens/profile/profile_model.dart';
import 'package:http/http.dart' as http;

import '../models/apiResponse.dart';

class AnimalAPI{
  Future<APIResponse<List<Profile>>?> getProfile(){
    return http.get(Uri.parse('https://arkapp010.000webhostapp.com/get.php')).then((data){
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final profile = <Profile>[];
        for (var item in jsonData)
        {
          final prof = Profile(
            Phone: item['Phone'],
            FirstName: item['FirstName'],
            LastName: item['LastName'],
            Gender: item['Gender'],
            Address: item['Address'],
            Email: item['Email'],
            Birthdate: item['Birthdate'],
          );
          profile.add(prof);
        }
        return APIResponse<List<Profile>>(data: profile);
      }
      return APIResponse<List<Profile>>(error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Profile>>(error: true, errorMessage: 'An error occured'));
  }
}

