import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/routes.dart';
import '../../utils/utils_functions.dart';

class LoginViewModel extends ChangeNotifier {
  String verificationIDReceived = "";
  bool requestCode = false;
  late Timer _timer;
  int start = 60;
  String? phoneNumber;

  PageController pageController = PageController(initialPage: 0);
  final loginformKey = GlobalKey<FormBuilderState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() {
    if (loginformKey.currentState?.saveAndValidate() ?? false) {
      Map data = loginformKey.currentState!.value;
      print(data);
    } else {
      debugPrint(loginformKey.currentState!.value.toString());
      debugPrint('validation failed!');
    }
  }

  void saveLogin() {
    loginformKey.currentState!.save();
  }

  void getPhoneNumber() {
    if (loginformKey.currentState?.saveAndValidate() ?? false) {
      print(loginformKey.currentState?.value.toString());
      pageController.nextPage(
          duration: Duration(milliseconds: 1000), curve: Curves.ease);

      phoneNumber =
          loginformKey.currentState?.value["Mobile Number"].toString();
      notifyListeners();
      verifyNumber();
    } else {
      print(loginformKey.currentState!.value.toString());
    }
  }

  void getVerificationCode(BuildContext context) {
    if (loginformKey.currentState?.saveAndValidate() ?? false) {
      print(loginformKey.currentState?.value.toString());
      verifyCode(
          loginformKey.currentState?.value["Verification Code"].toString(),
          context);
    } else {
      print(loginformKey.currentState!.value.toString());
    }
  }

  void getName(BuildContext context) async {
    loginformKey.currentState?.saveAndValidate() ?? false
        ? saveName(loginformKey.currentState?.value["First Name"],
            loginformKey.currentState?.value["Last Name"], context)
        : print(loginformKey.currentState!.value.toString());
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          _changeRequestCode(false);
          notifyListeners();
        } else {
          start--;
          notifyListeners();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _changeRequestCode(value) {
    requestCode = value;
    notifyListeners();
  }

  void verifyNumber() async {
    _changeRequestCode(true);
    startTimer();
    await auth.verifyPhoneNumber(
        phoneNumber: "+2$phoneNumber!",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) => {});
        },
        verificationFailed: (FirebaseAuthException exception) {
          //UtilsFunctions.showSnackBar(text: "Invalid Phone Number");
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDReceived = verificationID;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
        timeout: const Duration(minutes: 1));
  }

  void verifyCode(String? smsCode, BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDReceived, smsCode: smsCode!);
    try {
      await auth
          .signInWithCredential(credential)
          .then((value) => {checkUser(context)});
    } catch (e) {
      UtilsFunctions.showSnackBar(text: "Invalid Code");
    }
  }

  void resendCode(bool? backButton) {
    if (backButton! == true) {
      start = 60;
      _timer.cancel();
      notifyListeners();
    } else {
      start = 60;
      notifyListeners();
      verifyNumber();
    }
  }

  void signOut(BuildContext context) async {
    await auth.signOut();
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  void checkUser(BuildContext context) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userID == prefs.getString("UserID")) {
      Navigator.pushReplacementNamed(context, Routes.map);
    } else {
      await prefs.setString('UserID', userID);
      pageController.nextPage(
          duration: Duration(milliseconds: 1000), curve: Curves.ease);
    }
  }

  void saveName(
      String firstName, String secondName, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", "$firstName $secondName");
    Navigator.pushReplacementNamed(context, Routes.map);
  }
}
