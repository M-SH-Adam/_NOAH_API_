class Profile {
   String? Phone;
   String? FirstName;
   String? LastName;
   String? Gender;
   String? Address;
   String? Email;
   DateTime? Birthdate;

  Profile({this.Phone, this.FirstName,this.LastName, this.Gender, this.Address, this.Email, this.Birthdate});

  /*const Profile({
    required this.Phone,
    required this.FirstName,
    required this.LastName,
    required this.Gender,
    required this.Address,
    required this.Email,
    required this.Birthdate,
  });*/

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      Phone: json['Phone'],
      FirstName: json['FirstName'],
      LastName: json['LastName'],
      Gender: json['Gender'],
      Address: json['Address'],
      Email: json['Email'],
      Birthdate: json['Birthdate'],
    );
  }
}