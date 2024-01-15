import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/MVC/view/loginScreen/userTypeScreen.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import 'constant/constants.dart';
import 'helper/data_storage.dart';
import 'services/fcm_token.dart';

void main() async {
  await FirebaseDB.init();
  DataStroge.getInstance.initiateSession();
  loadConfig();
  runApp(const MyApp());

  Get.put(ThemeHelper());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          home: child,
        );
      },
      child: UserTypeScreen(),
    );
  }
}

Future<void> loadConfig() async {
  try {
    String configString = await rootBundle.loadString('config/config.json');
    Map<String, dynamic> configJson = json.decode(configString);
    Constants.API_HOST = configJson['api_host'];
  } catch (e) {
    print(e);
    print("Configuration file does not exists or is not valid");
    exit(0);
  }
}
