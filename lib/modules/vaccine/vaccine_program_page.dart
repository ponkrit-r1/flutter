import 'package:deemmi/core/domain/pet/health/vaccine/pet_vaccine_record.dart';
import 'package:deemmi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import 'vaccine_program_controller.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_dose.dart';
import 'package:intl/intl.dart';

class VaccineProgramPage extends StatelessWidget {
  const VaccineProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VaccineProgramController>();
    final PetModel? petModel = Get.arguments?[RouteParams.petModel];
    if (petModel != null) {
      controller.setPetModel(petModel);
    }
    if (petModel == null) {
      return const Scaffold(
        body: Center(child: Text('Pet data is missing!')),
      );
    }

    // Add ScrollControllers for each TabBarView
    final ScrollController firstYearController = ScrollController();
    final ScrollController annualController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icons/vaccine.webp', width: 32, height: 32),
            const SizedBox(width: 8),
            const Text(
              'Vaccine program',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.vaccineTypes.isEmpty) {
          return const Center(child: Text('No vaccine program available'));
        }
        return Scrollbar(
          thumbVisibility: true,
          controller: firstYearController,
          child: SingleChildScrollView(
            controller: firstYearController,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (petModel.ageInWeeks > 16 &&
                          controller.hasCompletedRabiesOrDHPPiOrFVRCP)
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            _buildWarningMessage(),
                            const SizedBox(height: 16),
                          ],
                        ),
                  ...controller.vaccineTypes.map((type) => _buildTabVaccineCard(
                        petModel,
                        type.type,
                        type.name,
                        controller.getDescription(type.name),
                        controller.getFirstYearDoses(type),
                        controller.getAnnualDoses(type),
                        'assets/icons/vaccine.webp',
                        firstYearController: firstYearController,
                        annualController: annualController,
                      )),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildWarningMessage() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'สัตว์เลี้ยงอายุเกินกว่า 4 เดือน จำเป็นต้องได้รับวัคซีนรวมและพิษสุนัขบ้า อย่างละ 2 เข็ม',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabVaccineCard(
    PetModel petModel,
    String type,
    String title,
    String description,
    List<VaccineDose> doseList,
    List<VaccineDose> annualDoseList,
    String iconPath, {
    // Remove shared controllers
    ScrollController? firstYearController,
    ScrollController? annualController,
  }) {
    final RxBool isExpanded = false.obs;

    // Create controllers for each tab instance
    final ScrollController localFirstYearController = ScrollController();
    final ScrollController localAnnualController = ScrollController();

    return Obx(() => Card(
          color: const Color(0xFFF8FAFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 3,
          child: Column(
            children: [
              ListTile(
                leading: Image.asset(iconPath, width: 40, height: 40),
                title: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 6),
                    if (type == 'core')
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Required',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
                subtitle: Text(
                  description,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                trailing: IconButton(
                  icon: Icon(
                    isExpanded.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  onPressed: () => isExpanded.value = !isExpanded.value,
                ),
              ),
              if (isExpanded.value)
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        labelColor: Colors.black,
                        indicatorColor: Color(0xFF2563EB),
                        tabs: [
                          Tab(text: '1st year vaccine'),
                          Tab(text: 'Annually vaccine'),
                        ],
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 10,
                          maxHeight: 300, // You can adjust this
                        ),
                        child: TabBarView(
                          children: [
                            _buildDoseListView(doseList,
                                'No vaccine program available', petModel,
                                controller: localFirstYearController,
                                title: title),
                            _buildDoseListView(annualDoseList,
                                'No Annually program available', petModel,
                                controller: localAnnualController,
                                title: title),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ));
  }

  Widget _buildDoseListView(
      List<VaccineDose> doses, String emptyMessage, PetModel petModel,
      {ScrollController? controller, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: doses.isEmpty
            ? Center(
                child: Text(
                  emptyMessage,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              )
            : Scrollbar(
                thumbVisibility: true,
                controller: controller,
                child: ListView.builder(
                  controller: controller,
                  shrinkWrap: false,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: doses.length,
                  itemBuilder: (context, index) {
                    return _buildDoseItem(
                      doses[index],
                      petModel,
                      title,
                    );
                  },
                ),
              ),
      ),
    );
  }

  String ordinal(int number) {
    if (number >= 11 && number <= 13) {
      return '${number}th';
    }
    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  Widget _buildDoseItem(VaccineDose dose, PetModel petModel, String title) {
    final controller = Get.find<VaccineProgramController>();
    // Find the vaccine type (program) for this dose
    final vaccineType = controller.vaccineTypes.firstWhereOrNull(
      (type) => type.doses.any((d) => d.id == dose.id),
    );

    List<PetVaccineRecord> records = [];

    if (vaccineType != null) {
      records = controller.getRecordsForDose(vaccineType.id, dose.id);
    }

    return Column(
        children: records.map((record) {
      final bool isCompleted = record.status == 'Completed';
      final formattedDate =
          DateFormat('MMM, yyyy').format(record.suggestedDate);
      final suggestDateText = ' (Suggest date: $formattedDate)';

      final String doseTitle = dose.doseType.toLowerCase() == 'primary'
          ? '${ordinal(record.doseNumber)} dose'
          : '${record.doseNumber + 1} years old';

      return Container(
        padding: const EdgeInsets.all(7),
        margin: const EdgeInsets.symmetric(vertical: 1),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle,
                    color:
                        !isCompleted ? Colors.grey : const Color(0xFF14B8A6)),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: doseTitle, // Bold text
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        if (!isCompleted &&
                            record.suggestedDate.toLocal().isAfter(
                                DateTime.now()
                                    .toLocal()
                                    .subtract(Duration(days: 1))))
                          TextSpan(
                            text: suggestDateText, // Grey text
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        if (record.status == 'Completed' &&
                            record.vaccinationDate != null)
                          TextSpan(
                            text:
                                ' (${DateFormat('MMM, yyyy').format(record.vaccinationDate!)})', // Grey text
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF14B8A6)),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      final result = await Get.toNamed(Routes.make_appointment,
                          arguments: {
                            RouteParams.petModel: petModel,
                            RouteParams.recordId: record.id,
                            'doseTitle': '$title ($doseTitle)',
                            'dostDesc': controller.getDescription(title),
                          });
                      if (result == true) {
                        controller.fetchVaccineRecords(); // Refresh records
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Make appointment",
                          style: TextStyle(
                            color: AppColor.secondaryContentGray,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          record.appointedDate != null
                              ? DateFormat('dd MMM yyyy')
                                  .format(record.appointedDate!)
                              : 'Add',
                          style: const TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text("|", style: TextStyle(color: Colors.black38)),
                  TextButton(
                    onPressed: () async {
                      final result =
                          await Get.toNamed(Routes.vaccinated_date, arguments: {
                        RouteParams.petModel: petModel,
                        RouteParams.recordId: record.id,
                        RouteParams.vaccineTypeId: vaccineType?.id,
                        'doseTitle': '$title ($doseTitle)',
                        'dostDesc': controller.getDescription(title),
                        'vaccindationMaxDate':
                            controller.getVaccindateionMaxDate(record),
                      });
                      if (result == true) {
                        controller.fetchVaccineRecords(); // Refresh records
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Vaccination date",
                          style: TextStyle(
                            color: AppColor.secondaryContentGray,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          record.vaccinationDate != null
                              ? DateFormat('dd MMM yyyy')
                                  .format(record.vaccinationDate!)
                              : 'Add',
                          style: const TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList());
  }
}
