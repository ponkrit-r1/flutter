import 'package:deemmi/core/global_widgets/horizontal_dashline_painter.dart';
import 'package:deemmi/core/global_widgets/vertical_dashline_painter.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/pet/profile/pet_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';

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
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8), // Border width
              decoration: const BoxDecoration(
                  color: AppColor.secondary500, shape: BoxShape.circle),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(48), // Image radius
                  child: Image.memory(
                    controller.petModel.imageData!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(controller.petName),
            const Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
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
                        child: Image.memory(
                          controller.petModel.imageData!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: AppColor.secondaryBgColor,
                          ),
                          child: const Icon(
                            Icons.male_rounded,
                            color: AppColor.primary500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            controller.petName,
                            style: textTheme(context).headlineLarge,
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.edit_rounded,
                            color: AppColor.primary500,
                          ),
                        ],
                      ),
                      Text(
                        controller.petModel.breed ?? '',
                        style: textTheme(context)
                            .bodyMedium!
                            .copyWith(color: AppColor.secondaryContentGray),
                      ),
                      Text(
                        '${stringRes(context)!.microchipIdLabel} ${controller.petModel.microchipNumber}',
                        style: textTheme(context)
                            .bodyMedium!
                            .copyWith(color: AppColor.secondaryContentGray),
                      ),
                      Text(
                        '${stringRes(context)!.specialCharacteristicsLabel} ${controller.petModel.characteristics}',
                        style: textTheme(context)
                            .bodyMedium!
                            .copyWith(color: AppColor.secondaryContentGray),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: petInfoItem(
                              const Icon(
                                Icons.cake_rounded,
                                color: AppColor.secondaryContentGray,
                              ),
                              'Age 3 Months',
                              context,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                            child: CustomPaint(
                                painter: VerticalDashedLinePainter()),
                          ),
                          Expanded(
                            child: petInfoItem(
                              const Icon(
                                Icons.monitor_weight_rounded,
                                color: AppColor.secondaryContentGray,
                              ),
                              'Weight 5 Kg',
                              context,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                            child: CustomPaint(
                                painter: VerticalDashedLinePainter()),
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
                      SizedBox(
                        height: 3,
                        child: CustomPaint(
                          painter: HorizontalDashedLinePainter(),
                        ),
                      ),
                      petInfoSection('Health information', context),
                      SizedBox(
                        height: 3,
                        child: CustomPaint(
                          painter: HorizontalDashedLinePainter(),
                        ),
                      ),
                      petInfoSection('Clinic information', context),
                      SizedBox(
                        height: 3,
                        child: CustomPaint(
                          painter: HorizontalDashedLinePainter(),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: petInfoItem(
                                Image.asset('assets/icons/vaccine.webp'),
                                'Vaccine',
                                context,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                            child: CustomPaint(
                                painter: VerticalDashedLinePainter()),
                          ),
                          Expanded(
                            child: Card(
                              child: petInfoItem(
                                Image.asset('assets/icons/medication.webp'),
                                'Flea & Tick',
                                context,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                            child: CustomPaint(
                                painter: VerticalDashedLinePainter()),
                          ),
                          Expanded(
                            child: Card(
                              child: petInfoItem(
                                Image.asset(
                                    'assets/icons/file-text-check.webp'),
                                'Insurance',
                                context,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: petInfoItem(
                                Image.asset(
                                    'assets/icons/sliders-horizontal-alt.webp'),
                                'Others',
                                context,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Image.asset('assets/image/empty_pet_info.webp'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  petInfoSection(String title, BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: textTheme(context).headlineMedium,
        ),
        const SizedBox(width: 8),
        const Icon(
          Icons.edit_rounded,
          color: AppColor.primary500,
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
        widget,
        Text(
          label,
          style: textTheme(context)
              .bodyMedium!
              .copyWith(color: AppColor.secondaryContentGray),
        ),
      ],
    );
  }
}
