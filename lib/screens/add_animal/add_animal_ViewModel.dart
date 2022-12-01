import 'package:ark_2/viewModels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ark_2/models/petsInfo_model.dart';

class NewAnimalCreated {
  final Map<String, dynamic> animal;
  NewAnimalCreated(this.animal);
}

class AnimalUpdated {
  final Map<String, dynamic> animal;
  final int index;
  AnimalUpdated(this.animal, this.index);
}

class AddAnimalViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormBuilderState>();
  final dropKey = GlobalKey<FormFieldState>();
  List<PetsInfo>? pets;
  PetsInfoData petsinf = new PetsInfoData();

  bool visability = false;
  List<String> types = [];
  var species = [
    'forest elephant',
    'Amur Leopard',
    'Black Rhino',
    'Bornean Orangutan',
    'Cross River Gorilla',
    'Lowland Gorilla'
  ];

  Map type = {
    'forest elephant': ['a', 'b', 'c'],
    'Amur Leopard': ['e', 'f', 'g'],
    'Black Rhino': ['l', 'r', 'o'],
    'Bornean Orangutan': ['m', 'n', 't'],
    'Cross River Gorilla': ['i', 'v', 's'],
    'Lowland Gorilla': ['w', 'd', 'k'],
  };

  void addAnimal(BuildContext context) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      eventBus.fire(NewAnimalCreated(formKey.currentState!.value));
      Navigator.pop(context);
    } else {
      debugPrint(formKey.currentState!.value.toString());
      debugPrint('validation failed!');
    }
  }

  void saveAnimal() {
    formKey.currentState!.save();
    notifyListeners();
  }

  void dateTimeChange() {
    formKey.currentState!.fields['date']?.didChange(null);
    notifyListeners();
  }

  void getSelectedSpecies(String species) {
    dropKey.currentState?.reset();
    visability = true;
    types = type[species];
    notifyListeners();
  }

  void updateAnimal(BuildContext context, int? index) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      if (formKey.currentState?.value['Select type'] == null) {
        visability = true;
        notifyListeners();
        print(formKey.currentState?.value['Select type']);
      } else {
        eventBus.fire(AnimalUpdated(formKey.currentState!.value, index!));
        Navigator.pop(context);
      }
    } else {
      debugPrint(formKey.currentState!.value.toString());
      debugPrint('validation failed!');
    }
  }
}
