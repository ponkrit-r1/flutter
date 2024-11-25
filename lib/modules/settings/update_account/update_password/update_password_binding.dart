import 'package:get/get.dart';
import 'package:deemmi/modules/settings/update_account/update_password/update_password_controller.dart';
import 'package:deemmi/core/data/repository/user_repository.dart';
import 'package:deemmi/core/data/api/user_api.dart';

class UpdatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    // Register dependencies
    Get.lazyPut<UserAPI>(() => UserAPI(Get.find(), Get.find()));
    Get.lazyPut<UserRepository>(() => UserRepository(Get.find<UserAPI>()));
    Get.lazyPut<UpdatePasswordController>(
        () => UpdatePasswordController(Get.find<UserRepository>()));
  }
}
