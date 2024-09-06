import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/modules/pet/add_pet/add_pet_controller.dart';
import 'package:get/get.dart';

class AddPetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AddPetController(
        PetRepository(
          PetAPI(
            Get.find(),
            Get.find(),
          ),
        ),
      ),
    );
  }
}
