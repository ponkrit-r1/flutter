import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final RxInt _currentPage = 0.obs;

  int get currentPage => _currentPage.value;

  setCurrentPage(int index) {
    _currentPage.value = index;
  }
}
