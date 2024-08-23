import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/pet/add_pet/add_pet_controller.dart';
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

  static final dropDownChoice = ['item1', 'item2', 'item3', 'item4', 'item5'];

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _globalKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(stringRes(context)!.addPetInfoLabel),
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
                    InkWell(
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
                      child: Card(
                        child: _controller.selectedImage == null ? Column(
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
                                text: stringRes(context)!.addYourPetPhoto,
                                style: textTheme(context).bodyLarge?.copyWith(
                                      color: AppColor.textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                children: <TextSpan>[
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                    text: stringRes(context)!.browseLabel,
                                    style:
                                        textTheme(context).bodyLarge?.copyWith(
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
                              style: textTheme(context).bodyMedium?.copyWith(
                                    color: AppColor.formTextColor,
                                  ),
                            ),
                            const SizedBox(height: 48),
                          ],
                        ) : Image.memory(_controller.selectedImage!) ,
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
                        [
                          stringRes(context)!.dogLabel,
                          stringRes(context)!.catLabel,
                        ],
                        _controller.selectedPetType ?? '',
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
                    _dropDownFormField(
                      _controller.setSelectedBreed,
                      ['Breed1', 'Breed2'],
                      _controller.selectedBreed,
                      stringRes(context)!.selectLabel,
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
                      () => tabSelectorWidget(
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
                    Row(
                      children: [
                        Expanded(
                          child: _dropDownFormField(
                            _controller.setSelectedYear,
                            ['2024', '2023', '2022'],
                            _controller.selectedYear,
                            stringRes(context)!.selectMonthLabel,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _dropDownFormField(
                            _controller.setSelectedMonth,
                            ['Jan', 'Feb', 'March'],
                            _controller.selectedMonth,
                            stringRes(context)!.selectYearLabel,
                          ),
                        )
                      ],
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
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColor.secondary500),
                                ),
                              )
                            : PrimaryButton(
                                title: stringRes(context)!.nextLabel,
                                onPressed: _controller.isInformationCompleted
                                    ? () {}
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
    );
  }

  _microchipForm(BuildContext context) {
    return PettaguTextField(
      hintText: '',
      keyboardType: TextInputType.text,
      controller: _controller.microChipController,
      fillColor: Colors.white,
    );
  }

  _weightForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.number,
      obscureText: true,
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

  _dropDownFormField(
    Function(String?, int) onItemSelected,
    List<String> items,
    String selectedValue,
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
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(16.0)),
        items: dropDownChoice.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(value, style: textTheme(context).bodyMedium)),
          );
        }).toList(),
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColor.secondaryContentGray,
        ),
        hint: Align(
            alignment: Alignment.centerLeft,
            child: Text(hintValue,
                style: textTheme(context).bodyMedium!.copyWith(
                      color: AppColor.secondaryContentGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ))),
        onChanged: (value) {
          onItemSelected(
            value,
            value != null ? items.indexOf(value) : -1,
          );
        },
      ),
    );
  }

  showForgotPasswordDialog(BuildContext context) {}

  onDisplaySnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    _globalKey.currentState?.showSnackBar(snackBar);
  }

  tabSelectorWidget(
    List<String> values,
    String selectedValue,
    Function(
      String,
      int,
    ) onValueSelected,
  ) {
    switch (values.length) {
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
                          values[0],
                          style: textTheme(context).bodyLarge!.copyWith(
                                color: AppColor.secondaryContentGray,
                                fontWeight: FontWeight.bold,
                              ),
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
                          values[1],
                          style: textTheme(context).bodyLarge!.copyWith(
                                color: AppColor.secondaryContentGray,
                                fontWeight: FontWeight.bold,
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
                          values[0],
                          style: textTheme(context).bodyLarge!.copyWith(
                                color: AppColor.secondaryContentGray,
                                fontWeight: FontWeight.bold,
                              ),
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
                          values[1],
                          style: textTheme(context).bodyLarge!.copyWith(
                                color: AppColor.secondaryContentGray,
                                fontWeight: FontWeight.bold,
                              ),
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
                          values[2],
                          style: textTheme(context).bodyLarge!.copyWith(
                                color: AppColor.secondaryContentGray,
                                fontWeight: FontWeight.bold,
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
    }
  }
}
