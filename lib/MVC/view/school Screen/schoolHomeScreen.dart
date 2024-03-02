import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
    return GetBuilder<ThemeHelper>(
        initState: (state) async {
          searchFilter('');
          await homeController
              .getAllProductData(int.parse(DataStroge.currentUserId.value));
        },
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
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: stats_box(
                                Heading: 'Order',
                                Icon:
                                    SvgPicture.asset('assets/icons/order.svg'),
                                stats_value: '20',
                                color: themeController.colorPrimary
                                    .withOpacity(0.8),
                              ),
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Expanded(
                              flex: 1,
                              child: stats_box(
                                Heading: 'Total Sales',
                                Icon:
                                    SvgPicture.asset('assets/icons/sales.svg'),
                                stats_value: '20',
                                color: themeController.colorPrimary
                                    .withOpacity(0.8),
                              ),
                            ),
                          ],
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
                        SizedBox(
                          height: 10.sp,
                        ),
                        Obx(
                          () => GridView.builder(
                            primary: false,
                            shrinkWrap: true,
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
                      ]),
                    ),
                  ),
                ),
              ),
            ));
  }
}

class stats_box extends StatelessWidget {
  const stats_box({
    super.key,
    required this.Icon,
    required this.Heading,
    required this.stats_value,
    this.color,
  });
  final Widget Icon;
  final String Heading;
  final String stats_value;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: Icon),
              SizedBox(
                width: 10.sp,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  Heading,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            stats_value,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 18.sp),
          )
        ]),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            color: color ?? Colors.black,
            blurRadius: 2,
          )
        ],
      ),
    );
  }
}
