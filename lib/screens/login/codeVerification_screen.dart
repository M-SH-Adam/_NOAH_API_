import 'package:ark_2/screens/login/codeVerification_viewModel.dart';
import 'package:ark_2/widgets/formBuilderButton.dart';
import 'package:ark_2/widgets/formBuilderTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class CodeVerification extends StatelessWidget {
  const CodeVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CodeVerificationViewModel(),
      child: CodeVerificationBody(),
    );
  }
}

class CodeVerificationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: context.read<CodeVerificationViewModel>().codeVerificationKey,
        autovalidateMode: AutovalidateMode.disabled,
        skipDisabled: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter verification code",
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
                      name: "Verification Code",
                      required: true,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: FormButton(
                          function: () {
                            context
                                .read<CodeVerificationViewModel>()
                                .onSubmit(context);
                          },
                          name: "Submit",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: FormButton(
                            function: () {
                              context
                                  .read<CodeVerificationViewModel>()
                                  .changeNumber(context);
                            },
                            name: "Change Number"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Code will expire in: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black54),
                      ),
                      context.watch<CodeVerificationViewModel>().requestCode
                          ? Text(
                              context
                                  .watch<CodeVerificationViewModel>()
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
                                    .read<CodeVerificationViewModel>()
                                    .resendCode()
                              },
                              child: Text("resend Code",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                      fontSize: 18)),
                            )
                    ],
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
