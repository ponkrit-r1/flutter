import 'package:deemmi/core/domain/pet/clinic.dart';
import 'package:deemmi/core/domain/pet/pet_clinic.dart';
import 'package:deemmi/core/utils/validator/format_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/data/repository/pet_repository.dart';
import '../../../core/domain/pet/pet_model.dart';

class AddPetClinicController extends GetxController {
  final PetRepository petRepository;

  final PetModel editingPet;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final Rxn<Clinic> _selectedClinic = Rxn();

  Clinic? get selectedClinic => _selectedClinic.value;

  final RxList<Clinic> _clinics = RxList.empty();

  List<Clinic> get clinics => _clinics;

  AddPetClinicController(this.petRepository, this.editingPet);

  var otherClinicName = TextEditingController();

  final RxnString _otherClinicNameErrorText = RxnString();

  String? get otherClinicNameErrorText => _otherClinicNameErrorText.value;

  final RxnString _otherClinicPhoneErrorText = RxnString();

  String? get otherClinicPhoneErrorText => _otherClinicPhoneErrorText.value;

  var otherClinicPhoneNumber = TextEditingController();

  final Rxn<PetClinic> _editingClinic = Rxn(); //เพิ่มเพิ่อเชค Add/Edit

  PetClinic? get editingClinic => _editingClinic.value; //เพิ่มเพิ่อเชค Add/Edit

  void setEditingClinic(PetClinic? clinic) {
    //เพิ่มเพิ่อเชค Add/Edit
    _editingClinic.value = clinic;
    if (clinic != null) {
      otherClinicName.text = clinic.otherClinicName ?? '';
      otherClinicPhoneNumber.text = clinic.otherClinicTelephone ?? '';
      _selectedClinic.value = clinics.firstWhereOrNull(
        (c) => c.id == clinic.clinicId,
      );
    }
  }

  @override
  onReady() {
    getPetClinic();
    super.onReady();
    otherClinicName.addListener(() {
      if (otherClinicNameErrorText?.isNotEmpty == true) {
        if (otherClinicName.text.isNotEmpty) {
          _otherClinicNameErrorText.value = null;
        }
      }
    });
  }

  getPetClinic() async {
    var clinicList = await petRepository.getClinic();
    clinicList
        .add(Clinic(id: -1, name: "Others", telephone: "", isActive: true));
    _clinics.value = clinicList;
  }

  onSelectedClinic(Clinic clinic) {
    _selectedClinic.value = clinic;
  }

  onCreatePetClinic() async {
    await petRepository.createPetClinic(
      PetClinic(
        otherClinicName: otherClinicName.text,
        otherClinicTelephone: otherClinicPhoneNumber.text,
        petId: editingPet.id!,
        clinicId:
            _selectedClinic.value?.id == -1 ? null : _selectedClinic.value?.id,
      ),
    );
  }

  checkInformation() {
    if (_selectedClinic.value?.id == -1) {
      if (otherClinicName.text.isEmpty) {
        _otherClinicNameErrorText.value = 'Please input clinic name';
      }
      if (otherClinicPhoneNumber.text.isNotEmpty &&
          (!otherClinicPhoneNumber.text.isThaiPhoneNumber())) {
        _otherClinicPhoneErrorText.value = 'Please input correct phone number';
      }
      return otherClinicName.text.isNotEmpty && checkPhoneFormat();
    } else {
      return true;
    }
  }

  checkPhoneFormat() {
    if (otherClinicPhoneNumber.text.isEmpty) {
      return true;
    } else {
      return otherClinicPhoneNumber.text.isThaiPhoneNumber();
    }
  }

  @override
  void dispose() {
    super.dispose();
    otherClinicName.dispose();
    otherClinicPhoneNumber.dispose();
  }
}
