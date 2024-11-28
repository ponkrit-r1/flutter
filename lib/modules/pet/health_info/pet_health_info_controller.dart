import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/answer_choice.dart';
import 'package:deemmi/core/domain/pet/health/chronic_disease.dart';
import 'package:deemmi/core/domain/pet/health/drug_allergy.dart';
import 'package:deemmi/core/domain/pet/health/food_allergy.dart';
import 'package:deemmi/core/domain/pet/health/pet_health_info.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_type.dart';
import 'package:deemmi/core/domain/pet/health/vaccine_allergy.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/domain/pet/health/vaccine/vaccine_brand.dart';
import '../../../core/domain/pet/pet_model.dart';

class PetHealthInfoController extends GetxController {
  final PetRepository petRepository;

  final _isLoading = false.obs;

  final PetHealthInfo? editingHealthInfo;

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
    this.editingHealthInfo,
  );

  @override
  onReady() async {
    super.onReady();
    await getVaccineData();
    if (editingHealthInfo != null) {
      assignHealthInfo();
    }
  }

  assignHealthInfo() {
    if (editingHealthInfo != null) {
      switch (editingHealthInfo!.sterilization) {
        case true:
          _sterilizationAnswer.value = threeChoiceAnswer[0];
          break;
        case false:
          _sterilizationAnswer.value = threeChoiceAnswer[1];
          break;
        case null:
          _sterilizationAnswer.value = threeChoiceAnswer[2];
      }
      switch (editingHealthInfo!.hasDrugAllergy) {
        case true:
          setDrugAllergy(threeChoiceAnswer[0]);
          _drugAllergyList.value = editingHealthInfo!.drugAllergy.map((e) {
            var controller = TextEditingController();
            controller.text = e.name;
            return controller;
          }).toList();
          break;
        case false:
          setDrugAllergy(threeChoiceAnswer[1]);
          break;
        case null:
          setDrugAllergy(threeChoiceAnswer[2]);
      }
      switch (editingHealthInfo!.hasVaccineAllergy) {
        case true:
          setVaccineAllergy(threeChoiceAnswer[0]);
          _vaccineAllergyList.value = editingHealthInfo!.vaccineAllergy
              .map((e) => VaccineAllergyObject(
                  type: e.vaccineType, brand: e.vaccineBrand))
              .toList();
          break;
        case false:
          setVaccineAllergy(threeChoiceAnswer[1]);
          break;
        case null:
          setVaccineAllergy(threeChoiceAnswer[2]);
      }

      _foodAllergyList.value = editingHealthInfo!.foodAllergy.map((e) {
        var controller = TextEditingController();
        controller.text = e.name;
        return controller;
      }).toList();
      setFoodAllergyAnswer(
        editingHealthInfo!.foodAllergy.isNotEmpty
            ? twoChoiceAnswer[0]
            : twoChoiceAnswer[1],
      );

      _chronicDiseaseList.value = editingHealthInfo!.chronicDisease.map((e) {
        var controller = TextEditingController();
        controller.text = e.name;
        return controller;
      }).toList();
      setChronicDiseaseAnswer(
        editingHealthInfo!.chronicDisease.isNotEmpty
            ? twoChoiceAnswer[0]
            : twoChoiceAnswer[1],
      );
    }
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

  onAddVaccineAllergy() {
    if (_vaccineAllergyList.length <= 10) {
      _vaccineAllergyList.add(
        VaccineAllergyObject(
          type: null,
          brand: null,
        ),
      );
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

  onUpdatePetHealthInfo() async {
    if (vaccineAllergyAnswer?.option != AnswerOption.yes) {
      vaccineAllergyList.clear();
    }
    if (drugAllergyAnswer?.option != AnswerOption.yes) {
      drugAllergyList.clear();
    }
    if (chronicDiseaseAnswer?.option != AnswerOption.yes) {
      chronicDiseaseList.clear();
    }
    if (foodAllergyAnswer?.option != AnswerOption.yes) {
      foodAllergyList.clear();
    }
    await petRepository.updatePetHealthInfo(
      editingPet.id!,
      PetHealthInfo(
        sterilization: (sterilizationAnswer?.option != null)
            ? sterilizationAnswer?.option == AnswerOption.yes
            : null,
        hasVaccineAllergy: vaccineAllergyAnswer?.option == AnswerOption.yes,
        hasDrugAllergy: drugAllergyAnswer?.option == AnswerOption.yes,
        pet: editingPet.id!,
        chronicDisease: chronicDiseaseList
            .map((e) => ChronicDisease(
                  name: e.text,
                  pet: editingPet.id!,
                ))
            .toList(),
        foodAllergy: foodAllergyList
            .map((e) => FoodAllergy(
                  name: e.text,
                  pet: editingPet.id!,
                ))
            .toList(),
        vaccineAllergy: vaccineAllergyList
            .map((e) => VaccineAllergy(
                  vaccineType: e!.type,
                  vaccineBrand: e.brand,
                  pet: editingPet.id!,
                ))
            .toList(),
        drugAllergy: drugAllergyList
            .map(
              (e) => DrugAllergy(
                name: e.text,
                pet: editingPet.id!,
              ),
            )
            .toList(),
      ),
    );
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
