
import 'package:deemmi/core/data/api/authentication_api.dart';
import 'package:deemmi/core/data/api/user_api.dart';
import 'package:deemmi/core/network/api_client.dart';
import 'package:deemmi/core/network/url.dart';
import 'package:deemmi/routes/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/data/app_storage.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_controller.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:deemmi/core/services/notification_service.dart';
import 'package:deemmi/modules/settings/account_setting/account_setting_controller.dart';
import 'package:deemmi/core/data/repository/user_repository.dart';
import 'package:deemmi/core/domain/auth/user_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    // โหลดภาษาเริ่มต้นจาก SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final String languageCode = prefs.getString('language') ?? 'en';

  final appStorage = AppStorage.shared;
  await appStorage.initialize();
  final rxAppStorage = appStorage.obs;
  final apiClient = ApiClient.fromStore(
    store: rxAppStorage,
    baseUrl: baseUrl,
  );
  Get.put(appStorage, permanent: true);
  Get.put(apiClient, permanent: true);





  // Initialize AuthenticationAPI for SignInController
  final authAPI = AuthenticationAPI(apiClient, appStorage);
  Get.put(SignInController(authAPI),
      permanent: true); 


 //====================================new mar 19 
  // ✅ เพิ่ม appStorage ใน Constructor ของ UserAPI ด้วย mar 19
  final userAPI = UserAPI(apiClient, appStorage);
  Get.put(userAPI, permanent: true);
    final userRepository = UserRepository(userAPI);
  Get.put(userRepository, permanent: true);
  // ✅ Bind AccountSettingController เพื่อใช้ใน HomePage
  Get.put(AccountSettingController(userRepository), permanent: true);
//=============================end

  await Firebase.initializeApp(); // Initialize Firebase
  NotificationService.initialize(); // Initialize the notification service


 runApp(MyApp(
    initialRoute: Routes.routing,
    initialLocale: Locale(languageCode),
  ));
  //runApp(const MyApp(initialRoute: Routes.routing));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final Locale initialLocale;

const MyApp({super.key, required this.initialRoute, required this.initialLocale});
  // const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {




    return GetMaterialApp(
      theme: appThemeData,
      debugShowCheckedModeBanner: false,
      title: 'Pettagu',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child ?? const SizedBox.shrink(),
        );
      },

      locale: initialLocale,
      fallbackLocale: const Locale('en'),
     supportedLocales: const [
        Locale('en'), // ภาษาอังกฤษ
        Locale('th'), // ภาษาไทย
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
  
      getPages: AppPages.pages,
      initialRoute: initialRoute,
    );
  }
}
