import 'package:ark_2/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class Controls {
  static Widget buildButtonForTrans(
      AssetImage image, String buttonTitle, Function() function) {
    Color tintColor = CustomColors.mainColor;
    return SizedBox(
      width: 80, // Container child widget will get this width value
      height: 55, // Container child widget will get this height value
      child: Material(
        color: tintColor,
        elevation: 8,
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: function,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Ink.image(
                image: image,
                height: 25,
                width: 35,
                fit: BoxFit.cover,
              ),
              Text(
                buttonTitle,
                style: TextStyle(fontSize: 15, color: CustomColors.textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildTextArea(
      IconData icon, String labelText, Function function) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(icon),
          title: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: labelText,
                  hintText: labelText),
              onChanged: (String value) {
                function(value);
              }),
        ),
      ],
    );
  }

  static Widget buildTextFieldReadOnlyWithOnTap(
      TextEditingController controller,
      IconData icon,
      String labelText,
      Function function) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(icon),
          title: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: labelText,
                hintText: labelText),
            onTap: () => function(),
            readOnly: true,
          ),
        ),
      ],
    );
  }

  static Widget buildRoundButton(String buttonText) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text(
        'Request',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }
}
