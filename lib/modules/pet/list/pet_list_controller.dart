import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PetListController extends GetxController {
  final RxBool isLoading = false.obs;

  final RxList<PetModel> _petList = RxList();

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
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
