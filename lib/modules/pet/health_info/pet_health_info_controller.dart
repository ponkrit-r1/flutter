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

  // Change: Store per-row vaccine brand options
  final RxList<List<VaccineBrand>> _vaccineBrandOptionsList =
      <List<VaccineBrand>>[].obs;

  List<VaccineBrand> vaccineBrandOptionsAt(int idx) =>
      idx < _vaccineBrandOptionsList.length
          ? _vaccineBrandOptionsList[idx]
          : [];

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

  static const otherVaccineTypeName = 'Others';

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
              .map(
                (e) => VaccineAllergyObject(
                  type: e.otherVaccineType?.isNotEmpty == true
                      ? vaccineTypeOptions.firstWhere(
                          (element) => element.name == otherVaccineTypeName)
                      : e.vaccineType,
                  brand: e.vaccineBrand,
                  otherVaccineBrand: e.otherVaccineType?.isNotEmpty == true
                      ? TextEditingController(text: e.otherVaccineBrand)
                      : null,
                  otherVaccineType: e.otherVaccineType?.isNotEmpty == true
                      ? TextEditingController(text: e.otherVaccineType)
                      : null,
                ),
              )
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
      // Add empty brand options for new row
      _vaccineBrandOptionsList.add([]);
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
      _vaccineAllergyList.add(
        VaccineAllergyObject(
          type: null,
          brand: null,
        ),
      );
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

  Future<void> updateVaccineBrandOptionsByTypeAt(
      int idx, int? vaccineTypeId) async {
    final result =
        await petRepository.getVaccineBrand(vaccineTypeId: vaccineTypeId);
    if (idx < _vaccineBrandOptionsList.length) {
      _vaccineBrandOptionsList[idx] = result;
    } else {
      // Fill up to idx with empty lists if needed
      while (_vaccineBrandOptionsList.length <= idx) {
        _vaccineBrandOptionsList.add([]);
      }
      _vaccineBrandOptionsList[idx] = result;
    }
  }

  onSetVaccineAllergyType(
    int idx,
    VaccineType type,
  ) async {
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
    // Update vaccine brand options for this row
    await updateVaccineBrandOptionsByTypeAt(idx, type.id);

    if (type.name == otherVaccineTypeName) {
      _vaccineAllergyList[idx] = _vaccineAllergyList[idx]?.copyWith(
        otherVaccineType:
            TextEditingController(text: currentItem?.otherVaccineType?.text),
        otherVaccineBrand:
            TextEditingController(text: currentItem?.otherVaccineBrand?.text),
      );
    } else {
      _vaccineAllergyList[idx] = _vaccineAllergyList[idx]?.copyWith(
        otherVaccineType: null,
        otherVaccineBrand: null,
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
    // Add custom 'Other' type to the list
    _vaccineTypeOptions.add(VaccineType(
      id: -1, // Unique id for 'Other'
      name: otherVaccineTypeName,
      animalType: editingPet.animalType,
      type: '', // Provide a default or appropriate value for 'type'
      brands: const [],
      doses: const [], // Provide empty list for required parameter
    ));
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
    if (idx < _vaccineBrandOptionsList.length) {
      _vaccineBrandOptionsList.removeAt(idx);
    }
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
    if (vaccineAllergyList.isNotEmpty) {
      for (var element in vaccineAllergyList) {
        element?.otherVaccineBrand?.dispose();
        element?.otherVaccineType?.dispose();
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
            .where((element) => element.text.isNotEmpty)
            .map((e) => ChronicDisease(
                  name: e.text,
                  pet: editingPet.id!,
                ))
            .toList(),
        foodAllergy: foodAllergyList
            .where((element) => element.text.isNotEmpty)
            .map((e) => FoodAllergy(
                  name: e.text,
                  pet: editingPet.id!,
                ))
            .toList(),
        vaccineAllergy: vaccineAllergyList
            .where(
              (element) => (element?.type?.name == otherVaccineTypeName)
                  ? (element?.otherVaccineType?.text.isNotEmpty ?? false)
                  : true,
            )
            .map((e) => VaccineAllergy(
                  vaccineType:
                      (e?.type?.name == otherVaccineTypeName) ? null : e!.type,
                  vaccineBrand:
                      (e?.type?.name == otherVaccineTypeName) ? null : e?.brand,
                  otherVaccineBrand: e?.type?.name == otherVaccineTypeName
                      ? e?.otherVaccineBrand?.text
                      : "",
                  otherVaccineType: e?.type?.name == otherVaccineTypeName
                      ? e?.otherVaccineType?.text
                      : "",
                  pet: editingPet.id!,
                ))
            .toList(),
        drugAllergy: drugAllergyList
            .where((element) => element.text.isNotEmpty)
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
  final TextEditingController? otherVaccineType;
  final TextEditingController? otherVaccineBrand;

  VaccineAllergyObject({
    required this.type,
    required this.brand,
    this.otherVaccineType,
    this.otherVaccineBrand,
  });

  VaccineAllergyObject copyWith({
    VaccineType? type,
    VaccineBrand? brand,
    TextEditingController? otherVaccineType,
    TextEditingController? otherVaccineBrand,
  }) {
    return VaccineAllergyObject(
      type: type ?? this.type,
      brand: brand ?? this.brand,
      otherVaccineBrand: otherVaccineBrand ?? this.otherVaccineBrand,
      otherVaccineType: otherVaccineType ?? this.otherVaccineType,
    );
  }
}
