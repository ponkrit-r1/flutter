import 'package:deemmi/core/domain/pet/clinic.dart';
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
  var otherClinicPhoneNumber = TextEditingController();

  @override
  onReady() {
    getPetClinic();
    super.onReady();
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

  @override
  void dispose() {
    super.dispose();
    otherClinicName.dispose();
    otherClinicPhoneNumber.dispose();
  }
}
