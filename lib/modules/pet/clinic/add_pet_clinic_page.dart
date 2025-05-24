import 'package:deemmi/core/domain/pet/clinic.dart';
import 'package:deemmi/core/domain/pet/pet_clinic.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/pet/clinic/add_pet_clinic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/global_widgets/pettagu_text_field.dart';
import '../../../core/global_widgets/primary_button.dart';
import '../../../core/theme/app_colors.dart';

class AddPetClinicPage extends StatefulWidget {
  const AddPetClinicPage({super.key});

  @override
  State<AddPetClinicPage> createState() => _AddPetClinicPageState();
}

class _AddPetClinicPageState extends State<AddPetClinicPage> {
  final _controller = Get.find<AddPetClinicController>();

  @override
  void initState() {
    //check ว่าเป็น Add หรือ Edit เชคโดยรับค้่าจากหน้าที่เรียกใช้ หน้านี้
    super.initState();

    // ✅ ดึงค่า arguments จาก Get.to()
    final PetClinic? clinic = Get.arguments?['clinic'];
    _controller.setEditingClinic(clinic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          _controller.editingClinic != null
              ? stringRes(context)!.editPetClinicLabel // ✅ ถ้าเป็น Edit
              : stringRes(context)!.addPetClinicLabel, // ✅ ถ้าเป็น Add
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clinic name (optional)',
                    style: textTheme(context).bodyMedium?.copyWith(
                        color: AppColor.textColor, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(
                    () => _dropDownFormField<Clinic>(
                      (value) {
                        if (value != null) {
                          _controller.onSelectedClinic(value);
                        }
                      },
                      _controller.clinics,
                      _controller.selectedClinic,
                      stringRes(context)!.selectLabel,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Obx(() => _otherClinicInformation()),
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
                              title: _controller.editingClinic != null
                                  ? stringRes(context)!
                                      .saveLabel // ✅ ถ้า Edit ให้เป็น Save
                                  : stringRes(context)!
                                      .nextLabel, // ✅ ถ้า Add ให้เป็น Next
                              onPressed: _controller.otherClinicNameErrorText ==
                                      null
                                  ? () async {
                                      if (_controller.checkInformation()) {
                                        await _controller.onCreatePetClinic();
                                        Get.back(result: true);
                                      }
                                    }
                                  : null,
                              color: AppColor.primary500,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (_controller.editingClinic ==
                      null) // ✅ ถ้าเป็น Add ให้แสดง Skip
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
    );
  }

  _otherClinicInformation() {
    if (_controller.selectedClinic?.id == -1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Clinic name',
            style: textTheme(context).bodyMedium?.copyWith(
                color: AppColor.textColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Obx(() => _otherClinicNameForm(context)),
          Text(
            'Clinic phone number',
            style: textTheme(context).bodyMedium?.copyWith(
                color: AppColor.textColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Obx(() => _otherClinicPhoneForm(context)),
          const SizedBox(
            height: 24,
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _otherClinicNameForm(BuildContext context) {
    return PettaguTextField(
      hintText: '',
      keyboardType: TextInputType.text,
      controller: _controller.otherClinicName,
      fillColor: Colors.white,
      errorText: _controller.otherClinicNameErrorText,
      maxLength: 20,
    );
  }

  _otherClinicPhoneForm(BuildContext context) {
    return PettaguTextField(
      hintText: '',
      keyboardType: TextInputType.phone,
      controller: _controller.otherClinicPhoneNumber,
      errorText: _controller.otherClinicPhoneErrorText,
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
