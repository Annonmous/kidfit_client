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
    required this.kidId, required this.parentId, required this.schoolId,
  });
 final int kidId;
 final int parentId;
 final int schoolId;

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
                    child: Column(children: []),
                  ),
                ),
              ),
            ));
  }
}
