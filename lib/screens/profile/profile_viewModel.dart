import 'dart:async';

import 'package:ark_2/app/routes.dart';
import 'package:ark_2/screens/edit%20profile/editProfile_viewModel.dart';
import 'package:ark_2/viewModels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends BaseViewModel {
  Map<String, dynamic> user = {};
  StreamSubscription? _userSubscription;

  ProfileViewModel() {
    _listenOnUser();
    getName();
  }

  _listenOnUser() {
    _userSubscription = eventBus.on<EditUser>().listen((event) {
      _editUser(event.user);
    });
  }

  _editUser(Map<String, dynamic> data) {
    user['Name'] = data['Name'];
    user['Phone Number'] = data['Phone Number'];
    user['Email'] = data['Email'];
    user['Address'] = data['Address'];
    user['BirthDate'] = data['BirthDate'];
    notifyListeners();
  }

  void editProfile(BuildContext context) {
    Navigator.pushNamed(context, Routes.editProfile, arguments: user);
  }

  void getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user['Name'] = prefs.get('name');
    notifyListeners();
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}
