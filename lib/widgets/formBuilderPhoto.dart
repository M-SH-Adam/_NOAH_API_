import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormBuilderPhoto extends StatelessWidget {
  final bool required;
  final String name;
  final String? errorText;

  FormBuilderPhoto(
      {Key? key, required this.required, required this.name, this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderImagePicker(
      name: name,
      decoration: InputDecoration(labelText: name),
      maxImages: 1,
      validator: required
          ? FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: errorText),
            ])
          : null,
    );
  }
}
