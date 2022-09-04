import 'package:ark_2/screens/edit%20profile/editProfile_viewModel.dart';
import 'package:ark_2/widgets/formBuilderButton.dart';
import 'package:ark_2/widgets/formBuilderPhoto.dart';
import 'package:ark_2/widgets/formBuilderTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ark_2/models/profile_model.dart';
import 'package:ark_2/web_services/APIs/Profile_controller.dart';

import '../../theme/custom_colors.dart';
import '../../widgets/formbuilderphone.dart';

class EditProfile extends StatelessWidget {
  final Map<String, dynamic> user;
  EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(),
      child: EditProfileBody(user),
    );
  }
}

class EditProfileBody extends StatelessWidget {
  final Map<String, dynamic>? user;
  EditProfileBody(this.user);

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final birthDate = TextEditingController();

  /*@override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }*/
  User userData = new User();
  User getData(){
    userData.firstName= name.text;
    userData.phone = phone.text;
    userData.email = email.text;
    userData.address = address.text;
    userData.birthdate = birthDate.text;
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: CustomColors.mainColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FormBuilder(
                key: context.read<EditProfileViewModel>().formkey,
                autovalidateMode: AutovalidateMode.disabled,
                skipDisabled: true,
                initialValue: {
                  'Name': user?['Name'],
                  'Phone Number': user?['Phone Number'],
                  'Email': user?['Email'],
                  'Address': user?['Address'],
                  'BirthDate': user?['BirthDate'],
                },
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    FormBuilderPhoto(
                      required: true,
                      name: "Profile photo",
                      errorText: "Please upload Your photo",
                    ),
                    const SizedBox(height: 15),
                    TextFieldForm(
                        name: 'Name',
                        required: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        controller: name,
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: 'Phone Number',
                      controller: phone,
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
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: "Email",
                      controller: email,
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "This field is required"),
                        FormBuilderValidators.email(
                            errorText: "Please enter valid email")
                      ]),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 15),
                    TextFieldForm(
                        name: 'Address',
                        controller: address,
                        required: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text),
                    const SizedBox(height: 15),
                    FormBuilderDateTimePicker(
                      name: 'BirthDate',
                      controller: birthDate,
                      initialEntryMode: DatePickerEntryMode.calendar,
                      inputType: InputType.date,
                      decoration: InputDecoration(
                        labelText: 'BirthDate',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.date_range),
                          onPressed: () {
                            context
                                .read<EditProfileViewModel>()
                                .dateTimeChange();
                          },
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "This field is required"),
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FormButton(
                      function: () {
                        profile prof = new profile();
                        prof.sendData(getData());
                        print(name.text + phone.text);
                        context
                            .read<EditProfileViewModel>()
                            .editProfile(context);
                      },
                      name: "Submit",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
