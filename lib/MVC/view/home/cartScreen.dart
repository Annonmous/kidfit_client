import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/MVC/controller/homeController.dart';
import 'package:foodeoapp/MVC/controller/kidController.dart';
import 'package:foodeoapp/MVC/model/product_model.dart';
import 'package:foodeoapp/MVC/view/home/productDetailScreen.dart';
import 'package:foodeoapp/components/PopularProductCard.dart';
import 'package:foodeoapp/components/ProductCard.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';
import 'package:foodeoapp/components/drawer.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  @override
  final homeController = Get.put(HomeController());

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
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(children: [
                    ...homeController.CartList.map((e) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.sp),
                      child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20.sp),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.sp)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.sp, vertical: 10.sp),
                                    child: Text(
                                      e.Kid_name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18.sp),
                                    ),
                                  ),
                                  ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.sp),
                                      child: ImageWidget(
                                        imageUrl: e.product_image,
                                        height: 60.sp,
                                        width: 60.sp,
                                      ),
                                    ),
                                    title: Text(
                                      e.product_name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12.sp),
                                    ),
                                    trailing: SpringWidget(
                                      onTap: () {
                                        homeController.addAndRemoveCart(e, 0);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: themeController.colorPrimary,
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                    )).toList()
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
