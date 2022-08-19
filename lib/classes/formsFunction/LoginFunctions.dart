import 'package:ark_2/app/global_variables.dart';
import 'package:ark_2/database/Database.dart';

class login {
  static void checkUser() async {
    DataBase.getUserInfo();
  }
  static void sendData() async {
    String newLogin = "https://arkapp010.000webhostapp.com/newLogin.php";
    DataBase.sendNewRegistrationData(newLogin);
  }

  static void setUserPhone(String phone) {
    Global.phone = phone;
  }

  static void setCode(String code) {}

  static void setFirstName(String firstname) {
    Global.firstName = firstname;
  }

  static void setLastName(String lastName) {
    Global.lastName = lastName;
  }
}
