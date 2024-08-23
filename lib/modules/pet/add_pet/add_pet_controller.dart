import 'dart:typed_data';

import 'package:deemmi/core/utils/validator/format_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  final _selectedBreed = ''.obs;

  String get selectedBreed => _selectedBreed.value;

  final RxnString _selectedPetType = RxnString();

  String? get selectedPetType => _selectedPetType.value;

  final RxnString _selectedCareSystem = RxnString();

  String? get selectedCareSystem => _selectedCareSystem.value;

  final _selectedYear = ''.obs;

  String get selectedYear => _selectedYear.value;

  final _selectedMonth = ''.obs;

  String get selectedMonth => _selectedMonth.value;

  final RxnString _selectedGender = RxnString();

  String? get selectGender => _selectedGender.value;

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

  setSelectedBreed(String? breed, int idx) {
    if (breed != null) {
      _selectedBreed.value = breed;
    }
  }

  setSelectedYear(String? year, int idx) {
    if(year != null) {
      _selectedYear.value = year;
    }
  }

  setSelectedMonth(String? month, int idx) {
    if(month != null) {
      _selectedMonth.value = month;
    }
  }

  setTermAccept(bool termAccepted) {
    _isTermAccepted.value = termAccepted;
  }

  setPetType(
    String type,
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
