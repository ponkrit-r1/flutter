import 'package:deemmi/modules/pet/clinic/add_pet_clinic_controller.dart';
import 'package:get/get.dart';

import '../../../core/data/api/pet_api.dart';
import '../../../core/data/repository/pet_repository.dart';
import '../../../core/domain/pet/pet_model.dart';
import '../../../routes/app_routes.dart';

class AddPetClinicBinding extends Bindings {
  @override
  void dependencies() {
    PetModel editingPet = Get.arguments[RouteParams.petModel];
    Get.lazyPut(
          () => AddPetClinicController(
        PetRepository(
          PetAPI(
            Get.find(),
            Get.find(),
          ),
        ),
        editingPet,
      ),
    );
  }
}
