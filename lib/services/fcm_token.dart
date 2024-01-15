import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import '../firebase_options.dart';

// Future<void> _onBackground_listener(RemoteMessage message) async {}

class FirebaseDB {
  static Future<FirebaseApp?> init() async {
    try {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ).then((value) => print("FirebaseConnected 🔥✅"));
      // LocalNotificationService.initialize();
      // FirebaseMessaging.onBackgroundMessage(_onBackground_listener);

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("object Open App");
        print(message.notification?.title);
      });

      // FirebaseMessaging.instance.getInitialMessage();
      // FirebaseMessaging.onMessage.listen((event) {
      //   LocalNotificationService.display(event);
      // });
      FirebaseMessaging.instance.subscribeToTopic('subscription');
//------------------------

//-------------------------

      final fcmToken = await FirebaseMessaging.instance.getToken();
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;

      print("-----------fcmToken: ${fcmToken}");
      print("-----------Device ID: ${deviceInfo.id}");
      final pref = DataStroge();
      pref.insertDeviceAndFCMInformation(
          FcmToken: fcmToken, deviceID: deviceInfo.id);
    } catch (e) {
      print(e);
    }
  }
}
