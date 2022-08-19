import 'dart:async';

import 'package:ark_2/viewModels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../app/routes.dart';

class VerifyCode {
  String code;
  BuildContext context;
  VerifyCode(this.code, this.context);
}

class ResendCode {
  ResendCode();
}

class CodeVerificationViewModel extends BaseViewModel {
  Timer? _timer;
  int start = 60;
  bool requestCode = true;
  final codeVerificationKey = GlobalKey<FormBuilderState>();

  CodeVerificationViewModel() {
    _startTimer();
  }

  void onSubmit(BuildContext context) {
    if (codeVerificationKey.currentState?.saveAndValidate() ?? false) {
      print(codeVerificationKey.currentState?.value["Verification Code"]);
      eventBus.fire(VerifyCode(
          codeVerificationKey.currentState?.value["Verification Code"],
          context));
    } else {
      debugPrint(codeVerificationKey.currentState!.value.toString());
      debugPrint('validation failed!');
    }
  }

  void changeNumber(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routes.login);
    start = 60;
    _timer?.cancel();
    notifyListeners();
  }

  void resendCode() {
    start = 60;
    notifyListeners();
    _changeRequestCode(true);
    _startTimer();
    eventBus.fire(ResendCode());
  }

  _startTimer() {
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
    _timer?.cancel();
    super.dispose();
  }

  _changeRequestCode(value) {
    requestCode = value;
    notifyListeners();
  }
}
