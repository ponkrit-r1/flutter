import 'package:deemmi/core/data/app_storage.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final RxInt _currentPage = 0.obs;
  final AppStorage _appStorage;
  OnBoardingController(this._appStorage);

  int get currentPage => _currentPage.value;

  setOnBoardingFinish() async {
    await _appStorage.setFirstInstall(false);
  }

  setCurrentPage(int index) {
    _currentPage.value = index;
  }
}
