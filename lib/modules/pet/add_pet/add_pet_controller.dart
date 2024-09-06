import 'dart:typed_data';

import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/auth/animal_breed.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:deemmi/core/utils/validator/format_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/domain/auth/animal_type.dart';

class AddPetController extends GetxController {
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  var petNameController = TextEditingController();

  final RxnBool _isEmailFormatCorrect = RxnBool();

  bool? get isEmailFormatCorrect => _isEmailFormatCorrect.value;

  final RxnBool _isPasswordFormatCorrect = RxnBool();

  bool? get isPasswordFormatCorrect => _isPasswordFormatCorrect.value;

  final RxnBool _isConfirmPasswordMatched = RxnBool();

  bool? get isConfirmPasswordMatched => _isConfirmPasswordMatched.value;

  final Rxn<Uint8List> _selectedImage = Rxn();

  Uint8List? get selectedImage => _selectedImage.value;

  final PetRepository petRepository;

  AddPetController(this.petRepository);

  var microChipController = TextEditingController();
  var weightForm = TextEditingController();
  var characteristicController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  final _isInformationCompleted = false.obs;

  bool get isInformationCompleted => _isInformationCompleted.value;

  final _isTermAccepted = false.obs;

  bool get isTermAccepted => _isTermAccepted.value;

  Function(String)? displayError;

  final Rxn<AnimalBreed> _selectedBreed = Rxn();

  AnimalBreed? get selectedBreed => _selectedBreed.value;

  final Rxn<AnimalType> _selectedPetType = Rxn();

  AnimalType? get selectedPetType => _selectedPetType.value;

  final RxnString _selectedCareSystem = RxnString();

  String? get selectedCareSystem => _selectedCareSystem.value;

  final _selectedYear = ''.obs;

  String get selectedYear => _selectedYear.value;

  int? _selectedYearIdx;

  final _selectedMonth = ''.obs;

  String get selectedMonth => _selectedMonth.value;

  int? _selectedMonthIdx;

  String? get displayPetAge => null;

  final RxnString _selectedGender = RxnString();

  String? get selectGender => _selectedGender.value;

  final RxList<AnimalType> _animalTypes = RxList.empty();

  // List<AnimalType> get animalTypes => _animalTypes;
  List<AnimalType> get animalTypes =>
      [AnimalType(id: 1, name: "Dog"), AnimalType(id: 2, name: "Cat"), AnimalType(id: 3, name: "Rabbit")];

  final RxList<AnimalBreed> _animalBreed = RxList.empty();

  //List<AnimalBreed> get animalBreed => _animalBreed;

  List<AnimalBreed> get animalBreed => [
        AnimalBreed(id: 1, name: 'Labrador Retriever'),
        AnimalBreed(id: 2, name: 'German Shepherd'),
        AnimalBreed(id: 3, name: 'Golden Retriever'),
        AnimalBreed(id: 4, name: 'Bulldog'),
        AnimalBreed(id: 5, name: 'Poodle'),
        AnimalBreed(id: 6, name: 'Beagle'),
        AnimalBreed(id: 7, name: 'Rottweiler'),
        AnimalBreed(id: 8, name: 'Yorkshire Terrier'),
        AnimalBreed(id: 9, name: 'Boxer'),
        AnimalBreed(id: 10, name: 'Dachshund'),
        AnimalBreed(id: 11, name: 'Siberian Husky'),
        AnimalBreed(id: 12, name: 'Great Dane'),
        AnimalBreed(id: 13, name: 'Doberman Pinscher'),
        AnimalBreed(id: 14, name: 'Australian Shepherd'),
        AnimalBreed(id: 15, name: 'Shih Tzu'),
      ];

  @override
  void onReady() {
    super.onReady();
    petNameController.addListener(() {
      checkInformation();
    });
    microChipController.addListener(() {
      checkInformation();
    });

    weightForm.addListener(() {
      checkInformation();
    });
    getAnimalType();
  }

  setSelectedImage(XFile file) async {
    _selectedImage.value = await file.readAsBytes();
    checkInformation();
  }

  setSelectedBreed(AnimalBreed breed) {
    _selectedBreed.value = breed;
    checkInformation();
  }

  getAnimalType() async {
    _animalTypes.value = await petRepository.getAnimalType();
  }

  onPetTypeSelect() async {
    if (_selectedPetType.value != null) {
      _animalBreed.value = await petRepository.getAnimalBreed(
        _selectedPetType.value!.id,
      );
    }
    checkInformation();
  }

  String? getDisplayAge(String month, String year) {
    if (month.isNotEmpty && year.isNotEmpty) {
      return ((DateTime(int.parse(year), 1, 1)
                  .difference(DateTime.now())
                  .inDays) ~/
              30)
          .abs()
          .toString();
    } else {
      return null;
    }
  }

  setSelectedYear(String? year) {
    if (year != null) {
      _selectedYear.value = year;
    }
    checkInformation();
  }

  setSelectedMonth(String? month) {
    if (month != null) {
      _selectedMonth.value = month;
      _selectedMonthIdx = 0;
    }
    checkInformation();
  }

  setTermAccept(bool termAccepted) {
    _isTermAccepted.value = termAccepted;
  }

  setPetType(
    AnimalType type,
    int idx,
  ) {
    _selectedPetType.value = type;
  }

  setCareSystem(
    String type,
    int idx,
  ) {
    _selectedCareSystem.value = type;
  }

  setGender(
    String gender,
    int idx,
  ) {
    _selectedGender.value = gender;
  }

  onAddPet() {
    var petModel = PetModel(
      owner: "",
      name: petNameController.text,
      animalType: selectedPetType!.id,
      breed: selectedBreed!.name,
      microchipNumber: microChipController.text,
      dob: null,
      weight: double.tryParse(weightForm.text) ?? 0.0,
      careSystem: 'Outdoor',
      characteristics: characteristicController.text,
      birthMonth: 0,
      birthYear: 0,
    );
    petModel.imageData = selectedImage;

    Get.back(result: petModel);
    var pet = petRepository.addPet(petModel);
  }

  checkInformation() {
    _isInformationCompleted.value = petNameController.text.isNotEmpty &&
        selectedPetType != null &&
        selectedBreed != null &&
    selectGender != null &&
    _selectedYear.isNotEmpty && _selectedMonth.isNotEmpty;
  }

  @override
  void onClose() {
    super.onClose();
    petNameController.dispose();
    microChipController.dispose();
    weightForm.dispose();
    characteristicController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }
}
