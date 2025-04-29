// update_password_controller.dart
import 'package:get/get.dart';
import 'package:dio/dio.dart'; // Importing Dio to handle DioError
import 'package:deemmi/core/data/repository/user_repository.dart';

class UpdatePasswordController extends GetxController {
  final UserRepository userRepository;

  UpdatePasswordController(this.userRepository);

  final _isUpdating = false.obs;
  bool get isUpdating => _isUpdating.value;

  final _error = ''.obs;
  String get error => _error.value;

  // Regular expression for password validation
  final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&\*]).{8,}$',
  );

  void validatePassword(
      {required String currentPassword,
      required String newPassword,
      required String confirmPassword}) {
    if (newPassword.isEmpty) {
      _error.value = "New password must not be empty.";
    } else if (!passwordRegex.hasMatch(newPassword)) {
      _error.value =
          "Password must be at least 8 characters long, include an uppercase letter, lowercase letter, a number, and a special character.";
    } else if (newPassword != confirmPassword) {
      _error.value = "New password and confirm password do not match.";
    } else {
      _error.value = "";
    }
  }

  Future<void> changePassword(
      {required String currentPassword,
      required String newPassword,
      required String confirmPassword}) async {
    // Validate password inputs first
    validatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword);

    // If there is an error, do not proceed with the API call
    if (_error.value.isNotEmpty) {
      return;
    }

    _isUpdating.value = true;
    _error.value = '';

    try {
      final response = await userRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPassword2: confirmPassword,
      );

      if (response['success'] == true) {
        // If successful, pop back to the previous screen
        Get.back(result: true);
      } else {
        // If API response was not successful, set error message from the response
        _error.value = response['data'] ?? "Failed to change the password.";
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data is Map<String, dynamic>) {
          // Extracting the exact error message from the API response
          _error.value = e.response!.data['message'] ?? "An error occurred.";
        } else {
          _error.value = "An error occurred: ${e.message}";
        }
      } else {
        _error.value = e.toString();
      }
    } finally {
      _isUpdating.value = false;
    }
  }
}
