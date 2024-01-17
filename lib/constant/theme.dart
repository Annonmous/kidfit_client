import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ThemeHelper extends GetxController {
  RxBool isDarkTheme = false.obs;

  static const colortoast = const Color(0xFFf7746c);
  static const colortoasttext = const Color(0xffffffff);

  final colorPrimary = const Color(0xFFf7746c);
  final colorCanvas = const Color(0xFFfecdca);

  final circleicon = const Color(0xfffd853a);
  final circlecolor = const Color(0xffFFEAD5);
  final disablecolor = const Color(0xff475467);

  final bottomiconcolor = const Color(0xff475467);
  final bordercolor = const Color.fromARGB(255, 233, 233, 233);
  final colorIcon = Colors.black;
  final textfiledecolor = const Color.fromARGB(255, 244, 244, 245);

  final nutrientsecolor = const Color.fromARGB(255, 244, 244, 245);
  final textcolor = const Color(0xff101828);

  final textcolor2 = Color(0xff101828).withOpacity(0.5);

  final cardcolor = const Color(0xfff2f4f7);

  final backgoundcolor = const Color(0xffffffff);
  final bgcolor = const Color(0xfff2f4f7);
  final lightcolor = const Color(0xfff2f4f7);
  final colorwhite = const Color(0xffffffff);

  final containerGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 228, 210),
      Color.fromARGB(255, 253, 240, 231),
      Color.fromARGB(255, 255, 241, 241),
      Color.fromARGB(255, 253, 240, 231),
      Color.fromARGB(255, 255, 241, 241),
      Color.fromARGB(255, 253, 241, 232),
    ],
    stops: [
      0.1,
      0.4,
      0.6,
      0.9,
      0.4,
      0.6,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final screenGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 228, 210),
      Color.fromARGB(255, 253, 240, 231),
      Color.fromARGB(255, 255, 241, 241),
      Color.fromARGB(255, 253, 240, 231),
      Color.fromARGB(255, 255, 241, 241),
      Color.fromARGB(255, 253, 241, 232),
    ],
    stops: [
      0.1,
      0.4,
      0.6,
      0.9,
      0.4,
      0.6,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final bottomsheetGradient = const LinearGradient(
    colors: [
      // Color.fromARGB(255, 248, 237, 208),

      Color(0xffFFF7E5),
      Color(0xffFFF7E5),
      Color.fromARGB(255, 253, 250, 243),

      Color.fromARGB(255, 252, 249, 244),
      Color.fromARGB(255, 253, 251, 245),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),

      // Color(0xffFEF7F7),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
      // Color(0xffFEF7F7),

      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
      Color(0xffFFFFFF),
    ],
    transform: GradientRotation(20 / 13),
    tileMode: TileMode.clamp,
    // stops: [
    //   0.8,
    //   0.4,
    //   0.1,
    //   0.9,
    //   0.6,
    //   0.1,
    // ],
    // begin: Alignment(1.1, 0.0),
    // end: Alignment.bottomRight,
  );

  final backgroundGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 248, 94, 86),
      Color.fromARGB(255, 242, 96, 89),

      Color.fromARGB(255, 243, 100, 95),
      Color.fromARGB(255, 248, 105, 110),
      // Color.fromARGB(255, 250, 103, 96),
      // Color.fromARGB(255, 255, 123, 116),
      // Color(0xFFf7746c),
      // Color.fromARGB(255, 250, 125, 119),
    ],
    stops: [
      0.5,
      0.4,
      0.6,
      0.9,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  SystemUiOverlayStyle get systemUiOverlayStyleMain => SystemUiOverlayStyle(
        statusBarColor: Color(0xffffffff),
        systemNavigationBarColor: Color(0xffffffff),
        statusBarBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );

  SystemUiOverlayStyle get systemUiOverlayStyleSplash => SystemUiOverlayStyle(
        statusBarColor: const Color.fromARGB(255, 248, 94, 86),
        systemNavigationBarColor: const Color.fromARGB(255, 248, 105, 110),
        statusBarBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );
  SystemUiOverlayStyle get systemUiOverlayStyleForBlack => SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
        statusBarBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );

  SystemUiOverlayStyle get systemUiOverlayStyleForPrimary =>
      SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 248, 94, 86),
        systemNavigationBarColor: Color(0xffffffff),
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );
  SystemUiOverlayStyle get systemUiOverlayStylesplash => SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 248, 94, 86),
        systemNavigationBarColor: Color.fromARGB(255, 248, 105, 110),
        statusBarBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );

  SystemUiOverlayStyle get systemUiOverlayStyleForwhite => SystemUiOverlayStyle(
        statusBarColor: const Color(0xfff2f4f7),
        systemNavigationBarColor: const Color(0xfff2f4f7),
        statusBarBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );
  SystemUiOverlayStyle get systemUiOverlayStyleForAuth => SystemUiOverlayStyle(
        statusBarColor: const Color.fromARGB(255, 250, 250, 250),
        systemNavigationBarColor: const Color.fromARGB(255, 250, 250, 250),
        statusBarBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );

  SystemUiOverlayStyle get systemUiOverlayStyleForGradient =>
      SystemUiOverlayStyle(
        statusBarColor: const Color.fromARGB(255, 255, 228, 210),
        systemNavigationBarColor: Color(0xffffffff),
        statusBarBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );
}
