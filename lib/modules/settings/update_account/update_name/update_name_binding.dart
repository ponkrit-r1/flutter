// update_name_binding.dart
import 'package:deemmi/modules/settings/update_account/update_name/update_name_controller.dart';
import 'package:get/get.dart';
import 'package:deemmi/core/data/repository/user_repository.dart';
import 'package:deemmi/core/data/api/user_api.dart';

class UpdateNameBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure UserAPI is also registered if needed.
    Get.lazyPut<UserAPI>(() => UserAPI(Get.find(), Get.find()));

    // Register UserRepository.
    Get.lazyPut<UserRepository>(() => UserRepository(Get.find<UserAPI>()));

    // Register UpdateNameController.
    Get.lazyPut<UpdateNameController>(() => UpdateNameController(
          Get.find<UserRepository>(),
        ));
  }
}
