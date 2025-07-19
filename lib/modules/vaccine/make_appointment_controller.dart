import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/pet_vaccine_record.dart';
import 'package:deemmi/core/domain/pet/clinic.dart';
import 'package:deemmi/core/services/clinic_service.dart';

class MakeAppointmentController extends GetxController {
  final PetRepository petRepository;
  final ClinicService clinicService;

  MakeAppointmentController(this.petRepository, this.clinicService);

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<DateTime?> selectedTime = Rx<DateTime?>(null);
  final Rx<Clinic?> selectedClinic = Rx<Clinic?>(null);
  final RxString otherClinicName = ''.obs;
  final RxString otherClinicPhone = ''.obs;
  final TextEditingController symptomTextController = TextEditingController();
  final RxString selectedSymptom = ''.obs;

  RxList<Clinic> get clinics {
    if (clinicService.clinics.isEmpty) {
      clinicService.initializeClinics(); // Reload data directly
    }
    return clinicService.clinics;
  }

  Future<PetVaccineRecord> updateAppointment(
    int recordId, {
    required DateTime appointedDate,
    String? symptom,
    int? clinicId,
    String? otherClinicName,
    String? otherClinicTelephone,
  }) async {
    final data = {
      'appointed_date': appointedDate.toIso8601String(),
      if (symptom != null) 'symptom_before': symptom,
      'appointed_clinic': clinicId != null && clinicId != -1 ? clinicId : null,
      if (otherClinicName != null)
        'appointed_other_clinic_name': otherClinicName,
      if (otherClinicTelephone != null)
        'appointed_other_clinic_telephone': otherClinicTelephone,
    };
    return await petRepository.updatePetVaccineRecord(recordId, data);
  }

  Future<void> fetchAppointmentData(int recordId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final appointmentData = await petRepository.getPetVaccineRecord(recordId);

      selectedDate.value = appointmentData.appointedDate?.toLocal();
      selectedTime.value = appointmentData.appointedDate?.toLocal();
      selectedClinic.value = clinicService.clinics.firstWhereOrNull(
        (clinic) => clinic.id == appointmentData.appointedClinicId,
      );

      if (selectedClinic.value == null &&
          appointmentData.appointedOtherClinicName != null &&
          appointmentData.appointedOtherClinicName != '') {
        selectedClinic.value =
            ClinicService.othersClinic; // Set to "Others" clinic
        otherClinicName.value = appointmentData.appointedOtherClinicName ?? '';
        otherClinicPhone.value =
            appointmentData.appointedOtherClinicTelephone ?? '';
      }

      symptomTextController.text = appointmentData.symptomBefore ?? '';
    } catch (e) {
      errorMessage.value = 'Failed to load appointment data';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> initializeAppointment(int recordId) async {
    await fetchAppointmentData(recordId);
  }

  DateTime? getCombinedDateTime() {
    if (selectedDate.value == null || selectedTime.value == null) {
      return null;
    }
    return DateTime(
      selectedDate.value!.year,
      selectedDate.value!.month,
      selectedDate.value!.day,
      selectedTime.value!.hour,
      selectedTime.value!.minute,
    );
  }
}
