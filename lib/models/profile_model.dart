// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.phone,
    this.firstName,
    //this.lastName,
    //this.passwordKey,
    //this.gender,
    this.address,
    this.email,
    this.birthdate,
    //this.wallet,
    //this.photo,
  });

  String? phone;
  String? firstName;
  //String? lastName;
  //String? passwordKey;
  //dynamic gender;
  dynamic address;
  dynamic email;
  dynamic birthdate;
  //dynamic wallet;
  //dynamic photo;

  factory User.fromJson(Map<String, dynamic> json) => User(
    phone: json["Phone"],
    firstName: json["FirstName"],
    //lastName: json["LastName"],
    //passwordKey: json["PasswordKey"],
    //gender: json["Gender"],
    address: json["Address"],
    email: json["Email"],
    birthdate: json["Birthdate"],
    //wallet: json["Wallet"],
    //photo: json["Photo"],
  );

  Map<String, dynamic> toJson() => {
    "Phone": phone,
    "FirstName": firstName,
    //"LastName": lastName,
    //"PasswordKey": passwordKey,
    //"Gender": gender,
    "Address": address,
    "Email": email,
    "Birthdate": birthdate,
    //"Wallet": wallet,
    //"Photo": photo,
  };
}
