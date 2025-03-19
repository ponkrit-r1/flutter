import 'package:deemmi/core/domain/pet/health/pet_health_info.dart';
import 'package:deemmi/core/domain/pet/pet_clinic.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:deemmi/core/global_widgets/horizontal_dashline_painter.dart';
import 'package:deemmi/core/global_widgets/vertical_dashline_painter.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/pet/list/pet_list_controller.dart';
import 'package:deemmi/modules/pet/profile/pet_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetProfilePage extends StatelessWidget {
  PetProfilePage({super.key});

  final controller = Get.find<PetProfileController>();

  bool isDirectionVisible = false;

  final PetListController _petController = Get.find<PetListController>();

  final List<Map<String, String>> mockUpcomingVaccines = [
  {
    "name": "Vaccine abc",
    "date": "23 July 2024",
    "daysRemaining": "30 Days",
    "location": "MJ animal health center",
  },
  {
    "name": "กำจัดเห็บหมัด",
    "date": "23 July 2024",
    "daysRemaining": "30 Days",
    "location": "MJ animal health center",
  },
];



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true, // กำหนดว่าให้สามารถปิดหน้านี้ได้หรือไม่
      onPopInvoked: (result) async {
        _petController.getMyPet();
      },
      child: Scaffold(
        backgroundColor: Colors.white,






appBar: PreferredSize(
  preferredSize: const Size.fromHeight(56),
  child: AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // รูปโปรไฟล์ของสัตว์เลี้ยง
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: AppColor.secondary500, 
            shape: BoxShape.circle
          ),
          child: ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(16),
              child: Image.network(
                controller.petModel.image ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // ✅ แสดงชื่อสัตว์เลี้ยง และให้สามารถกดได้
        InkWell(
          onTap: () async {
            _showPetSelectionPopup(context);
          },
          child: Row(
            children: [
              Obx(() => Text(
              controller.displayPetModel.name,
                
                style: textTheme(context).headlineSmall?.copyWith(
                  color: AppColor.textColor,
                ),
                overflow: TextOverflow.ellipsis,
              )),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColor.textColor,
              ),
            ],
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        icon: const Icon(
          Icons.qr_code_rounded,
          color: AppColor.primary500,
        ),
        onPressed: () {
          Get.toNamed(Routes.existing_pet_tag, arguments: {
            'petModel': controller.petModel,
          });
        },
      ),
    ],
  ),
),




  //       appBar: AppBar(
  //         backgroundColor: Colors.white,
  //         elevation: 0.0,
  //         centerTitle: true,

          
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.all(4), // Border width
  //               decoration: const BoxDecoration(
  //                   color: AppColor.secondary500, shape: BoxShape.circle),
  //               child: ClipOval(
  //                 child: SizedBox.fromSize(
  //                   size: const Size.fromRadius(16), // Image radius
  //                   child: Image.network(
  //                     controller.petModel.image ?? '',
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(width: 8),








  //             // Text(
  //             //   controller.petName,
  //             //   style: textTheme(context)
  //             //       .headlineSmall
  //             //       ?.copyWith(color: AppColor.textColor),
  //             // ),
  //             // const SizedBox(width: 8),
  //             // const Icon(Icons.keyboard_arrow_down_rounded),

  // // ✅ เพิ่ม Dropdown ที่ Obx เพื่อตรวจสอบค่าแบบ Reactive mar
  //  // ✅ ใช้ Flexible เพื่อให้ Dropdown ไม่ขยายเกินขนาด Row
  //   Flexible(
  //     child: Obx(() {
  //       if (_petController.petList.isEmpty) {
  //         return const SizedBox();
  //       }
  //       return DropdownButtonHideUnderline( // ✅ เอาเส้นใต้ dropdown ออก
  //         child: DropdownButton<PetModel>(
  //           value: _petController.selectedPet.value,
  //           icon: const Icon(Icons.keyboard_arrow_down_rounded),
  //           isExpanded: true, // ✅ ทำให้ dropdown ขยายได้เต็มที่ในพื้นที่จำกัด
  //           items: _petController.petList.map<DropdownMenuItem<PetModel>>((pet) {
  //             return DropdownMenuItem<PetModel>(
  //               value: pet,
  //               child: Text(
  //                 pet.name,
  //                 overflow: TextOverflow.ellipsis, // ✅ ป้องกัน text overflow
  //                 style: textTheme(context)
  //                     .headlineSmall
  //                     ?.copyWith(color: AppColor.textColor),
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: (PetModel? newValue) {
  //             if (newValue != null) {
  //               _petController.updateSelectedPet(newValue);
  //               controller.setDisplaySetModel(newValue);
  //             }
  //           },
  //         ),
  //       );
  //     }),
  //   ),











  //           ],
  //         ),
  //         actions: [
  //           IconButton(
  //             icon: const Icon(
  //               Icons.qr_code_rounded,
  //               color: AppColor.primary500,
  //             ),
  //             onPressed: () {
  //               // Navigate to the QR Code page
  //               try {
  //                 //  Get.toNamed(Routes.add_pet_tag,
  //                 //  arguments: {
  //                 //   'petModel' : controller.petModel,
  //                 //  });

  //                 Get.toNamed(Routes.existing_pet_tag, arguments: {
  //                   'petModel': controller.petModel,
  //                 });
  //                 //Get.toNamed(Routes.existing_pet_tag);
  //               } catch (e) {
  //                 debugPrint("Navigation error: $e");
  //               }
  //             },
  //           ),
  //         ],
  //       ),












        body: SafeArea(
          child: Container(
            color: AppColor.secondaryBgColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Obx(
                    () => SizedBox(
                      height: 296,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              controller.displayPetModel.image ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 0.0,
                            bottom: 0.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8)),
                                color: AppColor.secondaryBgColor,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: getGenderWidget(
                                    controller.displayPetModel.gender ?? '',
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => petInformationSystem(
                      controller.displayPetModel,
                      context,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


void _showPetSelectionPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: true, // ✅ เปิดให้ modal scroll ได้
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.6, // ✅ จำกัดความสูงของ popup ไม่เกิน 60% ของหน้าจอ
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header ของ Popup
              Text(
               AppLocalizations.of(context)!.choose_pet,
                style: textTheme(context).headlineSmall,
              ),
              const SizedBox(height: 16),

              // ✅ ครอบด้วย Expanded หรือ Flexible เพื่อป้องกัน overflow
              Expanded(
                child: Obx(() {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: _petController.petList.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final pet = _petController.petList[index];
                      return ListTile(
                        onTap: () {
                          _petController.updateSelectedPet(pet);
                          controller.setDisplaySetModel(pet);
                          Navigator.pop(context); // ปิด Popup
                        },
                        title: Text(
                          pet.name,
                          style: textTheme(context).bodyMedium,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(pet.image ?? ''),
                        ),
                        trailing: _petController.selectedPet.value == pet
                            ? const Icon(
                                Icons.check_circle,
                                color: AppColor.primary500,
                              )
                            : null,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      );
    },
  );
}



  getGenderWidget(String gender) {
    switch (gender) {
      case 'Male':
        return const Icon(
          Icons.male_rounded,
          color: AppColor.primary500,
        );
      case 'Female':
        return const Icon(
          Icons.female_rounded,
          color: AppColor.secondary500,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('ยืนยันการออก'),
            content: Text('คุณต้องการออกจากหน้านี้หรือไม่?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('ยกเลิก'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('ตกลง'),
              ),
            ],
          ),
        ) ??
        false;
  }

  petInformationSystem(
    PetModel petModel,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              navigateToEditPetProfile();
            },
            child: Row(
              children: [
                Text(
                  petModel.name ,
                  style: textTheme(context).headlineLarge?.copyWith(
                        fontSize: 30,
                        color: AppColor.textColor,
                      ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.edit_rounded,
                  color: AppColor.primary500,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            petModel.displayBreed ?? '',
            style: textTheme(context)
                .bodyMedium!
                .copyWith(color: AppColor.secondaryContentGray,fontSize: 14,),
          ),
          const SizedBox(height: 4),
          Text(
            '${stringRes(context)!.microchipIdLabel}: ${petModel.microchipNumber ?? ''}',
            style: textTheme(context)
                .bodyMedium!
                .copyWith(color: AppColor.secondaryContentGray,fontSize: 14,),
          ),
          const SizedBox(height: 4),
          Text(
            '${stringRes(context)!.specialCharacteristicsLabel}: ${petModel.characteristics ?? ''}',
            style: textTheme(context)
                .bodyMedium!
                .copyWith(color: AppColor.secondaryContentGray,fontSize: 14,),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 96,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: petInfoItem(
                    const Icon(
                      Icons.cake_rounded,
                      color: AppColor.secondaryContentGray,
                    ),
                    "${stringRes(context)!.ageLabel}\n${petModel.getAgeInMonth().toString()} ${stringRes(context)!.monthsLabel}",
                    context,
                  ),
                ),
                SizedBox(
                  width: 3,
                  child: CustomPaint(painter: VerticalDashedLinePainter()),
                ),
                Expanded(
                  child: petInfoItem(
                    const Icon(
                      Icons.monitor_weight_rounded,
                      color: AppColor.secondaryContentGray,
                    ),
                    '${stringRes(context)!.weightLabel}\n${petModel.weight ?? '-'} Kg',
                    context,
                  ),
                ),
                SizedBox(
                  width: 3,
                  child: CustomPaint(painter: VerticalDashedLinePainter()),
                ),
                Expanded(
                  child: petInfoItem(
                    const Icon(
                      Icons.house_rounded,
                      color: AppColor.secondaryContentGray,
                    ),
                    stringRes(context)!.animalcareindoor ,
                    context,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3,
            width: double.infinity,
            child: CustomPaint(
              painter: HorizontalDashedLinePainter(),
            ),
          ),
          const SizedBox(height: 16),
          petInfoSection(
            stringRes(context)!.healthinfo,
            context,
            () {
              navigateToAddHealthInfo();
            },
            controller.expandHealthInfoSection,
            controller.onToggleHealthInfoSection,
          ),
          if (controller.healthInfo != null &&
              controller.expandHealthInfoSection)
            medicalInfoWidget(
              context,
              controller.healthInfo!,
            ),
          SizedBox(
            height: 3,
            width: double.infinity,
            child: CustomPaint(
              painter: HorizontalDashedLinePainter(),
            ),
          ),
          const SizedBox(height: 16),
          petInfoSection(
            stringRes(context)!.clinicinfo,
            context,
            () {
              _navigateToAddClinic(context);
            },
            controller.expandClinicSection,
            controller.onToggleClinicSection,
          ),
          if (controller.petClinics.isNotEmpty &&
              controller.expandClinicSection)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 156,
                  child: petHospitalCard(
                      context, controller.petClinics.elementAtOrNull(index)!),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 12.0);
              },
              itemCount: controller.petClinics.length,
            ),
          SizedBox(
            height: 3,
            width: double.infinity,
            child: CustomPaint(
              painter: HorizontalDashedLinePainter(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [

Expanded(
  child: InkWell(
    onTap: () {
      Get.toNamed(Routes.vaccine_program, arguments: {
        RouteParams.petModel: controller.petModel,
      });
    },
    child: SizedBox( // ✅ ใช้ SizedBox กำหนดขนาดเท่ากัน
      width: double.infinity,
      height: 100, // ✅ ตั้งค่าความสูงเท่ากัน
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3,
        color: AppColor.secondaryBgColor,
        child: petInfoItem(
          Image.asset('assets/icons/vaccine.webp'),
          'Vaccine',
          context,
          fontSize: 11,
        ),
      ),
    ),
  ),
),

const SizedBox(width: 4),

Expanded(
  child: InkWell(
    onTap: () {
      Get.toNamed(Routes.parasite_control, arguments: {
        RouteParams.petModel: controller.petModel,
      });
    },
    child: SizedBox( // ✅ ใช้ SizedBox ควบคุมขนาด
      width: double.infinity,
      height: 100, // ✅ ตั้งค่าความสูงให้เท่ากัน
      child: Card(
        color: AppColor.secondaryBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3,
        child: petInfoItem(
          Image.asset('assets/icons/medication.webp'),
          'Flea & Tick',
          context,
           fontSize: 11
        ),
      ),
    ),
  ),
),

const SizedBox(width: 4),

Expanded(
  child: SizedBox( // ✅ กำหนดขนาดปุ่มให้คงที่
    width: double.infinity,
    height: 100, // ✅ ความสูงเท่ากันทุกปุ่ม
    child: Card(
      color: AppColor.secondaryBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      child: petInfoItem(
        Image.asset('assets/icons/file-text-check.webp'),
        'Insurance',
        context,
         fontSize: 11,
      ),
    ),
  ),
),

const SizedBox(width: 4),

Expanded(
  child: SizedBox( // ✅ กำหนดขนาดปุ่มให้คงที่
    width: double.infinity,
    height: 100, // ✅ ความสูงเท่ากันทุกปุ่ม
    child: Card(
      color: AppColor.secondaryBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      child: petInfoItem(
        Image.asset('assets/icons/sliders-horizontal-alt.webp'),
        'Others',
        context,
         fontSize: 11,
      ),
    ),
  ),
),


//        Expanded(
//   child: InkWell(
//     onTap: () {
//       Get.toNamed(Routes.vaccine_program, arguments: {
//         RouteParams.petModel: controller.petModel,
//       });
//     },
//     child: Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       elevation: 3,
//       color: AppColor.secondaryBgColor,
//       child: petInfoItem(
//         Image.asset('assets/icons/vaccine.webp'),
//         'Vaccine',
//         context,
//       ),
//     ),
//   ),
// ),

//               const SizedBox(width: 8),

               
//               Expanded(
//                   child: InkWell(
//     onTap: () {
//       Get.toNamed(Routes.parasite_control, arguments: {
//         RouteParams.petModel: controller.petModel,
//       });
//     },
//                 child: Card(
//                   color: AppColor.secondaryBgColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   elevation: 3,
//                   child: petInfoItem(
//                     Image.asset('assets/icons/medication.webp'),
//                     'Flea & Tick',
//                     context,
//                   ),
//                 ),//endcard
//                   ),
//               ),





//               const SizedBox(width: 8),
//               Expanded(
//                 child: Card(
//                   color: AppColor.secondaryBgColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   elevation: 3,
//                   child: petInfoItem(
//                     Image.asset('assets/icons/file-text-check.webp'),
//                     'Insurance',
//                     context,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Card(
//                   color: AppColor.secondaryBgColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   elevation: 3,
//                   child: petInfoItem(
//                     Image.asset('assets/icons/sliders-horizontal-alt.webp'),
//                     'Others',
//                     context,
//                   ),
//                 ),
//               ),







            ],
          ),










          const SizedBox(height: 16),
          SizedBox(
            width: 124,
            child: upcomingTitle(context),
          ),
          const SizedBox(height: 16),
_buildUpcomingVaccineList(), // ✅ แสดง Mock Data
const SizedBox(height: 40),
          // const SizedBox(height: 40),
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.all(24.0),
          //     child: Image.asset('assets/images/empty_pet_info.webp'),
          //   ),
          // ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  upcomingTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          const Icon(
            Icons.calendar_month_rounded,
            color: AppColor.primary500,
          ),
          const SizedBox(width: 4),
          Text(
            'Upcoming',
            style: textTheme(context).headlineMedium?.copyWith(
                  color: AppColor.primary500,
                ),
          )
        ]),
        const SizedBox(height: 8),
        Container(
          height: 2,
          color: AppColor.primary500,
        )
      ],
    );
  }

  Widget _buildUpcomingVaccineList() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: mockUpcomingVaccines.map((vaccine) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: _buildUpcomingVaccineCard(
          vaccine["name"]!,
          vaccine["date"]!,
          vaccine["daysRemaining"]!,
          vaccine["location"]!,
        ),
      );
    }).toList(),
  );
}

