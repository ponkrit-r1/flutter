import 'package:deemmi/modules/settings/update_account/update_username/update_username_controller.dart';
import 'package:get/get.dart';
import 'package:deemmi/core/data/repository/user_repository.dart';
import 'package:deemmi/core/data/api/user_api.dart';

class UpdateUsernameBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure UserAPI is also registered if needed.
    Get.lazyPut<UserAPI>(() => UserAPI(Get.find(), Get.find()));

    // Register UserRepository.
    Get.lazyPut<UserRepository>(() => UserRepository(Get.find<UserAPI>()));

    // Register UpdateUsernameController.
    Get.lazyPut<UpdateUsernameController>(() => UpdateUsernameController(
          Get.find<UserRepository>(),
          Get.arguments['username'],
        ));
  }
}
