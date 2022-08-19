import 'dart:async';

import 'package:ark_2/screens/login/codeVerification_viewModel.dart';
import 'package:ark_2/viewModels/base_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/routes.dart';
import '../../utils/utils_functions.dart';

class PhoneNumberViewModel extends BaseViewModel {
  String verificationIDReceived = "";
  String? phoneNumber;
  FirebaseAuth auth = FirebaseAuth.instance;
  StreamSubscription? _codeSubscrip;
  StreamSubscription? _resendcode;

  final phoneKey = GlobalKey<FormBuilderState>();

  PhoneNumberViewModel() {
    _listenOnCode();
  }

  void onSubmit(BuildContext context) {
    if (phoneKey.currentState?.saveAndValidate() ?? false) {
      Map data = phoneKey.currentState!.value;
      phoneNumber = phoneKey.currentState?.value["Phone Number"].toString();
      notifyListeners();
      verifyNumber();
      Navigator.pushReplacementNamed(context, Routes.codeVerification);
      print(data);
    } else {
      debugPrint(phoneKey.currentState!.value.toString());
      debugPrint('validation failed!');
    }
  }

  _listenOnCode() {
    _codeSubscrip = eventBus.on<VerifyCode>().listen((event) {
      _verifyCode(event.code, event.context);
    });

    _resendcode = eventBus.on<ResendCode>().listen((event) {
      verifyNumber();
    });
  }

  void verifyNumber() async {
    await auth.verifyPhoneNumber(
        phoneNumber: "+2$phoneNumber!",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) => {});
        },
        verificationFailed: (FirebaseAuthException exception) {
          UtilsFunctions.showSnackBar(text: "Invalid Phone Number");
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDReceived = verificationID;
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
        timeout: const Duration(minutes: 1));
  }

  void _verifyCode(String? smsCode, BuildContext context) async {
    print(smsCode);
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

  void checkUser(BuildContext context) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userID == prefs.getString("UserID")) {
      Navigator.pushReplacementNamed(context, Routes.map);
    } else {
      await prefs.setString('UserID', userID);
      Navigator.pushReplacementNamed(context, Routes.completeProfile);
    }
  }
}
