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
    } finally {
      isLoading.value = false;
    }
  }

  onAddPet(PetModel pet) {
    _petList.value = [pet];
  }
}
