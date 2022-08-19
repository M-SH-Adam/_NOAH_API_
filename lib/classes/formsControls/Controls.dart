import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class Controls{
  String _radioButtonValue = "Text alignment right";

  Widget RadioButtonWidget(String value, Function function) {
    return Container(
      child: RadioButton(
        description: value,
        value: value,
        groupValue: _radioButtonValue,
        onChanged: (value) => function(value.toString()),
        activeColor: Colors.black,
        textStyle: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }

  String dropdownvalue = 'Item 1';

// List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  // Widget DropdawnListWidgit(){
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       DropdownButton(
  //
  //         // Initial Value
  //         value: dropdownvalue,
  //
  //         // Down Arrow Icon
  //         icon: const Icon(Icons.keyboard_arrow_down),
  //
  //         // Array list of items
  //         items: items.map((String items) {
  //           return DropdownMenuItem(
  //             value: items,
  //             child: Text(items),
  //           );
  //         }).toList(),
  //         // After selecting the desired option,it will
  //         // change button value to selected value
  //         onChanged: (String? newValue) {
  //           setState(() {
  //             dropdownvalue = newValue!;
  //           });
  //         },
  //       ),
  //     ],
  //   );
  // }
}