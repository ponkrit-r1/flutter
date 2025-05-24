import 'package:deemmi/core/data/repository/user_repository.dart';
import 'package:deemmi/core/domain/auth/user_model.dart';
import 'package:get/get.dart';

class AccountSettingController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final Rxn<User?> _profile = Rxn(null);

  User? get profile => _profile.value;

  final UserRepository userRepository;

  AccountSettingController(
    this.userRepository,
  );

  @override
  void onReady() {
    super.onReady();

    initData();
  }

  getMyProfile() async {
    _profile.value = await userRepository.getMyProfile();

    print('${_profile.value} <-------------  _profile.value');
    update();
  }

  initData() async {
    await getMyProfile();
  }
}
