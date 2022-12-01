import 'package:ark_2/screens/add_animal/add_animal_ViewModel.dart';
import 'package:ark_2/widgets/formBuilderButton.dart';
import 'package:ark_2/widgets/formBuilderPhoto.dart';
import 'package:ark_2/widgets/formBuilderTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ark_2/models/pets_model.dart';
import 'package:ark_2/web_services/APIs/Pet_controller.dart';

import '../../theme/custom_colors.dart';

class AddAnimal extends StatelessWidget {
  final Map<String, dynamic>? data;
  final int? index;
  AddAnimal({Key? key, this.data, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddAnimalViewModel(),
      child: AddAnimalBody(
        data: data,
        index: index,
      ),
    );
  }
}

class AddAnimalBody extends StatelessWidget {
  final name = TextEditingController();
  final weight = TextEditingController();
  final color = TextEditingController();
  DateTime? birthdate ;
  String? species;
  var gender;

  Pets petInfo = new Pets();
  Pets getData(){
    petInfo.name = name.text;
    petInfo.weight = weight.text;
    petInfo.color = color.text;
    petInfo.birthdate = birthdate;
    petInfo.petsInfoId = species;
    petInfo.gender = gender;
    petInfo.userId = '22';
    return petInfo;
  }

  final Map<String, dynamic>? data;
  final int? index;
  AddAnimalBody({Key? key, this.data, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add animal'),
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
                key: context.read<AddAnimalViewModel>().formKey,
                autovalidateMode: AutovalidateMode.disabled,
                skipDisabled: true,
                initialValue: {
                  'Name': data?['Name'],
                  'Weight': data?['Weight'],
                  'Color': data?['Color'],
                  'Birth date': data?['Birth date'],
                  'Select species': data?['Select species'],
                  'Gender': data?['Gender'],
                  'Comment(Optional)': data?['Comment(Optional)'],
                  'Medical condition text(Optional)':
                      data?['Medical condition text(Optional)'],
                },
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    TextFieldForm(
                        name: "Name",
                        required: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        controller: name,),
                    const SizedBox(height: 15),
                    TextFieldForm(
                        name: "Weight",
                        required: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        controller: weight,),
                    const SizedBox(height: 15),
                    TextFieldForm(
                        name: "Color",
                        required: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        controller: color,),
                    const SizedBox(height: 15),
                    FormBuilderDateTimePicker(
                      //controller: birthdate,
                      name: 'Birth date',
                      initialEntryMode: DatePickerEntryMode.calendar,
                      inputType: InputType.date,
                      decoration: InputDecoration(
                        labelText: 'Birth date',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.date_range),
                          onPressed: () {
                            context.read<AddAnimalViewModel>().dateTimeChange();
                          },
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "This field is required"),
                      ]),
                      onChanged: (value) {
                        birthdate = value;
                      },
                    ),
                    const SizedBox(height: 15),
                    FormBuilderDropdown<String>(
                      name: 'Select species',
                      decoration: InputDecoration(
                        labelText: 'Select species',
                      ),
                      hint: const Text('Select species'),
                      onChanged: (val) {
                        species = val;
                        context
                            .read<AddAnimalViewModel>()
                            .getSelectedSpecies(val!);
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "This field is required")
                      ]),
                      items: context
                          .read<AddAnimalViewModel>()
                          .species
                          .map((species) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: species,
                                child: Text(species),
                              ))
                          .toList(),
                      valueTransformer: (val) => val?.toString(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    context.watch<AddAnimalViewModel>().visability
                        ? FormBuilderDropdown<String>(
                            name: 'Select type',
                            key: context.read<AddAnimalViewModel>().dropKey,
                            decoration: InputDecoration(
                              labelText: 'Select type',
                            ),
                            hint: const Text('Select type'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "This field is required")
                            ]),
                            items: context
                                .read<AddAnimalViewModel>()
                                .types
                                .map((types) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: types,
                                      child: Text(types),
                                    ))
                                .toList(),
                            valueTransformer: (val) => val?.toString(),
                          )
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    FormBuilderRadioGroup<String>(
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                      ),
                      name: 'Gender',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Please select gender"),
                      ]),
                      options: ['Male', 'Female']
                          .map((lang) => FormBuilderFieldOption(
                                value: lang,
                                child: Text(lang),
                              ))
                          .toList(growable: false),
                      controlAffinity: ControlAffinity.trailing,
                      onChanged: (val) {
                        gender = val;
                      },
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: 'Comment(Optional)',
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Comment(Optional)',
                      ),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                    const SizedBox(height: 15),
                    TextFieldForm(
                        name: "Medical condition text(Optional)",
                        required: false,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderPhoto(
                      required: true,
                      name: "Animal photo",
                      errorText: "Please upload animal photo",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FormBuilderPhoto(
                      required: false,
                      name: "Medical condition photo(Optional)",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FormBuilderPhoto(
                      required: false,
                      name: "Animal license(Optional)",
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
                      print(">>>>>>>>>>  $name  $color $weight $species $birthdate $gender");
                      data == null
                          ? context
                              .read<AddAnimalViewModel>()
                              .addAnimal(context)
                          : context
                              .read<AddAnimalViewModel>()
                              .updateAnimal(context, index);
                      pet_controller petsApi = new pet_controller();
                      petsApi.sendPetData(getData());
                    },
                    name: "Submit",
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
