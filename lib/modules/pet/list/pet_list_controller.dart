import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:deemmi/modules/pet/profile/pet_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PetListController extends GetxController {
  final RxBool isLoading = false.obs;

  final RxList<PetModel> _petList = RxList();

  final Rxn<PetModel> selectedPet = Rxn<PetModel>(); // ✅ เพิ่มตัวแปรเก็บ Pet ที่เลือก mar

  PetListController(this.petRepository);

  List<PetModel> get petList => _petList;

  final PetRepository petRepository;

  var hasRetry = false;

  @override
  void onReady() {
    super.onReady();
    getMyPet();
  }

  getMyPet() async {
    try {
      isLoading.value = true;
      _petList.value = await petRepository.getMyPet();

       // ✅ ถ้ายังไม่มีค่า ให้เลือกตัวแรกใน list อัตโนมัติ  mar
      if (selectedPet.value == null && _petList.isNotEmpty) {
        selectedPet.value = _petList.first;
      }


    } catch (e) {
      debugPrint(e.toString());
      //Temporary fix for 401 error
      if (!hasRetry) {
        getMyPet();
        hasRetry = true;
      }
    } finally {
      isLoading.value = false;
    }
  }

  deletePet(PetModel pet) async {
    try {
      isLoading.value = true;
      await petRepository.deletePet(pet.id!);
      await getMyPet();



        // ✅ อัปเดต selectedPet หลังลบ mar
      if (_petList.isNotEmpty) {
        selectedPet.value = _petList.first;
      } else {
        selectedPet.value = null;
      }


    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }


  }

        // ✅ เพิ่มฟังก์ชันสำหรับอัปเดต Pet ที่เลือก mar
  void  updateSelectedPet(PetModel pet) {
    selectedPet.value = pet;
  }
  void syncSelectedPet() {
  final profileController = Get.find<PetProfileController>();
  if (selectedPet.value != null) {
    profileController.setDisplaySetModel(selectedPet.value!);
  }
}

}
