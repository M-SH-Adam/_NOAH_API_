import 'package:ark_2/app/global_variables.dart';


class User {
  String phone = '';
  String firstName = '';
  String lastName = '';
  String address = '';
  String email = '';
  DateTime Birthdate = DateTime.now();

  void setUserData(){
    Global.phone = this.phone;
    Global.firstName = this.firstName;
    Global.lastName = this.lastName;
    Global.email = this.email;
    Global.address =this.address;
    Global.newUser = false;
  }

  User(Map<String, dynamic> list) {
    this.phone = list['phone'] != null ? list['phone'] : '';
    this.firstName = list['FirstName'] != null ? list['FirstName'] : '';
    this.lastName = list['LastName'] != null ? list['LastName'] : '';
    this.address = list['Address'] != null ? list['Address'] : '';
    this.email = list['Email'] != null ? list['Email'] : '';
    setUserData();
  }
}
