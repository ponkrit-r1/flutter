import 'package:deemmi/core/domain/pet/health/pet_health_info.dart';
import 'package:deemmi/modules/pet/health_info/pet_health_info_controller.dart';
import 'package:get/get.dart';

import '../../../core/data/api/pet_api.dart';
import '../../../core/data/repository/pet_repository.dart';
import '../../../core/domain/pet/pet_model.dart';
import '../../../routes/app_routes.dart';

class PetHealthInfoBinding extends Bindings {
  @override
  void dependencies() {
    PetModel editingPet = Get.arguments[RouteParams.petModel];
    PetHealthInfo? healthInfo = Get.arguments[RouteParams.healthInfoModel];
    Get.lazyPut(
      () => PetHealthInfoController(
        PetRepository(
          PetAPI(
            Get.find(),
            Get.find(),
          ),
        ),
        editingPet,
        healthInfo,
      ),
    );
  }
}
