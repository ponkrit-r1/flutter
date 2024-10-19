import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/pet/health_info/pet_health_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/global_widgets/primary_button.dart';
import '../../../core/theme/app_colors.dart';

class PetHealthInfoPage extends StatefulWidget {
  const PetHealthInfoPage({super.key});

  @override
  State<PetHealthInfoPage> createState() => _PetHealthInfoPageState();
}

class _PetHealthInfoPageState extends State<PetHealthInfoPage> {
  final _controller = Get.find<PetHealthInfoController>();

  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _globalKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            _controller.editingPet != null
                ? stringRes(context)!.editPetHealthLabel
                : stringRes(context)!.addPetHealthLabel,
            style: textTheme(context).headlineSmall!.copyWith(
                  color: AppColor.textColor,
                ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: AppColor.secondaryBgColor,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      stringRes(context)!.sterilizationLabel,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => tabSelectorWidget(
                        _controller.threeChoiceAnswer,
                        _controller.sterilizationAnswer,
                        (value, idx) =>
                            _controller.setSterilizationAnswer(value),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      stringRes(context)!.chronicDiseaseLabel,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => tabSelectorWidget(
                        _controller.twoChoiceAnswer,
                        _controller.chronicDiseaseAnswer,
                        (value, idx) =>
                            _controller.setChronicDiseaseAnswer(value),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      stringRes(context)!.foodAllergyLabel,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => tabSelectorWidget(
                        _controller.twoChoiceAnswer,
                        _controller.foodAllergyAnswer,
                        (value, idx) => _controller.setFoodAllergyAnswer(value),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      stringRes(context)!.vaccineAllergyLabel,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => tabSelectorWidget(
                        _controller.threeChoiceAnswer,
                        _controller.vaccineAllergyAnswer,
                        (value, idx) => _controller.setVaccineAllergy(value),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      stringRes(context)!.drugAllergyLabel,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => tabSelectorWidget(
                        _controller.threeChoiceAnswer,
                        _controller.drugAllergyAnswer,
                        (value, idx) => _controller.setDrugAllergy(value),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Obx(
                      () => SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: _controller.isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColor.secondary500),
                                  ),
                                ),
                              )
                            : PrimaryButton(
                                title: stringRes(context)!.nextLabel,
                                onPressed: () {},
                                color: AppColor.primary500,
                              ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          stringRes(context)!.skipLabel,
                          style: textTheme(context).bodyLarge?.copyWith(
                                color: AppColor.primary500,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showForgotPasswordDialog(BuildContext context) {}

  onDisplaySnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    _globalKey.currentState?.showSnackBar(snackBar);
  }

  tabSelectorWidget<T>(
    List<T> values,
    T? selectedValue,
    Function(
      T,
      int,
    ) onValueSelected,
  ) {
    switch (values.length) {
      case 1:
        return InkWell(
          onTap: () {
            onValueSelected(values[0], 0);
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: selectedValue == values[0] ? 2 : 1,
                  color: selectedValue == values[0]
                      ? AppColor.primary500
                      : AppColor.borderColor,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(100.0),
                )),
            child: SizedBox(
              height: 54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    values[0].toString(),
                    style: textTheme(context).bodyLarge!.copyWith(
                        color: AppColor.secondaryContentGray,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        );
      case 2:
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  onValueSelected(values[0], 0);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: selectedValue == values[0] ? 2 : 1,
                        color: selectedValue == values[0]
                            ? AppColor.primary500
                            : AppColor.borderColor,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                        bottomLeft: Radius.circular(100.0),
                      )),
                  child: SizedBox(
                    height: 54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Icon(
                        //   Icons.pets_rounded,
                        //   color: AppColor.secondaryContentGray,
                        // ),
                        // const SizedBox(width: 8),
                        Text(
                          values[0].toString(),
                          style: textTheme(context).bodyLarge!.copyWith(
                              color: AppColor.secondaryContentGray,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  onValueSelected(values[1], 1);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: selectedValue == values[1] ? 2 : 1,
                        color: selectedValue == values[1]
                            ? AppColor.primary500
                            : AppColor.borderColor,
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(100.0),
                        bottomRight: Radius.circular(100.0),
                      )),
                  child: SizedBox(
                    height: 54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Icon(Icons.pets_rounded),
                        // const SizedBox(width: 8),
                        Text(
                          values[1].toString(),
                          style: textTheme(context).bodyLarge!.copyWith(
                              color: AppColor.secondaryContentGray,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      case 3:
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  onValueSelected(values[0], 0);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: selectedValue == values[0] ? 2 : 1,
                        color: selectedValue == values[0]
                            ? AppColor.primary500
                            : AppColor.borderColor,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                        bottomLeft: Radius.circular(100.0),
                      )),
                  child: SizedBox(
                    height: 54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const Icon(
                        //   Icons.pets_rounded,
                        //   color: AppColor.secondaryContentGray,
                        // ),
                        // const SizedBox(width: 8),
                        Text(
                          values[0].toString(),
                          style: textTheme(context).bodyLarge!.copyWith(
                              color: AppColor.secondaryContentGray,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  onValueSelected(values[1], 1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: selectedValue == values[1] ? 2 : 1,
                      color: selectedValue == values[1]
                          ? AppColor.primary500
                          : AppColor.borderColor,
                    ),
                  ),
                  child: SizedBox(
                    height: 54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          values[1].toString(),
                          style: textTheme(context).bodyLarge!.copyWith(
                              color: AppColor.secondaryContentGray,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  onValueSelected(values[2], 2);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: selectedValue == values[2] ? 2 : 1,
                        color: selectedValue == values[2]
                            ? AppColor.primary500
                            : AppColor.borderColor,
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(100.0),
                        bottomRight: Radius.circular(100.0),
                      )),
                  child: SizedBox(
                    height: 54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          values[2].toString(),
                          style: textTheme(context).bodyLarge!.copyWith(
                                color: AppColor.secondaryContentGray,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
