import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/pet_vaccine_record.dart';
import 'package:deemmi/core/domain/pet/clinic.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_brand.dart';
import 'package:deemmi/core/services/clinic_service.dart';

class VaccinatedDateController extends GetxController {
  final PetRepository petRepository;
  final ClinicService clinicService;

  VaccinatedDateController(this.petRepository, this.clinicService);

  final selectedClinic = Rxn<Clinic>();
  final RxList<VaccineBrand> vaccineBrands = RxList.empty();
  final selectedBrand = Rxn<VaccineBrand>();

  // Added properties for other clinic name and phone
  final otherClinicName = RxString('');
  final otherClinicPhone = RxString('');

  final TextEditingController symptomTextController = TextEditingController();
  final RxString selectedSymptom = ''.obs;

  // Added properties for selected date and vaccine brand ID
  final selectedDate = Rxn<DateTime>();
  final vaccineBrandId = Rxn<int>();

  // Loading state
  final RxBool isLoading = false.obs;

  RxList<Clinic> get clinics {
    if (clinicService.clinics.isEmpty) {
      clinicService.initializeClinics(); // Reload data directly
    }
    return clinicService.clinics;
  }

  void onSelectedClinic(Clinic clinic) {
    selectedClinic.value = clinic;
  }

  Future<void> fetchVaccineBrands(int vaccineTypeId) async {
    try {
      vaccineBrands.value = await petRepository.getVaccineBrands(vaccineTypeId);
    } catch (e) {
      // Handle error
    }
  }

  Future<PetVaccineRecord> updateVaccinationDate(
    int recordId, {
    required DateTime vaccinationDate,
    String? symptom,
    Clinic? clinic,
    String? otherClinicName,
    String? otherClinicTelephone,
    VaccineBrand? vaccineBrand,
  }) async {
    final data = {
      'vaccination_date': vaccinationDate.toIso8601String().split('T')[0],
      if (symptom != null) 'symptom_after': symptom,
      'vaccinated_clinic': clinic?.id == -1 ? null : clinic?.id,
      if (otherClinicName != null)
        'vaccinated_other_clinic_name': otherClinicName,
      if (otherClinicTelephone != null)
        'vaccinated_other_clinic_telephone': otherClinicTelephone,
      if (vaccineBrand != null) 'vaccinated_brand': vaccineBrand.id,
    };
    return await petRepository.updatePetVaccineRecord(recordId, data);
  }

  // Added method to fetch appointment data
  Future<void> fetchAppointmentData(int recordId) async {
    try {
      final record = await petRepository.getPetVaccineRecord(recordId);
      selectedDate.value = record.vaccinationDate?.toLocal();
      selectedClinic.value = clinics.firstWhereOrNull(
        (clinic) => clinic.id == record.vaccinatedClinicId,
      );
      selectedBrand.value = vaccineBrands.firstWhereOrNull(
        (brand) => brand.id == record.vaccinatedBrandId,
      );

      if (selectedClinic.value == null &&
          record.vaccinatedOtherClinicName != null &&
          record.vaccinatedOtherClinicName != '') {
        selectedClinic.value =
            ClinicService.othersClinic; // Set to "Others" clinic
        otherClinicName.value = record.vaccinatedOtherClinicName ?? '';
        otherClinicPhone.value = record.vaccinatedOtherClinicTelephone ?? '';
      }

      symptomTextController.text = record.symptomAfter ?? '';

      // selectedSymptom.value = record.symptomAfter ?? 'Normal';
    } catch (e) {
      // Handle error
    }
  }

  // New method to initialize clinics, vaccine brands, and appointment data
  Future<void> initializeData(int recordId, int vaccineTypeId) async {
    isLoading.value = true;
    await fetchVaccineBrands(vaccineTypeId);
    await fetchAppointmentData(recordId);
    isLoading.value = false;
  }

  DateTime initialVaccinationDate(DateTime vaccinationMaxDate) {
    if (selectedDate.value == null) {
      selectedDate.value = DateTime.now();
    }
    if (selectedDate.value!
        .isAfter(vaccinationMaxDate.subtract(const Duration(days: 1)))) {
      selectedDate.value = vaccinationMaxDate.subtract(const Duration(days: 1));
    }
    return selectedDate.value!;
  }
}
