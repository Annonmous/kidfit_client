import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/MVC/controller/homeController.dart';
import 'package:foodeoapp/MVC/controller/kidController.dart';
import 'package:foodeoapp/MVC/model/product_model.dart';
import 'package:foodeoapp/MVC/view/home/productDetailScreen.dart';
import 'package:foodeoapp/components/ProductCard.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';
import 'package:foodeoapp/components/drawer.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SchoolHomeScreen extends StatelessWidget {
  SchoolHomeScreen({super.key});

  @override
  final homeController = Get.put(HomeController());

  final NameController = TextEditingController();
  final FocusNode _NameFocusNode = FocusNode();

  RxList<ProductModel> SearchProductList = <ProductModel>[].obs;

  void searchFilter(String search) {
    // SearchProductList.clear();
    if (search.isEmpty) {
      SearchProductList.value = homeController.ProductList;
    } else {
      SearchProductList.value = homeController.ProductList.where((product) =>
          product.name.toLowerCase().contains(search.toLowerCase())).toList();
    }
  }

  Widget build(BuildContext context) {
    searchFilter('');
    homeController.getAllProductData(int.parse(DataStroge.currentUserId.value));
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
                        flex: 2,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.sp,
                            ),
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
                              itemCount: SearchProductList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var list = SearchProductList;
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
