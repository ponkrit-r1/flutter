import 'package:deemmi/common/widgets/app_dropdown_form_field.dart';
import 'package:deemmi/common/widgets/app_input_form_field.dart';
import 'package:deemmi/core/domain/pet/clinic.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_brand.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import 'vaccinated_date_controller.dart';

class VaccinatedDatePage extends StatefulWidget {
  const VaccinatedDatePage({super.key});

  @override
  VaccinatedDatePageState createState() => VaccinatedDatePageState();
}

class VaccinatedDatePageState extends State<VaccinatedDatePage> {
  final VaccinatedDateController controller =
      Get.find<VaccinatedDateController>();
  // Define controllers for other clinic name and phone number
  final TextEditingController otherClinicNameController =
      TextEditingController();
  final TextEditingController otherClinicPhoneController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    final recordId = Get.arguments?[RouteParams.recordId];
    final vaccineTypeId = Get.arguments?[RouteParams.vaccineTypeId];

    if (recordId != null && vaccineTypeId != null) {
      controller.initializeData(recordId, vaccineTypeId).then((_) {
        otherClinicNameController.text = controller.otherClinicName.value;
        otherClinicPhoneController.text = controller.otherClinicPhone.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final petModel = Get.arguments?[RouteParams.petModel];
    final recordId = Get.arguments?[RouteParams.recordId];
    final doseTitle = Get.arguments?['doseTitle'] ?? 'Unknown Dose';
    final doseDesc = Get.arguments?['doseDesc'] ?? 'No Description';
    final vaccinationMaxDate =
        Get.arguments['vaccindationMaxDate'] as DateTime? ?? DateTime(2101);

    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            title: const Text(
              "Vaccinated date",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (petModel == null) {
        return Scaffold(
          appBar: AppBar(title: const Text("Error")),
          body: const Center(child: Text("Pet data is missing!")),
        );
      }

      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back(result: true); // Pass true to indicate success
            },
          ),
          title: const Text(
            "Vaccinated date",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doseTitle,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  doseDesc,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 16),
                const Text("Vaccinated date",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Obx(() => _buildRoundedContainer(
                      icon: Icons.calendar_today,
                      hintText: controller.selectedDate.value == null
                          ? "Select date"
                          : '${controller.selectedDate.value!.day} ${_monthName(controller.selectedDate.value!.month)} ${controller.selectedDate.value!.year}',
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: controller
                              .initialVaccinationDate(vaccinationMaxDate),
                          firstDate: DateTime.now().subtract(
                              Duration(days: 15 * 365)), // 15 years ago
                          lastDate: vaccinationMaxDate
                              .subtract(const Duration(days: 1)),
                        );
                        if (picked != null) {
                          controller.selectedDate.value = picked;
                        }
                      },
                    )),
                const SizedBox(height: 8),
                _clinicSelection(),
                const SizedBox(height: 8),
                _brandSelection(),
                const SizedBox(height: 8),
                const Text("Symptom after vaccine",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                AppInputFormField(
                  controller: controller.symptomTextController,
                  hintText: 'Enter symptom',
                  onChanged: (String newValue) {
                    controller.selectedSymptom.value = newValue;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 30, 33, 212),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      if (controller.selectedDate.value == null) {
                        Get.snackbar('Error', 'Please select a date');
                        return;
                      }
                      if (controller.selectedClinic.value?.id == null) {
                        Get.snackbar('Error', 'Please select a clinic');
                        return;
                      }
                      if (controller.selectedClinic.value?.id == -1 &&
                          otherClinicNameController.text.isEmpty) {
                        Get.snackbar('Error', 'Please enter clinic name');
                        return;
                      }
                      await controller.updateVaccinationDate(
                        recordId,
                        vaccinationDate: controller.selectedDate.value!,
                        symptom: controller.selectedSymptom.value,
                        clinic: controller.selectedClinic.value,
                        otherClinicName:
                            controller.selectedClinic.value?.id == -1
                                ? otherClinicNameController.text
                                : null,
                        otherClinicTelephone:
                            controller.selectedClinic.value?.id == -1
                                ? otherClinicPhoneController.text
                                : null,
                        vaccineBrand: controller.selectedBrand.value,
                      );
                      Get.back(result: true);
                    },
                    child: const Text("Save",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _clinicSelection() {
    final VaccinatedDateController controller =
        Get.find<VaccinatedDateController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDropDownFormField<Clinic>(
            selectedValue: controller.selectedClinic.value,
            hintValue: 'Select clinic',
            items: controller.clinics,
            onItemSelected: (newValue) =>
                controller.selectedClinic.value = newValue),
        if (controller.selectedClinic.value?.id == -1)
          _otherClinicInformation(),
      ],
    );
  }

  Widget _brandSelection() {
    final VaccinatedDateController controller =
        Get.find<VaccinatedDateController>();
    return AppDropDownFormField<VaccineBrand>(
      selectedValue: controller.selectedBrand.value,
      hintValue: 'Select vaccine brand',
      items: controller.vaccineBrands,
      onItemSelected: (VaccineBrand? newValue) {
        setState(() {
          controller.selectedBrand.value = newValue;
        });
      },
    );
  }

  Widget _otherClinicInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text('Clinic name',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppInputFormField(
          controller: otherClinicNameController,
          hintText: 'Enter clinic name',
        ),
        const Text('Clinic phone number',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppInputFormField(
          controller: otherClinicPhoneController,
          hintText: 'Enter phone number',
        ),
      ],
    );
  }

  Widget _buildRoundedContainer(
      {required IconData icon, required String hintText, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                hintText,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }
}
