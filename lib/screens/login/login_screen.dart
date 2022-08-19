import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import 'login_viewModel.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: context.read<LoginViewModel>().loginformKey,
        onChanged: () {
          context.read<LoginViewModel>().saveLogin();
        },
        autovalidateMode: AutovalidateMode.disabled,
        skipDisabled: true,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: context.read<LoginViewModel>().pageController,
          children: [
            login('Mobile Number', () {
              context.read<LoginViewModel>().getPhoneNumber();
            }, () {}, context),
            login('Verification Code', () {
              context.read<LoginViewModel>().pageController.nextPage(
                  duration: Duration(milliseconds: 1000), curve: Curves.ease);
              //context.read<LoginViewModel>().getVerificationCode(context);
            }, () {
              context.read<LoginViewModel>().pageController.previousPage(
                  duration: Duration(milliseconds: 1000), curve: Curves.ease);
              context.read<LoginViewModel>().resendCode(true);
            }, context),
            login('First Name', () {
              context.read<LoginViewModel>().getName(context);
            }, () {}, context),
          ],
        ),
      ),
    );
  }

  Column login(
      String name, Function() submit, Function() back, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        name == "Mobile Number"
            ? Container(
                height: 250.0,
                width: 290.0,
                padding: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: Image.asset('assets/Noah.png'),
                ),
              )
            : Container(),
        SizedBox(
          height: 20,
        ),
        name == "First Name"
            ? Text(
                "Complete Your Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            : Text(
                "Enter $name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                initialValue: "",
                name: name,
                decoration: InputDecoration(
                  labelText: name,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "This field is required"),
                ]),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              name == 'First Name'
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FormBuilderTextField(
                        name: 'Last Name',
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "This field is required"),
                        ]),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: submit,
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  name == "Verification Code"
                      ? const SizedBox(width: 20)
                      : Container(),
                  name == "Verification Code"
                      ? Expanded(
                          child: ElevatedButton(
                            onPressed: back,
                            child: const Text(
                              'Change Number',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              name == "Verification Code"
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Code will expire in: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54),
                        ),
                        context.watch<LoginViewModel>().requestCode
                            ? Text(
                                context
                                    .watch<LoginViewModel>()
                                    .start
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                    fontSize: 18),
                              )
                            : InkWell(
                                onTap: () => {
                                  context
                                      .read<LoginViewModel>()
                                      .resendCode(false)
                                },
                                child: Text("resend Code",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                        fontSize: 18)),
                              )
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        //const SizedBox(height: 10),
      ],
    );
  }
}
