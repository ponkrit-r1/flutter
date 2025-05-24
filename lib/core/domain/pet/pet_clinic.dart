import 'package:deemmi/core/domain/pet/clinic.dart';
import 'package:get/get.dart';

class PetClinic {
  final int? id;
  final String? otherClinicName;
  final String? otherClinicTelephone;
  final int petId;
  final int? clinicId;
  Clinic? petClinic;

  PetClinic({
    this.id,
    this.otherClinicName,
    this.otherClinicTelephone,
    required this.petId,
    this.clinicId,
  });

  factory PetClinic.fromJson(Map<String, dynamic> json) {
    return PetClinic(
      id: json['id'],
      otherClinicName: json['other_clinic_name'],
      otherClinicTelephone: json['other_clinic_telephone'],
      petId: json['pet'],
      clinicId: json['clinic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'other_clinic_name': otherClinicName,
      'other_clinic_telephone': otherClinicTelephone,
      'pet': petId,
      'clinic': clinicId,
    };
  }

  assignPetClinic(List<Clinic> petClinics) {
    petClinic =
        petClinics.firstWhereOrNull((element) => element.id == clinicId);
  }
}
