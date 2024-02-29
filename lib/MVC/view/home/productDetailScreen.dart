import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/MVC/controller/homeController.dart';
import 'package:foodeoapp/MVC/model/CartModel.dart';
import 'package:foodeoapp/MVC/model/product_model.dart';
import 'package:foodeoapp/components/ProductCard.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/flutter_toast.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({
    super.key,
    required this.ProductData,
  });
  final ProductModel ProductData;

  @override
  final homeController = Get.put(HomeController());
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        builder: (themeController) => AnnotatedRegion(
              value: themeController.systemUiOverlayStyleForwhite,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: themeController.bgcolor,
                  appBar: CustomAppBar(
                    showShop: true,
                    Title: '',
                    leading: Icons.arrow_back,
                    Ontapleading: () {
                      Navigator.pop(context);
                    },
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.screenPadding),
                    child: Column(children: [
                      SizedBox(
                        height: 30.sp,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ImageWidget(imageUrl: ProductData.image),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.sp,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      width: 200.sp,
                                      child: Text(
                                        ProductData.name,
                                        softWrap: true,
                                        maxLines: 1,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: themeController.textcolor,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100.sp,
                                      child: Text(
                                        '${Constants.currency} ${ProductData.Price.toString()}',
                                        softWrap: true,
                                        maxLines: 1,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: themeController.colorPrimary,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                if (DataStroge.userRole.value == 'USER')
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.sp),
                                    child: RoundButton(
                                      gradient: true,
                                      margin: 0,
                                      backgroundColor:
                                          themeController.colorPrimary,
                                      height: 30.sp,
                                      icon: 'assets/icons/shop.svg',
                                      title: 'Add To Cart',
                                      iconColor: themeController.colorwhite,
                                      textColor: themeController.colorwhite,
                                      onTap: () async {
                                        if (homeController
                                                .SelectedKidId.value !=
                                            0) {
                                          var cartData = CartModel(
                                              kidId: homeController
                                                  .SelectedKidId.value,
                                              parentId: 1,
                                              productId: ProductData.id,
                                              productName: ProductData.name,
                                              productImage: ProductData.image,
                                              kidName: homeController
                                                  .SelectedKidName.value,
                                                  productPrice: ProductData.Price.toString(),
                                              productIdsList:
                                                  homeController.CartList.map(
                                                      (e) => e.kidId).toList());

                                          var exists =
                                              homeController.CartList.where(
                                                  (e) =>
                                                      e.kidName ==
                                                          cartData.kidName &&
                                                      e.kidId ==
                                                          cartData.kidId &&
                                                      e.parentId ==
                                                          cartData.parentId &&
                                                      e.productId ==
                                                          cartData.productId);

                                          if (exists.isEmpty) {
                                            homeController.addAndRemoveCart(
                                                cartData, 1);
                                          } else {
                                            FlutterToastDisplay.getInstance
                                                .showToast(
                                                    "This Product is already exist");
                                          }
                                        } else {
                                          FlutterToastDisplay.getInstance.showToast(
                                              "Please select kid first from home screen");
                                        }
                                      },
                                    ),
                                  ),
                                SizedBox(
                                  height: 20.sp,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Description',
                                    softWrap: true,
                                    maxLines: 5,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                      color: themeController.textcolor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    ProductData.description,
                                    softWrap: true,
                                    maxLines: 5,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: themeController.textcolor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ]),
                  ),
                ),
              ),
            ));
  }
}