Widget _buildUpcomingVaccineCard(
    String name, String date, String daysRemaining, String location) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0), // ✅ ทำให้มุมโค้ง
    ),
    elevation: 3,
    color: Colors.white,
    child: Stack(
      children: [
        // ✅ ขอบสีเขียวซ้ายโค้งตาม Card
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),  // ✅ มุมโค้งบนซ้าย
              bottomLeft: Radius.circular(12), // ✅ มุมโค้งล่างซ้าย
            ),
            child: Container(
              width: 6, // ✅ เพิ่มความกว้างให้ชัดขึ้น
               color: Color(0xFF63F2BE), // ✅ สีขอบซ้าย
            ),
          ),
        ),

        // ✅ เนื้อหาหลักของ Card
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // ✅ Status "Appointed"
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF2DD4BF), width: 2),
                    ),
                    child: const Text(
                      "Appointed",
                      style: TextStyle(
                        color: Color(0xFF2DD4BF),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$date ($daysRemaining)",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "at $location",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement change appointment action
                      },
                      child: const Text(
                        "Change",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
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
}

  petInfoSection(
    String title,
    BuildContext context,
    VoidCallback onEditPress,
    bool isExpanded,
    VoidCallback onExpand,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: textTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: onEditPress,
          child: const Icon(
            Icons.edit_rounded,
            color: AppColor.primary500,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            onExpand();
          },
          icon: isExpanded
              ? const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: AppColor.primary500,
                )
              : const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColor.primary500,
                ),
        ),
      ],
    );
  }

  petInfoItem(
    Widget widget,
    String label,
    BuildContext context,
    {double fontSize = 14}
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        widget,
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            label,
            style: textTheme(context)
                
                .bodyMedium!
                   .copyWith(
                fontSize: fontSize, // ✅ เพิ่มขนาดตัวอักษร
                color: AppColor.secondaryContentGray,
              ),
            textAlign: TextAlign.center,
            
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  navigateToAddHealthInfo() async {
    var result = await Get.toNamed(
      Routes.healthInfo,
      arguments: {
        RouteParams.petModel: controller.petModel,
        RouteParams.healthInfoModel: controller.healthInfo,
      },
    );
    if (result != null) {
      controller.getHealthInfoData();
    }
  }

  _navigateToAddClinic(BuildContext context) async {
    //ด้านล่างของ เดิมที่ comment ใช้ได้ปกติ
    // var result = await Get.toNamed(Routes.addPetClinic, arguments: {
    //   RouteParams.petModel: controller.petModel,

    // });
    // if (result != null) {
    //   controller.getClinicInformation();
    // }
    var result = await Get.toNamed(Routes.addPetClinic, arguments: {
      RouteParams.petModel: controller.petModel,
        'clinic': PetClinic( //เพิ่มใหม่ 18 mar จำลองการ Edit
    id: 1,
    otherClinicName: '',//AppLocalizations.of(context)!.placeholderclinicname,
    otherClinicTelephone: '',// AppLocalizations.of(context)!.placeholderphone,
    clinicId: 101,
    petId: 1,
  ),
      
    });
    if (result != null) {
      controller.getClinicInformation();
    }
  }

  Widget medicalInfoWidget(
    BuildContext context,
    PetHealthInfo info,
  ) {
    return Card(
      color: AppColor.secondaryBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              icon: Icons.pets,
              title: "Sterilization",
              details: [
                info.sterilization == null
                    ? '-'
                    : info.sterilization!
                        ? 'Yes'
                        : 'No',
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 3,
                width: double.infinity,
                child: CustomPaint(
                  painter: HorizontalDashedLinePainter(),
                ),
              ),
            ),
            _buildSection(
              context,
              icon: Icons.coronavirus,
              title: "Chronic disease",
              details: info.chronicDisease.isEmpty
                  ? ['-']
                  : info.chronicDisease.map((e) => e.name).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 3,
                width: double.infinity,
                child: CustomPaint(
                  painter: HorizontalDashedLinePainter(),
                ),
              ),
            ),
            _buildSection(
              context,
              icon: Icons.restaurant,
              title: "Food allergy",
              details: info.foodAllergy.isEmpty
                  ? ['-']
                  : info.foodAllergy.map((e) => e.name).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 3,
                width: double.infinity,
                child: CustomPaint(
                  painter: HorizontalDashedLinePainter(),
                ),
              ),
            ),
            _buildSection(
              context,
              icon: Icons.vaccines,
              title: "Vaccine Allergy",
              details: info.vaccineAllergy.isEmpty
                  ? ['-']
                  : info.vaccineAllergy
                      .map((e) => e.vaccineType != null
                          ? "${e.vaccineType ?? ''}: ${e.vaccineBrand ?? ''}"
                          : "${e.otherVaccineType ?? ''}: ${e.otherVaccineBrand ?? ''}")
                      .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 3,
                width: double.infinity,
                child: CustomPaint(
                  painter: HorizontalDashedLinePainter(),
                ),
              ),
            ),
            _buildSection(
              context,
              icon: Icons.medical_services,
              title: "Drug allergy",
              details: info.drugAllergy.isEmpty
                  ? ['-']
                  : info.drugAllergy
                      .map(
                        (e) => e.name,
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<String> details,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 24,
          color: AppColor.secondaryContentGray,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme(context).bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondaryContentGray,
                    ),
              ),
              const SizedBox(height: 4),
              ...details.map(
                (detail) => Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '• $detail',
                    style: textTheme(context).bodyMedium!.copyWith(
                          color: AppColor.secondaryContentGray,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget petHospitalCard(
    BuildContext context,
    PetClinic clinic,
  ) {
    return SizedBox(
      height: 120,
      child: Card(
        margin: EdgeInsets.zero,
        color: AppColor.secondaryBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hospital Name
              Text(
                clinic.otherClinicName?.isNotEmpty == true
                    ? clinic.otherClinicName!
                    : clinic.petClinic?.name ?? '',
                style: textTheme(context).bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
              ),
              const SizedBox(height: 8),
              // Address
              Text(
                '',
                style: textTheme(context).bodyLarge!.copyWith(
                      color: AppColor.secondaryContentGray,
                    ),
              ),
              const SizedBox(height: 16),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                 Visibility (
                  visible: isDirectionVisible, //ซ่อนปุ่ม
                  // Get Direction Button
                  child: TextButton.icon(
                    onPressed: () {
                      // Add Get Direction action here
                    },
                    icon: Icon(
                      Icons.directions,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    label: Text(
                      "Get Direction",
                      style: textTheme(context).bodyLarge?.copyWith(
                            color: AppColor.primary500,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                 ),


                  if (clinic.otherClinicTelephone?.isNotEmpty == true)
                    TextButton.icon(
                      onPressed: () {
                        // Add call action here
                      },
                      icon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      label: Text(
                        clinic.otherClinicTelephone?.isNotEmpty == true
                            ? clinic.otherClinicTelephone!
                            : clinic.petClinic?.telephone ?? '',
                        style: textTheme(context).bodyLarge?.copyWith(
                              color: AppColor.primary500,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 12.0,
                        ),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  navigateToEditPetProfile() async {
    var editedPet = await Get.toNamed(
      Routes.addPet,
      arguments: {
        RouteParams.petModel: controller.displayPetModel,
      },
    );
    if (editedPet != null) {
      controller.setDisplaySetModel(editedPet);
    }
  }
}
