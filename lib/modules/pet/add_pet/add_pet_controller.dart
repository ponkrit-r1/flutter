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

  String? get displayPetAge => getDisplayAge(selectedMonth, selectedYear);

  final RxnString _selectedGender = RxnString();

  String? get selectGender => _selectedGender.value;

  final RxList<AnimalType> _animalTypes = RxList.empty();

  List<AnimalType> get animalTypes => _animalTypes;

  final RxList<AnimalBreed> _animalBreed = RxList.empty();

  List<AnimalBreed> get animalBreed => _animalBreed;

  @override
  void onReady() {
    super.onReady();
    petNameController.addListener(() {
      checkInformation();
      _isEmailFormatCorrect.value = petNameController.text.validateEmail();
    });
    microChipController.addListener(() {
      checkInformation();
      _isPasswordFormatCorrect.value = microChipController.text.validateEmail();
    });

    weightForm.addListener(() {
      checkInformation();
      _isConfirmPasswordMatched.value =
          weightForm.text == microChipController.text;
    });
  }

  setSelectedImage(XFile file) async {
    _selectedImage.value = await file.readAsBytes();
  }

  setSelectedBreed(AnimalBreed breed) {
    _selectedBreed.value = breed;
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
  }

  String? getDisplayAge(String month, String year) {
    if (month.isNotEmpty && year.isNotEmpty) {
      return ((DateTime(int.parse(year), _selectedMonthIdx! + 1, 1)
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
  }

  setSelectedMonth(String? month) {
    if (month != null) {
      _selectedMonth.value = month;
      // _selectedMonthIdx = idx;
    }
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
    var pet = petRepository.addPet(
      PetModel(
        owner: "",
        name: petNameController.text,
        animalType: 1,
        microchipNumber: microChipController.text,
        dob: null,
        weight: double.tryParse(weightForm.text) ?? 0.0,
        careSystem: 'Outdoor',
        characteristics: characteristicController.text,
        birthMonth: _selectedMonthIdx!,
        birthYear: _selectedYearIdx!,
      ),
    );
  }

  checkInformation() {
    _isInformationCompleted.value = petNameController.text.validateEmail() &&
        microChipController.text.isNotEmpty &&
        characteristicController.text.isNotEmpty &&
        weightForm.text.isNotEmpty &&
        microChipController.text == weightForm.text;
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
