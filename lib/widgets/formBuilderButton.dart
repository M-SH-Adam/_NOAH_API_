import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final Function() function;
  final String name;

  const FormButton({Key? key, required this.function, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      child: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
