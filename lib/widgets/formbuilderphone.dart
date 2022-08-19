import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormBuilderPhone extends StatelessWidget {
  const FormBuilderPhone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'Phone Number',
      decoration: InputDecoration(
        labelText: 'Phone Number',
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "This field is required"),
        FormBuilderValidators.numeric(errorText: "Enter valid number"),
        FormBuilderValidators.maxLength(11, errorText: "Enter valid number"),
        FormBuilderValidators.minLength(11, errorText: "Enter valid number"),
      ]),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
    );
  }
}
