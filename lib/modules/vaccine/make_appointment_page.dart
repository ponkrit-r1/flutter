import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deemmi/routes/app_routes.dart';
import 'make_appointment_controller.dart';
import 'package:deemmi/common/widgets/app_dropdown_form_field.dart';
import 'package:deemmi/core/domain/pet/clinic.dart';
import 'package:deemmi/common/widgets/app_input_form_field.dart';

class MakeAppointmentPage extends StatefulWidget {
  const MakeAppointmentPage({super.key});

  @override
  MakeAppointmentPageState createState() => MakeAppointmentPageState();
}

class MakeAppointmentPageState extends State<MakeAppointmentPage> {
  final MakeAppointmentController controller =
      Get.find<MakeAppointmentController>();

  final TextEditingController otherClinicNameController =
      TextEditingController();
  final TextEditingController otherClinicPhoneController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    final recordId = Get.arguments?[RouteParams.recordId];
    if (recordId != null) {
      initializeAppointment(recordId);
    }
  }

  Future<void> initializeAppointment(int recordId) async {
    await controller.initializeAppointment(recordId);
    otherClinicNameController.text = controller.otherClinicName.value;
    otherClinicPhoneController.text = controller.otherClinicPhone.value;
  }

  @override
  Widget build(BuildContext context) {
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
              "Make appointment",
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

      final petModel = Get.arguments?[RouteParams.petModel];

      if (petModel == null) {
        return Scaffold(
          appBar: AppBar(title: const Text("Error")),
          body: const Center(child: Text("Pet data is missing!")),
        );
      }

      final doseTitle = Get.arguments?['doseTitle'] ?? 'Unknown Dose';
      final doseDescription = Get.arguments?['doseDesc'] ?? 'No Description';

      return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            title: const Text(
              "Make appointment",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doseTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doseDescription,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Appointed details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildRoundedContainer(
                        icon: Icons.calendar_today,
                        hintText: controller.selectedDate.value == null
                            ? 'Select date'
                            : '${controller.selectedDate.value!.day} ${_monthName(controller.selectedDate.value!.month)} ${controller.selectedDate.value!.year}',
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate:
                                controller.selectedDate.value ?? DateTime.now(),
                            firstDate: DateTime.now().subtract(
                                Duration(days: 5 * 365)), // 5 years ago
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            controller.selectedDate.value = picked;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildRoundedContainer(
                        icon: Icons.access_time,
                        hintText: controller.selectedTime.value == null
                            ? 'Select time'
                            : TimeOfDay(
                                    hour: controller.selectedTime.value!.hour,
                                    minute:
                                        controller.selectedTime.value!.minute)
                                .format(context),
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: controller.selectedTime.value != null
                                ? TimeOfDay(
                                    hour: controller.selectedTime.value!.hour,
                                    minute:
                                        controller.selectedTime.value!.minute,
                                  )
                                : TimeOfDay.now(),
                          );
                          if (picked != null) {
                            controller.selectedTime.value = DateTime(
                              controller.selectedDate.value?.year ??
                                  DateTime.now().year,
                              controller.selectedDate.value?.month ??
                                  DateTime.now().month,
                              controller.selectedDate.value?.day ??
                                  DateTime.now().day,
                              picked.hour,
                              picked.minute,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _clinicSelection(),
                const SizedBox(height: 16),
                const Text(
                  'Symptom before vaccine',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      if (controller.selectedDate.value == null) {
                        Get.snackbar('Error', 'Please select a date');
                        return;
                      }
                      final recordId = Get.arguments?[RouteParams.recordId];
                      if (recordId == null) {
                        Get.snackbar('Error', 'Vaccine record not found');
                        return;
                      }
                      await controller.updateAppointment(
                        recordId,
                        appointedDate: controller.getCombinedDateTime()!,
                        symptom: controller.selectedSymptom.value,
                        clinicId: controller.selectedClinic.value?.id == -1
                            ? null
                            : controller.selectedClinic.value?.id,
                        otherClinicName:
                            controller.selectedClinic.value?.id == -1
                                ? otherClinicNameController.text
                                : null,
                        otherClinicTelephone:
                            controller.selectedClinic.value?.id == -1
                                ? otherClinicPhoneController.text
                                : null,
                      );
                      Get.back(result: true);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }

  Widget _clinicSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        AppDropDownFormField<Clinic>(
          selectedValue: controller.selectedClinic.value,
          hintValue: 'Select clinic',
          items: controller.clinics,
          onItemSelected: (Clinic? newValue) {
            setState(() {
              controller.selectedClinic.value = newValue;
            });
          },
        ),
        if (controller.selectedClinic.value?.id == -1)
          _otherClinicInformation(),
      ],
    );
  }

  Widget _otherClinicInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Clinic name',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppInputFormField(
          controller: otherClinicNameController,
          hintText: 'Enter clinic name',
        ),
        const SizedBox(height: 12),
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
