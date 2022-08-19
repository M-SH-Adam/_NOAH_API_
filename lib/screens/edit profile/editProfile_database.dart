import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> createAlbum(String Phone, String FirstName, String Email, String Address, String Birthdate, String UserID) {
  return http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Phone': Phone,
      'FirstName': FirstName,
      'Email': Email,
      'Address': Address,
      'Birthdate': Birthdate,
      'UserID': UserID,
    }),
  );
}