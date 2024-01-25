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
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  final homeController = Get.put(HomeController());

  final NameController = TextEditingController();
  final FocusNode _NameFocusNode = FocusNode();

  RxList<ProductModel> SearchProductList = <ProductModel>[].obs;

  void searchFilter(String search) {
    // SearchProductList.clear();
    if (search == '') {
      SearchProductList.value = homeController.ProductList;
    } else {
      SearchProductList.value = homeController.ProductList.where((product) =>
          product.name.toLowerCase().contains(search.toLowerCase())).toList();
    }
  }

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
                      child: Column(children: [
                        CustomTextFieldWidget(
                          enabled: true,
                          label: '',
                          controller: NameController,
                          fieldColor: themeController.colorwhite,
                          hintText: "Search Product..",
                          inputType: TextInputType.name,
                          focusNode: _NameFocusNode,
                          onsubmit: () {},
                          onchange: (value) {
                            searchFilter(value);
                          },
                        ),
                        Obx(
                          () => SearchProductList.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search_off,
                                          color: themeController.colorPrimary,
                                          size: 30.sp,
                                        ),
                                        Text(
                                          'No Product Found..',
                                          style: TextStyle(
                                              color:
                                                  themeController.colorPrimary,
                                              fontSize: 15.sp),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : Container(
                                  child: ListView.builder(
                                    itemCount: SearchProductList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var list = SearchProductList;
                                      return SearchproductCard(
                                          image: list[index].image,
                                          name: list[index].name,
                                          price: list[index].Price.toString(),
                                          restaurantImage: list[index].image);
                                    },
                                  ),
                                ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ));
  }
}
