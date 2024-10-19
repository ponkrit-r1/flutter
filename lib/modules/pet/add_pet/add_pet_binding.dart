import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:deemmi/modules/pet/add_pet/add_pet_controller.dart';
import 'package:deemmi/routes/app_routes.dart';
import 'package:get/get.dart';

class AddPetBinding extends Bindings {

  @override
  void dependencies() {
    PetModel? editingPet = Get.arguments?[RouteParams.petModel];
    Get.lazyPut(
      () => AddPetController(
        PetRepository(
          PetAPI(
            Get.find(),
            Get.find(),
          ),
        ),
        editingPet: editingPet,
      ),
    );
  }
}
