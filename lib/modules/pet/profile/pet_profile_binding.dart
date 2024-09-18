import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/modules/pet/profile/pet_profile_controller.dart';
import 'package:deemmi/routes/app_routes.dart';
import 'package:get/get.dart';

class PetProfileBinding extends Bindings {
  @override
  void dependencies() {
    var petModel = Get.arguments[RouteParams.petModel];
    Get.lazyPut(
      () => PetProfileController(
        petModel: petModel,
        petRepository: PetRepository(
          PetAPI(Get.find(), Get.find()),
        ),
      ),
    );
  }
}
