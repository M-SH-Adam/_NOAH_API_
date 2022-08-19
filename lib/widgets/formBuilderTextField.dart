import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TextFieldForm extends StatelessWidget {
  final TextEditingController? controller;
  final String name;
  final bool required;
  final Function()? function;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  TextFieldForm(
      {Key? key,
      this.controller,
      required this.name,
      required this.required,
      this.function,
      required this.textInputAction,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: controller,
      name: name,
      decoration: InputDecoration(
        labelText: name,
      ),
      validator: required
          ? FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "This field is required"),
            ])
          : null,
      onTap: function,
      keyboardType: textInputType,
      textInputAction: textInputAction,
    );
  }
}
