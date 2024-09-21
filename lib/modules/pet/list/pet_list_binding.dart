import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/modules/pet/list/pet_list_controller.dart';
import 'package:get/get.dart';

import '../../../core/data/api/pet_api.dart';

class PetListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => PetListController(
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
