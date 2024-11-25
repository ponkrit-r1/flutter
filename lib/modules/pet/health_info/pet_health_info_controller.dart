import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/answer_choice.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/domain/pet/health/vaccine/vaccine_brand.dart';
import '../../../core/domain/pet/pet_model.dart';

class PetHealthInfoController extends GetxController {
  final PetRepository petRepository;

  final RxBool isHealthInfoExpanded = false.obs; // Add this variable
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  List<AnswerChoice> get twoChoiceAnswer => [
        AnswerChoice(option: AnswerOption.yes, locale: const Locale("en")),
        AnswerChoice(option: AnswerOption.no, locale: const Locale("en")),
      ];

  List<AnswerChoice> get threeChoiceAnswer => [
        AnswerChoice(option: AnswerOption.yes, locale: const Locale("en")),
        AnswerChoice(option: AnswerOption.no, locale: const Locale("en")),
        AnswerChoice(
            option: AnswerOption.doNotKnow, locale: const Locale("en")),
      ];

  final Rxn<AnswerChoice> _sterilizationAnswer = Rxn();

  AnswerChoice? get sterilizationAnswer => _sterilizationAnswer.value;

  final Rxn<AnswerChoice> _chronicDiseaseAnswer = Rxn();

  AnswerChoice? get chronicDiseaseAnswer => _chronicDiseaseAnswer.value;

  final Rxn<AnswerChoice> _foodAllergyAnswer = Rxn();

  AnswerChoice? get foodAllergyAnswer => _foodAllergyAnswer.value;

  final Rxn<AnswerChoice> _vaccineAllergyAnswer = Rxn();

  AnswerChoice? get vaccineAllergyAnswer => _vaccineAllergyAnswer.value;

  final Rxn<AnswerChoice> _drugAllergyAnswer = Rxn();

  final RxList<VaccineType> _vaccineTypeOptions = RxList.empty();

  List<VaccineType> get vaccineTypeOptions => _vaccineTypeOptions;

  final RxList<VaccineBrand> _vaccineBrandOptions = RxList.empty();

  List<VaccineAllergyObject?> get vaccineAllergyList => _vaccineAllergyList;

  final RxList<VaccineAllergyObject?> _vaccineAllergyList = RxList.empty();

  List<VaccineBrand> get vaccineBrandOptions => _vaccineBrandOptions;

  AnswerChoice? get drugAllergyAnswer => _drugAllergyAnswer.value;

  bool get shouldDisplayAddChronicDiseaseSection =>
      chronicDiseaseAnswer?.option == AnswerOption.yes;

  bool get shouldDisplayAddFoodAllergySection =>
      foodAllergyAnswer?.option == AnswerOption.yes;

  bool get getShouldDisplayVaccineAllergySection =>
      vaccineAllergyAnswer?.option == AnswerOption.yes;

  bool get getDrugAllergySection =>
      drugAllergyAnswer?.option == AnswerOption.yes;

  final RxList<TextEditingController> _chronicDiseaseList = RxList();

  List<TextEditingController> get chronicDiseaseList => _chronicDiseaseList;

  final RxList<TextEditingController> _foodAllergyList = RxList();

  List<TextEditingController> get foodAllergyList => _foodAllergyList;

  final RxList<TextEditingController> _drugAllergyList = RxList();

  List<TextEditingController> get drugAllergyList => _drugAllergyList;

  final PetModel editingPet;

  PetHealthInfoController(
    this.petRepository,
    this.editingPet,
  );

  @override
  onReady() {
    super.onReady();
    getVaccineData();
  }

  setSterilizationAnswer(AnswerChoice answer) {
    _sterilizationAnswer.value = answer;
  }

  setChronicDiseaseAnswer(AnswerChoice answer) {
    _chronicDiseaseAnswer.value = answer;
    if (answer.option == AnswerOption.yes && _chronicDiseaseList.isEmpty) {
      _chronicDiseaseList.add(TextEditingController());
    }
  }

