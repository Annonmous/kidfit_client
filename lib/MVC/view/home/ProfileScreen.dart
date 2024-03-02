import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/MVC/view/loginScreen/LoginWithEmailScreen.dart';
import 'package:foodeoapp/MVC/view/school%20Screen/addProductScreen.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final _pref = DataStroge();
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
          value: themecontroller.systemUiOverlayStyleForPrimary,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 250.sp,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.sp),
                          bottomRight: Radius.circular(30.sp)),
                      image: DecorationImage(
                        image: AssetImage('assets/images/food4.jpg'),
                        fit: BoxFit
                            .cover, // Use BoxFit.cover instead of BoxFit.fill
                        colorFilter: ColorFilter.mode(
                          themecontroller.colorPrimary.withOpacity(0.9),
                          BlendMode.srcATop,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.screenPadding,
                          vertical: Constants.screenPadding),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 60.sp,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(110),
                                child: ImageWidget(
                                    height: 110.sp,
                                    width: 140,
                                    imageUrl:
                                        // DataStroge.userImage.string
                                        'https://a.storyblok.com/f/191576/1200x800/faa88c639f/round_profil_picture_before_.webp'),
                              ),
                            ),
                            SizedBox(
                              height: 2.sp,
                            ),
                            SizedBox(
                              width: 150.sp,
                              child: Text(
                                textAlign: TextAlign.center,
                                // 'Test Users',
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
                              width: 150.sp,
                              child: Text(
                                textAlign: TextAlign.center,
                                // 'Test Users',
                                DataStroge.userEmail.string,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 1.sp),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.sp, vertical: 20.sp),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(179, 0, 0, 0)
                                .withOpacity(0.1),
                            blurRadius: 20.0,
                            spreadRadius: 1,
                            offset: Offset(2, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          ListTile(
                            leading: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.sp),
                            ),
                          ),
                          DataStroge.userRole.value == 'SCHOOL'
                              ? ListTile(
                                  leading: Text(
                                    'Add Product',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.sp),
                                      
                                  ),
                                  onTap: () {
                                    Navigation.getInstance.screenNavigation(context, AddProductScreen());
                                  },
                                )
                              : ListTile(
                                  leading: Text(
                                    'children List',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.sp),
                                  ),
                                ),
                          ListTile(
                            leading: Text(
                              'Change Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.sp),
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.sp),
                            ),
                          ),
                          ListTile(
                            onTap: () async {
                              await _pref.logout();
                              Navigation.getInstance
                                  .pagePushAndReplaceNavigation(
                                      context, LoginWithEmail());
                            },
                            leading: Text(
                              'Logout',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.sp),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
