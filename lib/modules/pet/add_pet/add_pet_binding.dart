import 'package:deemmi/modules/pet/add_pet/add_pet_controller.dart';
import 'package:get/get.dart';

class AddPetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AddPetController(),
    );
  }
}
