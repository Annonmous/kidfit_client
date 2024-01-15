import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/MVC/controller/homeController.dart';
import 'package:foodeoapp/MVC/controller/kidController.dart';
import 'package:foodeoapp/MVC/view/home/productDetailScreen.dart';
import 'package:foodeoapp/components/ProductCard.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/drawer.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  final homeController = Get.put(HomeController());
  final kidController = Get.put(KidsController());
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        builder: (themeController) => AnnotatedRegion(
              value: themeController.systemUiOverlayStyleForwhite,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: themeController.bgcolor,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.screenPadding),
                    child: Column(children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.sp,
                            ),
                            SpringWidget(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(child:
                                        GetBuilder<ThemeHelper>(
                                            builder: (themecontroller) {
                                      return Container(
                                        height: 300.sp,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 30.sp,
                                              ),
                                              Text(
                                                'Select Child',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 30.sp,
                                              ),
                                              Container(
                                                height: 200.sp,
                                                child: ListView.builder(
                                                  itemCount: kidController
                                                      .KidsList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return ListTile(
                                                      title: Text(kidController
                                                          .KidsList[index]
                                                          .name),
                                                          
                                                    );
                                                  },
                                                ),
                                              )
                                            ]),
                                      );
                                    }));
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.search,
                                    color: themeController.colorIcon
                                        .withOpacity(0.4),
                                  ),
                                  title: Text(
                                    'Select Children..',
                                    style: TextStyle(
                                        color: themeController.textcolor,
                                        fontSize: 12.sp),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Text(
                                'recommended For You 🔥',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: SpringWidget(
                                onTap: () {
                                  // Navigation.getInstance
                                  //     .screenNavigation(context, RecommendedScreen());
                                },
                                child: Text(
                                  'See All',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 13.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Obx(
                          () => Container(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: homeController.ProductList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var list = homeController.ProductList;
                                return SpringWidget(
                                  onTap: () {
                                    Navigation.getInstance.screenNavigation(
                                        context,
                                        ProductDetailsScreen(
                                            ProductData: list[index]));
                                  },
                                  child: productcard(
                                      image: list[index].image,
                                      name: list[index].name,
                                      price: list[index].Price.toString(),
                                      SchoolImage: list[index].image),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ));
  }
}
