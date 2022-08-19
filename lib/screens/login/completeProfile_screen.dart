import 'package:ark_2/screens/login/completeProfile_viewModel.dart';
import 'package:ark_2/widgets/formBuilderButton.dart';
import 'package:ark_2/widgets/formBuilderTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CompleteProfileViewModel(),
      child: CompleteProfileBody(),
    );
  }
}

class CompleteProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: context.read<CompleteProfileViewModel>().profileKey,
        autovalidateMode: AutovalidateMode.disabled,
        skipDisabled: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Complete Your Profile",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  TextFieldForm(
                      name: "First name",
                      required: true,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextFieldForm(
                        name: "Last name",
                        required: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: FormButton(
                        function: () {
                          context
                              .read<CompleteProfileViewModel>()
                              .onSubmit(context);
                        },
                        name: "Submit",
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            //const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
