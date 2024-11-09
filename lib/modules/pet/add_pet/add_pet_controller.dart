import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/auth/animal_breed.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  String? get displayDate =>
      _selectedDate.value != null
          ? DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
          _selectedDate.value!)
          : null;

  DateTime? preSelectedDate;

  final PetModel? editingPet;

  AddPetController(this.petRepository, {
    this.editingPet,
  });

  var microChipController = TextEditingController();
  var weightForm = TextEditingController();
  var characteristicController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  final _isInformationCompleted = false.obs;

  bool get isInformationCompleted => _isInformationCompleted.value;

  Function(String)? displayError;

  final Rxn<AnimalBreed> _selectedBreed = Rxn();

  AnimalBreed? get selectedBreed => _selectedBreed.value;

  final Rxn<AnimalType> _selectedPetType = Rxn();

  AnimalType? get selectedPetType => _selectedPetType.value;

  final RxnString _selectedCareSystem = RxnString();

  String? get selectedCareSystem => _selectedCareSystem.value;

  String? get displayPetAge =>
      _selectedDate.value != null
          ? ((DateTime
          .now()
          .difference(_selectedDate.value!)
          .inDays) ~/ (30))
          .toString()
          : null;

  final RxnString _selectedGender = RxnString();

  String? get selectGender => _selectedGender.value;

  final RxList<AnimalType> _animalTypes = RxList.empty();

  List<AnimalType> get animalTypes => _animalTypes;

  final RxList<AnimalBreed> _animalBreed = RxList.empty();

  List<AnimalBreed> get animalBreed => _animalBreed;

  var isReselectImageOnEditing = false;

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
    initData();
  }

  initData() async {
    await getAnimalType();
    if (editingPet != null) {
      assignEditingPetData(editingPet!);
    }
  }

  assignEditingPetData(PetModel petModel) async {
    petNameController.text = petModel.name;
    _selectedCareSystem.value = petModel.careSystem;
    microChipController.text = petModel.microchipNumber ?? '';
    weightForm.text = petModel.weight?.toString() ?? '';
    _selectedGender.value = petModel.gender;
    _selectedPetType.value =
        animalTypes.firstWhere((element) => element.id == petModel.animalType);
    onPetTypeSelect();

    onDobSelected(petModel.dob);

    if (petModel.image != null) {
      var data = (await NetworkAssetBundle(Uri.parse(petModel.image!))
          .load(petModel.image!))
          .buffer
          .asUint8List();
      _displaySelectedImage.value = data;
    }
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
    _animalTypes.assignAll(await petRepository.getAnimalType());
    //TODO make this dynamic force length to be two from requirement
    _animalTypes.assignAll(_animalTypes.sublist(0, 2));
  }

  onPetTypeSelect() async {
    if (_selectedPetType.value != null) {
      _animalBreed.value = await petRepository.getAnimalBreed(
        _selectedPetType.value!.id,
      );
      _selectedBreed.value = null;
    }
    checkInformation();
  }

  onDobSelected(DateTime dateTime) {
    _selectedDate.value = dateTime;
    checkInformation();
  }

  setPetType(AnimalType type,
      int idx,) {
    _selectedPetType.value = type;
    onPetTypeSelect();
  }

  setCareSystem(String type,
      int idx,) {
    _selectedCareSystem.value = type;
  }

  setGender(String gender,
      int idx,) {
    _selectedGender.value = gender;
  }

  onNextActionClick() async {
    try {
      _isLoading.value = true;
      var petModel = PetModel(
        name: petNameController.text,
        animalType: selectedPetType!.id,
        breed: selectedBreed?.id,
        microchipNumber: microChipController.text,
        dob: selectedDate!,
        weight: double.tryParse(weightForm.text) ?? 0.0,
        careSystem: selectedCareSystem ?? '',
        characteristics: characteristicController.text,
        gender: _selectedGender.value,
      );
      petModel.imageData = displaySelectedImage;
      PetModel response;
      if (editingPet != null) {
        response = await petRepository.updatePet(
          editingPet!.id!,
          petModel,
          _selectedImage,
        );
      } else {
        response = await petRepository.addPet(petModel, _selectedImage);
      }
      Get.back(result: response);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
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
