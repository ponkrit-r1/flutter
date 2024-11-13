import 'package:deemmi/core/domain/answer_choice.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_brand.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_type.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/pet/health_info/pet_health_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/global_widgets/pettagu_text_field.dart';
import '../../../core/global_widgets/primary_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

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
            stringRes(context)!.addPetHealthLabel,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8.0,
                ),
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
                          () =>
                          tabSelectorWidget(
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
                          () =>
                          tabSelectorWidget(
                            _controller.twoChoiceAnswer,
                            _controller.chronicDiseaseAnswer,
                                (value, idx) =>
                                _controller.setChronicDiseaseAnswer(value),
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(() => chronicDiseaseList()),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
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
                          () =>
                          tabSelectorWidget(
                            _controller.twoChoiceAnswer,
                            _controller.foodAllergyAnswer,
                                (value, idx) =>
                                _controller.setFoodAllergyAnswer(value),
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(() => foodAllergyList()),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
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
                          () =>
                          tabSelectorWidget(
                            _controller.threeChoiceAnswer,
                            _controller.vaccineAllergyAnswer,
                                (value, idx) =>
                                _controller.setVaccineAllergy(value),
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(
                          () => vaccineAllergyList(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
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
                          () =>
                          tabSelectorWidget(
                            _controller.threeChoiceAnswer,
                            _controller.drugAllergyAnswer,
                                (value, idx) =>
                                _controller.setDrugAllergy(value),
                          ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(() => drugAllergyList()),
                    const SizedBox(
                      height: 24,
                    ),
                    Obx(
                          () =>
                          SizedBox(
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
                              onPressed: () {
                                _navigateToAddClinic();
                              },
                              color: AppColor.primary500,
                            ),
                          ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          _navigateToAddClinic();
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

  tabSelectorWidget<T>(List<T> values,
      T? selectedValue,
      Function(
          T,
          int,
          ) onValueSelected,) {
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

  foodAllergyList() {
    if (_controller.foodAllergyAnswer?.option != AnswerOption.yes) {
      return const SizedBox.shrink();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return textFieldItem(
            index,
            'Food',
            _controller.foodAllergyList.elementAt(index),
            _controller.onDeleteFoodAllergy,
            _controller.foodAllergyList.length > 1 &&
                _controller.foodAllergyList.length - 1 == index,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12.0);
        },
        itemCount: _controller.foodAllergyList.length,
      ),
      if (_controller.foodAllergyList.length < 10)
        InkWell(
          onTap: () {
            _controller.onAddFoodAllergy();
          },
          child: Text(
            "Add more food",
            style: textTheme(context).bodyMedium?.copyWith(
                color: AppColor.primary500, fontWeight: FontWeight.w600),
          ),
        ),
    ]);
  }

  chronicDiseaseList() {
    if (_controller.chronicDiseaseAnswer?.option != AnswerOption.yes) {
      return const SizedBox.shrink();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (BuildContext context, int index) {
          return textFieldItem(
            index,
            'Disease',
            _controller.chronicDiseaseList.elementAt(index),
            _controller.onDeleteChronicDisease,
            _controller.chronicDiseaseList.length > 1 &&
                _controller.chronicDiseaseList.length - 1 == index,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12.0);
        },
        itemCount: _controller.chronicDiseaseList.length,
      ),
      if (_controller.chronicDiseaseList.isNotEmpty &&
          _controller.chronicDiseaseList.length < 10)
        InkWell(
          onTap: () {
            _controller.onAddChronicDisease();
          },
          child: Text(
            "Add more disease",
            style: textTheme(context).bodyMedium?.copyWith(
                color: AppColor.primary500, fontWeight: FontWeight.w600),
          ),
        )
    ]);
  }

  drugAllergyList() {
    if (_controller.drugAllergyAnswer?.option != AnswerOption.yes) {
      return const SizedBox.shrink();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return textFieldItem(
            index,
            'Drug',
            _controller.drugAllergyList.elementAt(index),
            _controller.onDeleteDrugAllergy,
            _controller.drugAllergyList.length > 1 &&
                _controller.drugAllergyList.length - 1 == index,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12.0);
        },
        itemCount: _controller.drugAllergyList.length,
      ),
      if (_controller.drugAllergyList.length < 10)
        InkWell(
          onTap: () {
            _controller.onAddDrugAllergy();
          },
          child: Text(
            "Add more drug",
            style: textTheme(context).bodyMedium?.copyWith(
                color: AppColor.primary500, fontWeight: FontWeight.w600),
          ),
        )
    ]);
  }

  vaccineAllergyList() {
    if (_controller.vaccineAllergyAnswer?.option != AnswerOption.yes) {
      return const SizedBox.shrink();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return vaccineItem(
              index,
              'Vaccine',
              _controller.onDeleteVaccineAllergy,
              _controller.vaccineAllergyList.length > 1 &&
                  _controller.vaccineAllergyList.length - 1 == index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12.0);
        },
        itemCount: _controller.vaccineAllergyList.length,
      ),
      if (_controller.vaccineAllergyList.length < 10)
        InkWell(
          onTap: () {
            _controller.onAddVaccineAllergy();
          },
          child: Text(
            "Add more vaccine",
            style: textTheme(context).bodyMedium?.copyWith(
                color: AppColor.primary500, fontWeight: FontWeight.w600),
          ),
        )
    ]);
  }

  vaccineItem(int idx,
      String label,
      Function(int) onDelete,
      bool showDelete,) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "#${idx + 1} $label",
                style: textTheme(context).bodyMedium?.copyWith(
                    color: AppColor.textColor, fontWeight: FontWeight.w600),
              ),
            ),
            if (showDelete)
              InkWell(
                child: const Icon(
                  Icons.delete_rounded,
                  color: AppColor.textColor,
                ),
                onTap: () {
                  onDelete(idx);
                },
              )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        _dropDownFormField<VaccineType>(
              (value) {
            if (value != null) {
              _controller.onSetVaccineAllergyType(idx, value);
            }
          },
          _controller.vaccineTypeOptions,
          _controller.vaccineAllergyList
              .elementAt(idx)
              ?.type,
          "Type",
        ),
        const SizedBox(height: 12),
        _dropDownFormField<VaccineBrand>(
              (value) {
            if (value != null) {
              _controller.onSetVaccineAllergyBrand(idx, value);
            }
          },
          _controller.vaccineBrandOptions,
          _controller.vaccineAllergyList
              .elementAt(idx)
              ?.brand,
          "Brand",
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  textFieldItem(int idx,
      String label,
      TextEditingController editTextController,
      Function(int) onDelete,
      bool showDelete,) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "$label #${idx + 1}",
                style: textTheme(context).bodyMedium?.copyWith(
                    color: AppColor.textColor, fontWeight: FontWeight.w600),
              ),
            ),
            if (showDelete)
              InkWell(
                child: const Icon(
                  Icons.delete_rounded,
                  color: AppColor.textColor,
                ),
                onTap: () {
                  onDelete(idx);
                },
              )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        PettaguTextField(
            hintText: "",
            keyboardType: TextInputType.text,
            controller: editTextController,
            fillColor: Colors.white,
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
            ]),
      ],
    );
  }

  _navigateToAddClinic() {
    Get.offNamed(Routes.addPetClinic, arguments: {
      RouteParams.petModel: _controller.editingPet,
    });
  }

  _dropDownFormField<T>(Function(T?) onItemSelected,
      List<T> items,
      T? selectedValue,
      String hintValue,) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: AppColor.borderColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: DropdownButtonFormField<T>(
        value: selectedValue,
        decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(16.0)),
        items: items.map((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(value.toString(),
                    style: textTheme(context).bodyMedium)),
          );
        }).toList(),
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColor.secondaryContentGray,
        ),
        hint: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            hintValue,
            style: textTheme(context).bodyMedium!.copyWith(
              color: AppColor.secondaryContentGray,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
        onChanged: (value) {
          onItemSelected(value);
        },
      ),
    );
  }
}
