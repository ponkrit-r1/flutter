import 'dart:typed_data';

import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/auth/animal_breed.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

  XFile? _selectedImage;

  final Rxn<Uint8List> _displaySelectedImage = Rxn();

  Uint8List? get displaySelectedImage => _displaySelectedImage.value;

  final PetRepository petRepository;

  final Rxn<DateTime> _selectedDate = Rxn();

  DateTime? get selectedDate => _selectedDate.value;

  String? get displayDate => _selectedDate.value != null
      ? DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(_selectedDate.value!)
      : null;

  DateTime? preSelectedDate;

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

  String? get displayPetAge => selectedDate != null
      ? ((DateTime.now().difference(selectedDate!).inDays) ~/ (30)).toString()
      : null;

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
    _selectedImage = file;
    _displaySelectedImage.value = await file.readAsBytes();
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

  onDatePreSelected(DateTime dateTime) {
    preSelectedDate = dateTime;
  }

  onDobSelected(DateTime dateTime) {
    _selectedDate.value = dateTime;
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
    onPetTypeSelect();
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

  onAddPet() async {
    try {
      _isLoading.value = true;
      var petModel = PetModel(
        name: petNameController.text,
        animalType: selectedPetType!.id,
        breed: selectedBreed?.id,
        microchipNumber: microChipController.text,
        dob: selectedDate,
        weight: double.tryParse(weightForm.text) ?? 0.0,
        careSystem: selectedCareSystem ?? '',
        characteristics: characteristicController.text,
        birthMonth: selectedDate!.month,
        birthYear: selectedDate!.year,
      );
      petModel.imageData = displaySelectedImage;

      var response = await petRepository.addPet(petModel, _selectedImage);
      Get.back(result: response);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  checkInformation() {
    _isInformationCompleted.value = petNameController.text.isNotEmpty &&
        selectedPetType != null &&
        selectedBreed != null &&
        selectGender != null &&
        selectedDate != null;
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
