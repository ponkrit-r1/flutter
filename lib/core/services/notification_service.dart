import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() async {
    // Request permissions for iOS
    //  await _firebaseMessaging.requestPermission();
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('P________User granted permission');
    } else {
      print('_________User declined or has not accepted permission');
    }
    // Initialize Flutter Local Notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      // onSelectNotification: (String? payload) async {
      //   if (payload != null) {
      //     // Navigate to the specified route when notification is tapped
      //     Get.toNamed(payload);
      //   }
      // },
    );

    // Handle messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    // Handle messages when the app is opened from a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // if (message.data['route'] != null) {
      //   Get.toNamed(message.data['route']);
      // }
      //forece ไปที่หน้า sign_in ก่อน จริงๆต้องเปลี่ยนไปหน้า root (home)
      if (message.data['route'] == '/sign_in') {
        Get.toNamed('/sign_in'); // Opens the SignInPage when tapped
      }
    });

    // Print device token
    await getDeviceToken();
  }

  static Future<void> getDeviceToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        print('Device Token: $token');
        await sendTokenToServer(token);
        // Optionally: Send the token to your backend for storing
      } else {
        print('Failed to get device token');
      }
    } catch (e) {
      print('Error retrieving device token: $e');
    }
  }

  static Future<void> sendTokenToServer(String token) async {
    //test สำหรับเรียก api โดยส่ง token ไปเก็บที่ api
    print('Sending token to server: $token');
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel', // Channel ID
      'High Importance Notifications', // Channel Name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformDetails,
      payload:
          message.data['route'] ?? '/sign_in', // Default route is '/sign_in'
    ); //      payload: message.data['route'], // Pass the route to be used on tap
  }
}
