import 'dart:convert';
//import 'dart:html';
import 'package:ark_2/models/pets_model.dart';
import 'package:http/http.dart' as http;

class profile{
  Future<List<User>> getProfile() async{
    String uri = "https://arkapp010.000webhostapp.com/get.php";
    final response  = await http.get(Uri.parse(uri));
    return userFromJson(response.body);
  }

  Future<List<User>?> sendData(User user) async {
    String url = "https://arkapp010.000webhostapp.com/editProfile.php";
    final response = await http.post(Uri.parse(url), body: {
      //user.toJson(),
      "Phone": user.phone,
      "FirstName": user.firstName,
      "Address": user.address,
      "Email": user.email,
      "Birthdate": user.birthdate,
    });
    print("Phone " + user.phone.toString() + " FirstName " + user.firstName.toString() + " Address " + user.address.toString()
        + " Email " +  user.email.toString() + " Birthdate " + user.birthdate.toString());
    if (response.statusCode == 200) {
      print("Updated Successfully" + response.body);
      //_ShowDialog("Updated Successfully");
    } else {
      print("Updated Failed" + response.body);
      //_ShowDialog("Updated Failer");
    }
  }
}

/*Future<String> _ShowDialog(String msg) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Rewind and remember'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text(msg),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}*/

//String phone, String firstName, String lastName, String passwordKey, dynamic gender, dynamic address,
//dynamic email, dynamic birthdate, dynamic wallet, dynamic photo