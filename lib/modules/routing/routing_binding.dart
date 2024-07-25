import 'package:deemmi/modules/routing/routing_controller.dart';
import 'package:get/get.dart';

class RoutingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RoutingController(),
    );
  }
}
