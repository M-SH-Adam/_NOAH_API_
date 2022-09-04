// To parse this JSON data, do
//
//     final petsInfo = petsInfoFromJson(jsonString);

import 'dart:convert';

List<PetsInfo> petsInfoFromJson(String str) => List<PetsInfo>.from(json.decode(str).map((x) => PetsInfo.fromJson(x)));

String petsInfoToJson(List<PetsInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class PetsInfo {
  PetsInfo({
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

  factory PetsInfo.fromJson(Map<String, dynamic> json) => PetsInfo(
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
