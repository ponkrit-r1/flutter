import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_brand.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_type.dart';
import 'package:get/get.dart';

class VaccineAllergy {
  int? id;
  int? pet;
  String? otherVaccineType;
  String? otherVaccineBrand;
  VaccineType? vaccineType;
  VaccineBrand? vaccineBrand;

  VaccineAllergy({
    this.id,
    this.pet,
    this.otherVaccineType,
    this.otherVaccineBrand,
    this.vaccineType,
    this.vaccineBrand,
  });

  factory VaccineAllergy.fromJson(
    Map<String, dynamic> json,
    List<VaccineBrand> vaccineBrand,
    List<VaccineType> vaccineType,
  ) {
    return VaccineAllergy(
      id: json['id'],
      pet: json['pet'],
      otherVaccineType: json['other_vaccine_type'],
      otherVaccineBrand: json['other_vaccine_brand'],
      vaccineType: vaccineType.firstWhereOrNull(
        (element) => element.id == json['vaccine_type'],
      ),
      vaccineBrand: vaccineBrand.firstWhereOrNull(
        (element) => element.id == json['vaccine_brand'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'other_vaccine_type': otherVaccineType ?? '',
      'other_vaccine_brand': otherVaccineBrand ?? '',
      'vaccine_type': vaccineType?.id,
      'vaccine_brand': vaccineBrand?.id,
    };
  }
}
