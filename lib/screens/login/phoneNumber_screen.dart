import 'package:ark_2/widgets/formBuilderButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../../database/GetDataFromDB.dart';
import '../../widgets/formbuilderphone.dart';
import 'PhoneNumber_viewModel.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhoneNumberViewModel(),
      child: PhoneNumberBody(),
    );
  }
}

class PhoneNumberBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: context.read<PhoneNumberViewModel>().phoneKey,
        autovalidateMode: AutovalidateMode.disabled,
        skipDisabled: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250.0,
              width: 290.0,
              padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Image.asset('assets/Noah.png'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Enter Your Phone Number",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  FormBuilderPhone(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          child: FormButton(
                        function: () {
                          GetDataFromDB DBData =new GetDataFromDB();
                          DBData.getData();
                          context
                              .read<PhoneNumberViewModel>()
                              .onSubmit(context);
                        },
                        name: "Submit",
                      )),
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
