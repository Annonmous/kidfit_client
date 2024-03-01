import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/MVC/view/loginScreen/LoginWithEmailScreen.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/round_button.dart';
import '../../../helper/data_storage.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    isloggedcheck();
  }

  String? token;
  isloggedcheck() async {
    log('UserToken');
    SharedPreferences instance = await SharedPreferences.getInstance();

    token = instance.getString("token");
    log(token.toString());
    if (token != null) {
      var _pref = DataStroge();

      await _pref.getUserData();
      if (DataStroge.userRole == 'owner') {
        print("Restaurant Token :${DataStroge.userToken}");
        // Navigation.getInstance.pagePushAndReplaceNavigation(
        //   context,
        //   ProfileScreen(),
        // );
      } else {
        // Navigation.getInstance
        //     .pagePushAndReplaceNavigation(context, VideoReelsScreen());
      }
    } else {
      print('no user');
      // Navigation.getInstance
      //     .pagePushAndReplaceNavigation(context, UserTypeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleSplash,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: Constants.screenPadding),
            decoration: BoxDecoration(
              gradient: themecontroller.backgroundGradient,
              color: themecontroller.colorPrimary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(flex: 2, child: SizedBox(height: 40.sp)),
                Container(
                  height: 300.sp,
                  width: 300.sp,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      // color: themecontroller.colorwhite,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/appicon.png'
                        // "assets/appicon.png",
                      ))),
                ),
                Expanded(flex: 2, child: SizedBox(height: 30.sp)),
                SpringWidget(
                  onTap: () {
                    Navigation.getInstance
                        .screenNavigation(context, LoginWithEmail());
                  },
                  child: RoundButton(
                    margin: 0,
                    backgroundColor: themecontroller.colorPrimary,
                    borderColor: themecontroller.colorwhite,
                    height: 58.sp,
                    onTap: () {
                      // controller.selectedUserType.value = 'user';
                      // log('object  ${controller.selectedUserType.value}');
                    },
                    title: 'Get Started',
                    gradient: true,
                    textColor: themecontroller.colorwhite,
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

//
