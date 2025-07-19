import 'package:get/get.dart';
import 'package:deemmi/routes/app_routes.dart';
import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'vaccine_program_controller.dart';

class VaccineProgramBinding extends Bindings {
  @override
  void dependencies() {
    // Register PetAPI and PetRepository if not already registered
    if (!Get.isRegistered<PetAPI>()) {
      Get.lazyPut(() => PetAPI(Get.find(), Get.find()));
    }
    if (!Get.isRegistered<PetRepository>()) {
      Get.lazyPut(() => PetRepository(Get.find<PetAPI>()));
    }

    Get.lazyPut(
      () => VaccineProgramController(Get.find<PetRepository>()),
    );
  }
}