  // Add a toggle method for expansion
void toggleHealthInfoExpanded() {
  isHealthInfoExpanded.value = !isHealthInfoExpanded.value;
}

  onAddVaccineAllergy() {
    if (_vaccineAllergyList.length <= 10) {
      _vaccineAllergyList.add(null);
    }
  }

  onAddChronicDisease() {
    if (_chronicDiseaseList.length <= 10) {
      _chronicDiseaseList.add(TextEditingController());
    }
  }

  setFoodAllergyAnswer(AnswerChoice answer) {
    _foodAllergyAnswer.value = answer;
    if (answer.option == AnswerOption.yes && foodAllergyList.isEmpty) {
      _foodAllergyList.add(TextEditingController());
    }
  }

  onAddFoodAllergy() {
    if (foodAllergyList.length <= 10) {
      _foodAllergyList.add(TextEditingController());
    }
  }

  setVaccineAllergy(AnswerChoice answer) {
    _vaccineAllergyAnswer.value = answer;
    if (answer.option == AnswerOption.yes && drugAllergyList.isEmpty) {
      _vaccineAllergyList.add(null);
    }
  }

  onSetVaccineAllergyBrand(
    int idx,
    VaccineBrand brand,
  ) {
    var currentItem = _vaccineAllergyList.elementAt(idx);
    if (currentItem != null) {
      _vaccineAllergyList[idx] = currentItem.copyWith(
        brand: brand,
      );
    } else {
      _vaccineAllergyList[idx] = VaccineAllergyObject(
        brand: brand,
        type: null,
      );
    }
  }

  onSetVaccineAllergyType(
    int idx,
    VaccineType type,
  ) {
    var currentItem = _vaccineAllergyList.elementAt(idx);
    if (currentItem != null) {
      _vaccineAllergyList[idx] = currentItem.copyWith(
        type: type,
      );
    } else {
      _vaccineAllergyList[idx] = VaccineAllergyObject(
        type: type,
        brand: null,
      );
    }
  }

  setDrugAllergy(AnswerChoice answer) {
    _drugAllergyAnswer.value = answer;
    if (answer.option == AnswerOption.yes && drugAllergyList.isEmpty) {
      _drugAllergyList.add(TextEditingController());
    }
  }

  onAddDrugAllergy() {
    if (drugAllergyList.length <= 10) {
      drugAllergyList.add(TextEditingController());
    }
  }

  getVaccineData() async {
    _vaccineTypeOptions.value =
        await petRepository.getVaccineType(editingPet.animalType);
    _vaccineBrandOptions.value = await petRepository.getVaccineBrand();
  }

  onDeleteFoodAllergy(int idx) {
    foodAllergyList.removeAt(idx);
  }

  onDeleteChronicDisease(int idx) {
    chronicDiseaseList.removeAt(idx);
  }

  onDeleteDrugAllergy(int idx) {
    drugAllergyList.removeAt(idx);
  }

  onDeleteVaccineAllergy(int idx) {
    _vaccineAllergyList.removeAt(idx);
  }

  disposeTextEditor() {
    if (chronicDiseaseList.isNotEmpty) {
      for (var element in chronicDiseaseList) {
        element.dispose();
      }
    }
    if (foodAllergyList.isNotEmpty) {
      for (var element in foodAllergyList) {
        element.dispose();
      }
    }
    if (drugAllergyList.isNotEmpty) {
      for (var element in drugAllergyList) {
        element.dispose();
      }
    }
  }

  @override
  void dispose() {
    disposeTextEditor();
    super.dispose();
  }
}

class VaccineAllergyObject {
  final VaccineType? type;
  final VaccineBrand? brand;

  VaccineAllergyObject({required this.type, required this.brand});

  VaccineAllergyObject copyWith({
    VaccineType? type,
    VaccineBrand? brand,
  }) {
    return VaccineAllergyObject(
      type: type ?? this.type,
      brand: brand ?? this.brand,
    );
  }
}
