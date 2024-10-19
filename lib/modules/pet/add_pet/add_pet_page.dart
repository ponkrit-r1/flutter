import 'package:deemmi/core/domain/auth/animal_breed.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/pet/add_pet/add_pet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/global_widgets/pettagu_text_field.dart';
import '../../../core/global_widgets/primary_button.dart';
import '../../../core/theme/app_colors.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  final _controller = Get.find<AddPetController>();

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
                ? stringRes(context)!.editPetLabel
                : stringRes(context)!.addPetInfoLabel,
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
                    Obx(
                      () => InkWell(
                        onTap: () async {
                          final result = await ImagePicker().pickImage(
                            imageQuality: 70,
                            maxWidth: 1440,
                            source: ImageSource.gallery,
                          );
                          if (result != null) {
                            _controller.setSelectedImage(result);
                          }
                        },
                        child: SizedBox(
                          height: 256,
                          child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: _controller.displaySelectedImage == null
                                ? Column(
                                    children: [
                                      const SizedBox(height: 48),
                                      const Icon(
                                        Icons.photo_library_outlined,
                                        color: AppColor.primary500,
                                        size: 56,
                                      ),
                                      const SizedBox(height: 24),
                                      Text.rich(
                                        TextSpan(
                                          text: stringRes(context)!
                                              .addYourPetPhoto,
                                          style: textTheme(context)
                                              .bodyLarge
                                              ?.copyWith(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          children: <TextSpan>[
                                            const TextSpan(text: ' '),
                                            TextSpan(
                                              text: stringRes(context)!
                                                  .browseLabel,
                                              style: textTheme(context)
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: AppColor.primary500,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        stringRes(context)!.maximumSizeLabel,
                                        style: textTheme(context)
                                            .bodyMedium
                                            ?.copyWith(
                                              color: AppColor.formTextColor,
                                            ),
                                      ),
                                      const SizedBox(height: 48),
                                    ],
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.memory(
                                      _controller.displaySelectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      stringRes(context)!.petTypeLabel,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => tabSelectorWidget(
                        _controller.animalTypes,
                        _controller.selectedPetType,
                        (value, idx) => _controller.setPetType(value, idx),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      stringRes(context)!.petNameLabel,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    _petNameForm(context),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Text(
                          stringRes(context)!.microchipIdLabel,
                          style: textTheme(context).bodyMedium?.copyWith(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "(${stringRes(context)!.optionalLabel})",
                          style: textTheme(context).bodySmall?.copyWith(
                              color: AppColor.secondaryContentGray,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    _microchipForm(context),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      stringRes(context)!.breedLabel,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => _dropDownFormField<AnimalBreed>(
                        (value) {
                          if (value != null) {
                            _controller.setSelectedBreed(value);
                          }
                        },
                        _controller.animalBreed,
                        _controller.selectedBreed,
                        stringRes(context)!.selectLabel,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      stringRes(context)!.genderLabel,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => tabSelectorWidget<String>(
                        [
                          stringRes(context)!.maleLabel,
                          stringRes(context)!.femaleLabel,
                          stringRes(context)!.dontKnowLabel,
                        ],
                        _controller.selectGender ?? '',
                        (value, idx) => _controller.setGender(value, idx),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      stringRes(context)!.dateOfBirthLabel,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () {
                          _showDatePicker();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: AppColor.borderColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100.0),
                              )),
                          child: SizedBox(
                            height: 54,
                            child: Center(
                              child: Row(
                                children: [
                                  const SizedBox(width: 16),
                                  Text(
                                    _controller.displayDate ??
                                        stringRes(context)!
                                            .selectDateOfBirthLabel,
                                    style: textTheme(context)
                                        .bodyLarge!
                                        .copyWith(
                                          color: AppColor.secondaryContentGray,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: AppColor.secondaryContentGray,
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => _controller.displayPetAge != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: stringRes(context)!.ageLabel,
                                  style:
                                      textTheme(context).bodyMedium?.copyWith(
                                            color: AppColor.textColor,
                                          ),
                                  children: <TextSpan>[
                                    const TextSpan(text: ': '),
                                    TextSpan(
                                      text:
                                          "${_controller.displayPetAge} ${stringRes(context)!.monthsLabel}",
                                      style: textTheme(context)
                                          .bodyMedium
                                          ?.copyWith(
                                            color: AppColor.secondary500,
                                          ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Text(
                          stringRes(context)!.weightLabel,
                          style: textTheme(context).bodyMedium?.copyWith(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "(${stringRes(context)!.optionalLabel})",
                          style: textTheme(context).bodySmall?.copyWith(
                              color: AppColor.secondaryContentGray,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    _weightForm(context),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Text(
                          stringRes(context)!.animalCareSystemLabel,
                          style: textTheme(context).bodyMedium?.copyWith(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "(${stringRes(context)!.optionalLabel})",
                          style: textTheme(context).bodySmall?.copyWith(
                              color: AppColor.secondaryContentGray,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => tabSelectorWidget(
                        [
                          stringRes(context)!.indoorLabel,
                          stringRes(context)!.outdoorLabel,
                        ],
                        _controller.selectedCareSystem ?? '',
                        (value, idx) => _controller.setCareSystem(value, idx),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Text(
                          stringRes(context)!.specialCharacteristicsLabel,
                          style: textTheme(context).bodyMedium?.copyWith(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "(${stringRes(context)!.optionalLabel})",
                          style: textTheme(context).bodySmall?.copyWith(
                              color: AppColor.secondaryContentGray,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    _characteristicForm(context),
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
                                title: _controller.editingPet != null
                                    ? stringRes(context)!.saveLabel
                                    : stringRes(context)!.nextLabel,
                                onPressed: _controller.isInformationCompleted
                                    ? () {
                                        _controller.onNextActionClick();
                                      }
                                    : null,
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
                          stringRes(context)!.maybeLaterLabel,
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

  _petNameForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.name,
      controller: _controller.petNameController,
      fillColor: Colors.white,
      maxLength: 30,
    );
  }

  _microchipForm(BuildContext context) {
    return PettaguTextField(
      hintText: '',
      keyboardType: TextInputType.text,
      controller: _controller.microChipController,
      fillColor: Colors.white,
      maxLength: 20,
    );
  }

  _weightForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.number,
      controller: _controller.weightForm,
      fillColor: Colors.white,
    );
  }

  _characteristicForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.text,
      controller: _controller.characteristicController,
      fillColor: Colors.white,
      maxLength: 150,
    );
  }

  _firstnameForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.visiblePassword,
      controller: _controller.firstNameController,
      fillColor: Colors.white,
    );
  }

  _lastnameForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.visiblePassword,
      controller: _controller.lastNameController,
      fillColor: Colors.white,
    );
  }

  _dropDownFormField<T>(
    Function(T?) onItemSelected,
    List<T> items,
    T? selectedValue,
    String hintValue,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: AppColor.borderColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: DropdownButtonFormField<T>(
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

  _showDatePicker() {
    Get.bottomSheet(Container(
      color: Colors.white,
      height: Get.height / 2.5,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  stringRes(context)!.doneLabel,
                  style: textTheme(context)!
                      .labelLarge
                      ?.copyWith(color: AppColor.primary500),
                )),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _controller.selectedDate ?? DateTime.now(),
              maximumDate: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                _controller.onDobSelected(newDateTime);
              },
            ),
          ),
        ],
      ),
    ));
  }
}
