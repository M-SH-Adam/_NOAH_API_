// To parse this JSON data, do
//
//     final requests = requestsFromJson(jsonString);

import 'dart:convert';

List<Requests> requestsFromJson(String str) => List<Requests>.from(json.decode(str).map((x) => Requests.fromJson(x)));

String requestsToJson(List<Requests> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Requests {
  Requests({
    this.petsInfoId,
    this.type,
    this.name,
    this.description,
    this.transportCode,
    this.averageAge,
    this.licenseNeed,
  });

  String? petsInfoId;
  String? type;
  String? name;
  dynamic description;
  dynamic transportCode;
  String? averageAge;
  String? licenseNeed;

  factory Requests.fromJson(Map<String, dynamic> json) => Requests(
    petsInfoId: json["PetsInfoID"],
    type: json["Type"],
    name: json["Name"],
    description: json["Description"],
    transportCode: json["TransportCode"],
    averageAge: json["AverageAge"],
    licenseNeed: json["LicenseNeed"],
  );

  Map<String, dynamic> toJson() => {
    "PetsInfoID": petsInfoId,
    "Type": type,
    "Name": name,
    "Description": description,
    "TransportCode": transportCode,
    "AverageAge": averageAge,
    "LicenseNeed": licenseNeed,
  };
}
