class PetVaccineRecord {
  final int id;
  final int petId;
  final int programId;
  final int doseId;
  final int doseNumber;
  final String status;
  final DateTime suggestedDate;
  final DateTime? appointedDate;
  final DateTime? vaccinationDate;
  final int? appointedClinicId;
  final String? appointedOtherClinicName;
  final String? appointedOtherClinicTelephone;
  final int? vaccinatedClinicId;
  final String? vaccinatedOtherClinicName;
  final String? vaccinatedOtherClinicTelephone;
  final String? symptomBefore;
  final String? symptomAfter;
  final int? vaccinatedBrandId;

  PetVaccineRecord({
    required this.id,
    required this.petId,
    required this.programId,
    required this.doseId,
    required this.status,
    required this.suggestedDate,
    required this.doseNumber,
    this.appointedDate,
    this.vaccinationDate,
    this.appointedClinicId,
    this.appointedOtherClinicName,
    this.appointedOtherClinicTelephone,
    this.vaccinatedClinicId,
    this.vaccinatedOtherClinicName,
    this.vaccinatedOtherClinicTelephone,
    this.symptomBefore,
    this.symptomAfter,
    this.vaccinatedBrandId,
  });

  factory PetVaccineRecord.fromJson(Map<String, dynamic> json) {
    return PetVaccineRecord(
      id: json['id'] as int,
      petId: json['pet'] as int,
      programId: json['program'] as int,
      doseId: json['dose'] as int,
      status: json['status'] as String,
      suggestedDate: DateTime.parse(json['suggested_date'] as String),
      appointedDate: json['appointed_date'] != null
          ? DateTime.parse(json['appointed_date'])
          : null,
      vaccinationDate: json['vaccination_date'] != null
          ? DateTime.parse(json['vaccination_date'])
          : null,
      appointedClinicId: json['appointed_clinic'] as int?,
      appointedOtherClinicName: json['appointed_other_clinic_name'] as String?,
      appointedOtherClinicTelephone:
          json['appointed_other_clinic_telephone'] as String?,
      vaccinatedClinicId: json['vaccinated_clinic'] as int?,
      vaccinatedOtherClinicName:
          json['vaccinated_other_clinic_name'] as String?,
      vaccinatedOtherClinicTelephone:
          json['vaccinated_other_clinic_telephone'] as String?,
      symptomBefore: json['symptom_before'] as String?,
      symptomAfter: json['symptom_after'] as String?,
      vaccinatedBrandId: json['vaccinated_brand'] as int?,
      doseNumber: json['dose_number'] as int,
    );
  }
}
