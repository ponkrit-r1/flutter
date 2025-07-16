import 'package:deemmi/core/data/repository/user_repository.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  final UserRepository userRepository;

  UpdateNameController(this.userRepository);

  final _isUpdating = false.obs;
  bool get isUpdating => _isUpdating.value;

  final _error = ''.obs;
  String get error => _error.value;

  // Regular expression for validation (allow only Thai alphabets and English alphabets)
  final RegExp validNameRegex = RegExp(r'^[ก-ฮa-zA-Z]*$');

  void validateName({String? firstName, String? lastName}) {
    if (firstName == null || firstName.isEmpty) {
      _error.value = "First Name: This field may not be blank.";
    } else if (lastName == null || lastName.isEmpty) {
      _error.value = "Last Name: This field may not be blank.";
    } else if (!validNameRegex.hasMatch(firstName)) {
      _error.value =
          "First Name: Allow only Thai alphabets, English alphabets, and spaces.";
    } else if (!validNameRegex.hasMatch(lastName)) {
      _error.value =
          "Last Name: Allow only Thai alphabets, English alphabets, and spaces.";
    } else {
      _error.value = "";
    }
  }

  Future<void> updateName(
      {required String firstName, required String lastName}) async {
    // Validate name inputs first when clicking save button
    validateName(firstName: firstName, lastName: lastName);

    // If there is an error, do not proceed with the API call
    if (_error.value.isNotEmpty) {
      return;
    }

    _isUpdating.value = true;
    _error.value = '';
    try {
      bool success = await userRepository.updateName(
          firstName: firstName, lastName: lastName);
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

// // update_name_controller.dart
// import 'package:deemmi/core/data/repository/user_repository.dart';
// import 'package:get/get.dart';

// class UpdateNameController extends GetxController {
//   final UserRepository userRepository;

//   UpdateNameController(this.userRepository);

//   final _isUpdating = false.obs;
//   bool get isUpdating => _isUpdating.value;

//   final _error = ''.obs;
//   String get error => _error.value;

//   Future<void> updateName({String? firstName, String? lastName}) async {
//     _isUpdating.value = true;
//     _error.value = '';
//     try {
//       bool success = await userRepository.updateName(
//           firstName: firstName, lastName: lastName);
//       if (success) {
//         // If successful, pop back to the previous screen
//         Get.back(result: true);
//       }
//     } catch (e) {
//       _error.value = e.toString();
//     } finally {
//       _isUpdating.value = false;
//     }
//   }
// }
