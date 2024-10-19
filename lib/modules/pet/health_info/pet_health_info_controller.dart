import 'dart:ui';

import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/answer_choice.dart';
import 'package:get/get.dart';

import '../../../core/domain/pet/pet_model.dart';

class PetHealthInfoController extends GetxController {
  final PetRepository petRepository;

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

  AnswerChoice? get drugAllergyAnswer => _drugAllergyAnswer.value;

  final PetModel? editingPet;

  PetHealthInfoController(
    this.petRepository,
    this.editingPet,
  );

  setSterilizationAnswer(AnswerChoice answer) {
    _sterilizationAnswer.value = answer;
  }

  setChronicDiseaseAnswer(AnswerChoice answer) {
    _chronicDiseaseAnswer.value = answer;
  }

  setFoodAllergyAnswer(AnswerChoice answer) {
    _foodAllergyAnswer.value = answer;
  }

  setVaccineAllergy(AnswerChoice answer) {
    _vaccineAllergyAnswer.value = answer;
  }

  setDrugAllergy(AnswerChoice answer) {
    _drugAllergyAnswer.value = answer;
  }
}
