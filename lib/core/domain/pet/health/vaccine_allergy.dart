class VaccineAllergy {
  int id;
  int pet;
  String? otherVaccineType;
  String? otherVaccineBrand;
  String? vaccineType;
  String? vaccineBrand;

  VaccineAllergy({
    required this.id,
    required this.pet,
    this.otherVaccineType,
    this.otherVaccineBrand,
    this.vaccineType,
    this.vaccineBrand,
  });

  factory VaccineAllergy.fromJson(Map<String, dynamic> json) {
    return VaccineAllergy(
      id: json['id'] ?? 0,
      pet: json['pet'] ?? 0,
      otherVaccineType: json['other_vaccine_type'],
      otherVaccineBrand: json['other_vaccine_brand'],
      vaccineType: json['vaccine_type'],
      vaccineBrand: json['vaccine_brand'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet': pet,
      'other_vaccine_type': otherVaccineType,
      'other_vaccine_brand': otherVaccineBrand,
      'vaccine_type': vaccineType,
      'vaccine_brand': vaccineBrand,
    };
  }
}
