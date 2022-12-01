// To parse this JSON data, do
//
//     final pets = petsFromJson(jsonString);

import 'dart:convert';

List<Pets> petsFromJson(String str) => List<Pets>.from(json.decode(str).map((x) => Pets.fromJson(x)));

String petsToJson(List<Pets> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pets {
  Pets({
    this.name,
    this.gender,
    this.weight,
    this.birthdate,
    this.color,
    //this.photo,
    //this.comment,
    this.petsInfoId,
    this.userId,
  });

  String? petId;
  String? name;
  String? gender;
  String? weight;
  DateTime? birthdate;
  String? color;
  //String? photo;
  //String? comment;
  String? petsInfoId;
  String? userId;

  factory Pets.fromJson(Map<String, dynamic> json) => Pets(
    name: json["Name"],
    gender: json["Gender"],
    weight: json["Weight"],
    birthdate: DateTime.parse(json["Birthdate"]),
    color: json["Color"],
    //photo: json["Photo"],
    //comment: json["Comment"],
    petsInfoId: json["PetsInfoID"],
    userId: json["UserID"],
  );

  Map<String, dynamic> toJson() => {
    "PetID": petId,
    "Name": name,
    "Gender": gender,
    "Weight": weight,
    birthdate != null ?"Birthdate": "${birthdate?.year.toString().padLeft(4, '0')}-${birthdate?.month.toString().padLeft(2, '0')}-${birthdate?.day.toString().padLeft(2, '0')}" : DateTime.now(),
    "Color": color,
    //"Photo": photo,
    //"Comment": comment,
    "PetsInfoID": petsInfoId,
    "UserID": userId,
  };
}
