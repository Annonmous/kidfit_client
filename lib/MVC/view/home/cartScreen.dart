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
import 'package:foodeoapp/components/round_button.dart';
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
              child: homeController.CartList.isEmpty
                  ? Center(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/empty_cart.png'),
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Obx(
                        () => Column(children: [
                          ...kidController
                              .KidsList.map((kidData) => homeController.CartList
                                  .where((element) =>
                                      element.kidId == kidData.id).isEmpty
                              ? SizedBox()
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.sp),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.sp),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                    179, 0, 0, 0)
                                                .withOpacity(0.1),
                                            blurRadius: 20.0,
                                            spreadRadius: 1,
                                            offset: Offset(2, 8),
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(20.sp)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.sp,
                                                vertical: 10.sp),
                                            child: Text(
                                              kidData.name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                          ...homeController.CartList.where(
                                                  (element) =>
                                                      element.kidId ==
                                                      kidData.id)
                                              .map((cart) => Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.sp),
                                                    child: ListTile(
                                                      leading: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.sp),
                                                        child: ImageWidget(
                                                          imageUrl:
                                                              cart.productImage,
                                                          height: 60.sp,
                                                          width: 60.sp,
                                                        ),
                                                      ),
                                                      title: Text(
                                                        '${cart.productName}',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.sp),
                                                      ),
                                                      trailing: SpringWidget(
                                                        onTap: () {
                                                          homeController
                                                              .addAndRemoveCart(
                                                                  cart, 0);
                                                        },
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: themeController
                                                              .colorPrimary,
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.sp),
                                            child: RoundButton(
                                              backgroundColor:
                                                  themeController.colorPrimary,
                                              textColor: Colors.white,
                                              height: 30.sp,
                                              title: 'Checkout',
                                              onTap: () {
                                                homeController.CheckoutCart(
                                                    kidData.id,
                                                    kidData.parentId,
                                                    kidData.schoolId,
                                                    homeController.CartList,
                                                    context);
                                              },
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
