import 'dart:async';

import 'package:ark_2/viewModels/base_model.dart';

import '../add_animal/add_animal_ViewModel.dart';

class GetAnimals {
  final List<Map<String, dynamic>> animals;
  GetAnimals(this.animals);
}

class MyAnimalsViewModel extends BaseViewModel {
  StreamSubscription? _newAnimalAdded;
  StreamSubscription? _animalUpdated;
  final List<Map<String, dynamic>> animals = [];

  MyAnimalsViewModel() {
    _listenOnAnimal();
  }

  _listenOnAnimal() {
    _newAnimalAdded = eventBus.on<NewAnimalCreated>().listen((event) {
      _addAnimal(event.animal);
    });

    _animalUpdated = eventBus.on<AnimalUpdated>().listen((event) {
      _updateAnimal(event.index, event.animal);
    });
  }

  _addAnimal(Map<String, dynamic> animal) {
    animals.add(animal);
    notifyListeners();
    eventBus.fire(GetAnimals(animals));
  }

  deleteAnimal(int? index) {
    animals.removeAt(index!);
    notifyListeners();
    eventBus.fire(GetAnimals(animals));
  }

  _updateAnimal(int index, Map<String, dynamic> animal) {
    animals[index] = animal;
    notifyListeners();
    eventBus.fire(GetAnimals(animals));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _newAnimalAdded?.cancel();
    _animalUpdated?.cancel();
    super.dispose();
  }
}
