import 'package:deemmi/core/data/api/user_api.dart';
import 'package:deemmi/core/domain/auth/user_model.dart';

class UserRepository {
  final UserAPI userAPI;

  UserRepository(this.userAPI);

  Future<User> getMyProfile() async {
    return await userAPI.getMyProfile();
  }

  //update username
  Future<bool> updateUsername(String username) async {
    return await userAPI.updateUsername(username);
  }

  // user_repository.dart
  Future<bool> updateName({String? firstName, String? lastName}) async {
    return await userAPI.updateName(firstName: firstName, lastName: lastName);
  }

  // user_repository.dart
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPassword2,
  }) async {
    return await userAPI.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPassword2: newPassword2,
    );
  }
}
