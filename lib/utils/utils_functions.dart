import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app/app_keys.dart';

class UtilsFunctions {
  static toast({required String? text, Color backgroundColor = Colors.red}) {
    Fluttertoast.showToast(
        msg: "$text",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showSnackBar({
    String text = 'Something Wrong',
    Color color = Colors.red,
    Widget icon = const Icon(
      Icons.error,
      color: Colors.white,
    ),
  }) {
    AppKeys.rootScaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(text), icon],
          ),
          backgroundColor: color,
        ),
      );
  }

  static String? validateMobile(String? value) {
    String pattern = r'(^(?:[+0])?[0-9]{11,15}$)';
    RegExp regExp = new RegExp(pattern);
    if (value?.length == 0) {
      return "Please Enter Number";
    } else if (!regExp.hasMatch(value!)) {
      return "Please Enter Valid Number";
    }
    return null;
  }
}
