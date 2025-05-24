import 'dart:io';

import 'package:deemmi/core/data/app_storage.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class RoutingController extends GetxController {
  final AppStorage appStorage;

  RoutingController({required this.appStorage});

  Future<String> getInitialRoute() async {
    if (!(await hasNetwork())) {
      return Routes.noConnection;
    }
    var session = await appStorage.getUserSession();
    if (session == null) {
      if (appStorage.isFirstInstall()) {
        return Routes.onboarding;
      } else {
        return Routes.signIn;
      }
    } else {
      return Routes.root;
    }
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
