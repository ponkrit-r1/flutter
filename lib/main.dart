import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/network/api_client.dart';
import 'package:deemmi/core/network/url.dart';
import 'package:deemmi/modules/pet/list/pet_list_controller.dart';
import 'package:deemmi/routes/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/data/app_storage.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appStorage = AppStorage.shared;
  await appStorage.initialize();
  final rxAppStorage = appStorage.obs;
  final apiClient = ApiClient.fromStore(
    store: rxAppStorage,
    baseUrl: baseUrl,
  );
  Get.put(appStorage, permanent: true);
  Get.put(apiClient, permanent: true);
  Get.put(
    PetListController(
      PetRepository(
        PetAPI(
          Get.find(),
          Get.find(),
        ),
      ),
    ),
  );
  //var initialRoute = await Get.find<RoutingController>().getInitialRoute();
  runApp(const MyApp(initialRoute: Routes.routing));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: appThemeData,
      debugShowCheckedModeBanner: false,
      title: 'Pettagu',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child ?? const SizedBox.shrink(),
        );
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
      ],
      getPages: AppPages.pages,
      initialRoute: initialRoute,
    );
  }
}
