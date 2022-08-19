import 'package:flutter/material.dart';

class LoginControls {
  static Widget showText(String textHolder) {
    return Text(
      textHolder,
      style: const TextStyle(
        fontSize: 20.0,
      ),
    );
  }

  static Widget textArea(String label, String hint, int length,
      bool textInputTypeNumber, Function function,
      {bool visibility = true}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        maxLength: length,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          hintText: hint,
        ),
        onChanged: (String value) {
          function(value);
        },
        keyboardType:
            textInputTypeNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }

  static Widget loginButton(String text, Function function) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent, // background
        onPrimary: Colors.white, // foreground
      ),
      onPressed: () {
        function();
      },
      child: Text(text),
    );
  }
}
