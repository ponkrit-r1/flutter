import 'package:deemmi/core/domain/pet/health/vaccine_allergy.dart';

import 'chronic_disease.dart';
import 'drug_allergy.dart';
import 'food_allergy.dart';

class PetHealthInfo {
  bool hasVaccineAllergy;
  bool hasDrugAllergy;
  String? sterilization;
  int pet;
  List<ChronicDisease> chronicDisease;
  List<FoodAllergy> foodAllergy;
  List<VaccineAllergy> vaccineAllergy;
  List<DrugAllergy> drugAllergy;

  PetHealthInfo({
    required this.hasVaccineAllergy,
    required this.hasDrugAllergy,
    this.sterilization,
    required this.pet,
    required this.chronicDisease,
    required this.foodAllergy,
    required this.vaccineAllergy,
    required this.drugAllergy,
  });

  factory PetHealthInfo.fromJson(Map<String, dynamic> json) {
    return PetHealthInfo(
      hasVaccineAllergy: json['has_vaccine_allergy'] ?? false,
      hasDrugAllergy: json['has_drug_allergy'] ?? false,
      sterilization: json['sterilization'],
      pet: json['pet'] ?? 0,
      chronicDisease: (json['chronic_disease'] as List<dynamic>)
          .map((e) => ChronicDisease.fromJson(e))
          .toList(),
      foodAllergy: (json['food_allergy'] as List<dynamic>)
          .map((e) => FoodAllergy.fromJson(e))
          .toList(),
      vaccineAllergy: (json['vaccine_allergy'] as List<dynamic>)
          .map((e) => VaccineAllergy.fromJson(e))
          .toList(),
      drugAllergy: (json['drug_allergy'] as List<dynamic>)
          .map((e) => DrugAllergy.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'has_vaccine_allergy': hasVaccineAllergy,
      'has_drug_allergy': hasDrugAllergy,
      'sterilization': sterilization,
      'pet': pet,
      'chronic_disease': chronicDisease.map((e) => e.toJson()).toList(),
      'food_allergy': foodAllergy.map((e) => e.toJson()).toList(),
      'vaccine_allergy': vaccineAllergy.map((e) => e.toJson()).toList(),
      'drug_allergy': drugAllergy.map((e) => e.toJson()).toList(),
    };
  }
}
