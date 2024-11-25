import 'package:deemmi/core/global_widgets/horizontal_dashline_painter.dart';
import 'package:deemmi/core/global_widgets/vertical_dashline_painter.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/pet/profile/pet_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

class PetProfilePage extends StatelessWidget {
  PetProfilePage({super.key});

  final controller = Get.find<PetProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4), // Border width
              decoration: const BoxDecoration(
                  color: AppColor.secondary500, shape: BoxShape.circle),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(16), // Image radius
                  child: Image.network(
                    controller.petModel.image ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              controller.petName,
              style: textTheme(context)
                  .headlineSmall
                  ?.copyWith(color: AppColor.textColor),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),


actions: [
          IconButton(
            icon: const Icon(
              Icons.qr_code_rounded,
              color: AppColor.primary500,
            ),
            onPressed: () {
              // Navigate to the QR Code page
              try {
                //  Get.toNamed(Routes.add_pet_tag,
                //  arguments: {
                //   'petModel' : controller.petModel,
                //  });

                Get.toNamed(Routes.existing_pet_tag, arguments: {
                  'petModel': controller.petModel,
                });
                //Get.toNamed(Routes.existing_pet_tag);
              } catch (e) {
                print("Navigation error: $e");
              }
            },
          ),
        ],


      ),
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
                SizedBox(
                  height: 296,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          controller.petModel.image ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(8)),
                            color: AppColor.secondaryBgColor,
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: getGenderWidget(
                                  controller.petModel.gender ?? '')),
                        ),
                      ),
                    ],
                  ),
                ),
                petInformationSystem(context),
              ],
            ),
          ),
        ),
      ),
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

  petInformationSystem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(
                Routes.addPet,
                arguments: {
                  RouteParams.petModel: controller.petModel,
                },
              );
            },
            child: Row(
              children: [
                Text(
                  controller.petName,
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
          // Text(
          //   controller.petModel.breed ?? '',
          //   style: textTheme(context)
          //       .bodyMedium!
          //       .copyWith(color: AppColor.secondaryContentGray),
          // ),
          const SizedBox(height: 4),
          Text(
            '${stringRes(context)!.microchipIdLabel} ${controller.petModel.microchipNumber}',
            style: textTheme(context)
                .bodyMedium!
                .copyWith(color: AppColor.secondaryContentGray),
          ),
          const SizedBox(height: 4),
          Text(
            '${stringRes(context)!.specialCharacteristicsLabel} ${controller.petModel.characteristics}',
            style: textTheme(context)
                .bodyMedium!
                .copyWith(color: AppColor.secondaryContentGray),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 72,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: petInfoItem(
                    const Icon(
                      Icons.cake_rounded,
                      color: AppColor.secondaryContentGray,
                    ),
                    "${stringRes(context)!.ageLabel} ${controller.petModel.getAgeInMonth().toString()} ${stringRes(context)!.monthsLabel}",
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
                    '${stringRes(context)!.ageLabel} ${controller.petModel.weight ?? '-'} Kg',
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
                    'Animal Care Indoor',
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
            'Health information',
            context,
            () {
              navigateToAddHealthInfo();
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 3,
            width: double.infinity,
            child: CustomPaint(
              painter: HorizontalDashedLinePainter(),
            ),
          ),
          const SizedBox(height: 16),
          petInfoSection(
            'Clinic information',
            context,
            () {
              _navigateToAddClinic();
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 3,
            width: double.infinity,
            child: CustomPaint(
              painter: HorizontalDashedLinePainter(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
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
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
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
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
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
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
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
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 124,
            child: upcomingTitle(context),
          ),
          const SizedBox(height: 40),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset('assets/images/empty_pet_info.webp'),
            ),
          ),
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

  petInfoSection(
    String title,
    BuildContext context,
    VoidCallback onEditPress,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: textTheme(context).headlineMedium,
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
        const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColor.primary500,
        ),
      ],
    );
  }

  petInfoItem(
    Widget widget,
    String label,
    BuildContext context,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            label,
            style: textTheme(context)
                .bodyMedium!
                .copyWith(color: AppColor.secondaryContentGray),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  navigateToAddHealthInfo() {
    Get.toNamed(Routes.healthInfo, arguments: {
      RouteParams.petModel: controller.petModel,
    });
  }

  _navigateToAddClinic() {
    Get.toNamed(Routes.addPetClinic, arguments: {
      RouteParams.petModel: controller.petModel,
    });
  }
}
