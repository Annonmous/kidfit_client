import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:foodeoapp/MVC/view/home/MainhomeScreen.dart';
import 'package:foodeoapp/MVC/view/home/ProfileScreen.dart';
import 'package:foodeoapp/MVC/view/home/SearchScreen.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/drawer.dart';
import 'package:get/get.dart';
import '../../../constant/theme.dart';

class BottomNavBar extends StatefulWidget {
  final int? initialIndex;
  BottomNavBar({this.initialIndex});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = widget.initialIndex ?? _currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        builder: (themeController) => AnnotatedRegion(
              value: const SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.white,
              ),
              child: Scaffold(
                extendBody: true,
                appBar: CustomAppBar(
                    backgroundColor: _currentIndex == 3
                        ? themeController.colorPrimary
                        : themeController.bgcolor,
                        leadingColor: _currentIndex == 3
                        ? Colors.white
                        : themeController.colorPrimary,
                        titleColor:  _currentIndex == 3?
                         Colors.white
                        : themeController.textcolor,
                    Title: _PageTitle(_currentIndex),
                    showShop: true),
                drawer: AppDrawer(),
                body: _buildPage(_currentIndex),
                bottomNavigationBar: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                    ),
                    child: Material(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: BottomNavigationBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        currentIndex: _currentIndex,
                        selectedIconTheme:
                            IconThemeData(color: themeController.colorPrimary),
                        unselectedIconTheme: IconThemeData(
                          color: themeController.bottomiconcolor,
                        ),
                        selectedItemColor: themeController.colorPrimary,
                        unselectedItemColor: themeController.bottomiconcolor,
                        selectedLabelStyle: TextStyle(
                            color: themeController.colorPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp),
                        unselectedLabelStyle: TextStyle(
                            color: themeController.bottomiconcolor,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp),
                        onTap: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        type: BottomNavigationBarType.fixed,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _currentIndex == 0
                                  ? SvgPicture.asset(
                                      "assets/icons/home.svg",
                                      height: 20,
                                      width: 20,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/homeb.svg",
                                      height: 17,
                                      width: 17,
                                      color: themeController.bottomiconcolor,
                                    ),
                            ),
                            label: 'Home'.tr,
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _currentIndex == 1
                                  ? SvgPicture.asset(
                                      "assets/icons/searchb.svg",
                                      height: 20,
                                      width: 20,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/search.svg",
                                      height: 17,
                                      width: 17,

                                      color: themeController.bottomiconcolor,
                                      // color: Theme.of(context).disabledColor,
                                    ),
                            ),
                            label: 'Explore'.tr,
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _currentIndex == 2
                                  ? SvgPicture.asset(
                                      "assets/icons/cart_fill.svg",
                                      height: 20,
                                      width: 20,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/cart.svg",
                                      height: 17,
                                      width: 17,
                                      color: themeController.bottomiconcolor,
                                    ),
                            ),
                            label: 'Cart'.tr,
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _currentIndex == 3
                                  ? SvgPicture.asset(
                                      "assets/icons/user.svg",
                                      height: 20,
                                      width: 20,
                                      color: themeController.colorPrimary,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/userb.svg",
                                      height: 17,
                                      width: 17,
                                      color: themeController.bottomiconcolor,
                                    ),
                            ),
                            label: 'Profile'.tr,
                          ),
                        ],
                      ),
                    )),
              ),
            ));
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return SearchScreen();
      case 2:
        return HomeScreen();
      case 3:
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  String _PageTitle(int index) {
    switch (index) {
      case 0:
        return 'Explore';
      case 1:
        return 'Saerch';
      case 2:
        return 'Cart';
      case 3:
        return 'Profile';
      default:
        return 'Explore';
    }
  }
}
