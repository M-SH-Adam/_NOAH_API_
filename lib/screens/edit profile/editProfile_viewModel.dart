import 'package:ark_2/viewModels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUser {
  Map<String, dynamic> user;
  EditUser(this.user);
}

class EditProfileViewModel extends BaseViewModel {
  final formkey = GlobalKey<FormBuilderState>();

  void dateTimeChange() {
    formkey.currentState!.fields['date']?.didChange(null);
    notifyListeners();
  }

  void editProfile(BuildContext context) async {
    if (formkey.currentState?.saveAndValidate() ?? false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('name');
      prefs.setString('name', formkey.currentState!.value['Name']);
      eventBus.fire(EditUser(formkey.currentState!.value));
      Navigator.pop(context);
    } else {
      print(formkey.currentState!.value.toString());
    }
  }
}
