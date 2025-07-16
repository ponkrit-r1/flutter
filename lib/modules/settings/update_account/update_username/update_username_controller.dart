// update_username_controller.dart
import 'package:deemmi/core/data/repository/user_repository.dart';
import 'package:deemmi/core/utils/validator/format_validator.dart';
import 'package:get/get.dart';

class UpdateUsernameController extends GetxController {
  final UserRepository userRepository;
  final String username;

  UpdateUsernameController(this.userRepository, this.username);

  final _isUpdating = false.obs;
  bool get isUpdating => _isUpdating.value;

  final _error = ''.obs;
  String get error => _error.value;

  void validateUsername(String newUsername) {
    if (newUsername.length < 2) {
      _error.value = 'Ensure this field has at least 2 characters long';
    } else if (!newUsername.isValidUsername()) {
      _error.value = 'Ensure this field has at least 2 characters and can contain letters, ., -, or _';
    } else {
      _error.value = '';
    }
  }

  Future<void> updateUsername(String newUsername) async {
    if (newUsername.length < 2) {
      _error.value = 'Ensure this field has at least 2 characters';
      return;
    } else if (!newUsername.isValidUsername()) {
      _error.value = 'Username must be at least 2 characters and can contain letters, ., -, or _';
      return;
    }

    _isUpdating.value = true;
    _error.value = '';
    try {
      bool success = await userRepository.updateUsername(newUsername);
      if (success) {
        // If successful, pop back to the previous screen
        Get.back(result: true);
      }
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isUpdating.value = false;
    }
  }
}
