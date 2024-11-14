import 'package:deemmi/core/data/api/user_api.dart';
import 'package:deemmi/core/domain/auth/user_model.dart';

class UserRepository {
  final UserAPI userAPI;

  UserRepository(this.userAPI);

  Future<User> getMyProfile() async {
    return await userAPI.getMyProfile();
  }
}
