import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/MVC/view/kidsScreen/KIdsListScreen.dart';
import 'package:foodeoapp/MVC/view/loginScreen/LoginWithEmailScreen.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AppDrawer extends StatelessWidget {
  @override
  final _pref = DataStroge();
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: themecontroller.colorPrimary,
                  // image: DecorationImage(
                  //   image: AssetImage('assets/images/bg2.png'),
                  //   fit: BoxFit.cover,
                  //   colorFilter: ColorFilter.mode(
                  //     themecontroller.colorPrimary
                  //         .withOpacity(0.6), // Adjust the opacity as needed
                  //     BlendMode.srcATop,
                  //   ),
                  // ),
                ),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 21.sp,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(110),
                          child: ImageWidget(
                              height: 80.sp,
                              width: 100,
                              imageUrl: DataStroge.userImage.string
                              // 'https://a.storyblok.com/f/191576/1200x800/faa88c639f/round_profil_picture_before_.webp'
                              ),
                        ),
                      ),
                      SizedBox(
                        width: 150.sp,
                        child: Text(
                          textAlign: TextAlign.start,
                          DataStroge.userName.string,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.sp),
                        ),
                      ),
                      SizedBox(
                        width: 170.sp,
                        child: Text(
                          textAlign: TextAlign.start,
                          DataStroge.userEmail.string,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.sp),
                        ),
                      ),
                    ],
                  ),
                )),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Navigate to the home screen or perform any other action
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Children List'),
              onTap: () {
                Navigation.getInstance
                    .screenNavigation(context, KidsListScreen());


              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
              ),
              onTap: () async {
                await _pref.logout();
                Navigation.getInstance
                    .pagePushAndReplaceNavigation(context, LoginWithEmail());
              },
            ),
          ],
        ),
      );
    });
  }
}
