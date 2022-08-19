import 'package:ark_2/viewModels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/routes.dart';

class CompleteProfileViewModel extends BaseViewModel {
  final profileKey = GlobalKey<FormBuilderState>();

  void onSubmit(BuildContext context) async {
    profileKey.currentState?.saveAndValidate() ?? false
        ? saveName(profileKey.currentState?.value["First name"],
        profileKey.currentState?.value["Last name"], context)
        : print(profileKey.currentState?.value.toString());
  }

  void saveName(
      String firstName, String secondName, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", "$firstName $secondName");
    Navigator.pushReplacementNamed(context, Routes.map);
  }
}