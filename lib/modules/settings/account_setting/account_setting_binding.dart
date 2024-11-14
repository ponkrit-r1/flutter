import 'package:deemmi/core/data/api/user_api.dart';
import 'package:deemmi/core/data/repository/user_repository.dart';
import 'package:deemmi/modules/settings/account_setting/account_setting_controller.dart';
import 'package:get/get.dart';

class AccountSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AccountSettingController(
        UserRepository(
          UserAPI(
            Get.find(),
            Get.find(),
          ),
        ),
      ),
    );
  }
}
