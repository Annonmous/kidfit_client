import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:get/get.dart';

import '../constant/theme.dart';

class CircleWithChild extends StatelessWidget {
  final String title;
  final Color? titlecolor;
  final String url;
  final bool? assets;
  final double? radius;
  final String? price;
  final bool isSelected; // Added isSelected property

  CircleWithChild({
    Key? key,
    required this.title,
    required this.url,
    this.price,
    this.titlecolor,
    this.assets = false,
    this.radius,
    this.isSelected = false, // Provide a default value
  });

  final themeController = Get.put(ThemeHelper());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeHelper());
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            assets == true
                ? CircleAvatar(
                    radius: radius == null ? 30 : radius,
                    backgroundColor: themeController.circlecolor,
                    // backgroundImage: AssetImage(url,),
                    child: Image.asset(url),
                  )
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isSelected
                          ? themeController.containerGradient
                          : themeController.backgroundGradient,
                      // color: isSelected
                      //     ? themeController
                      //         .colorPrimary // Change the background color when selected
                      //     : Colors
                      //         .transparent, // Remove the background color when not selected
                    ),
                    child: CircleAvatar(
                      backgroundColor: isSelected
                          ? themeController.colorPrimary
                          : themeController.circlecolor,
                      radius: radius == null ? 30 : radius,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: ImageWidget(
                              imageUrl: url,
                              height: 53.sp,
                              width: 53.sp,
                              boxfit: BoxFit.fill)),
                    ),
                  ),
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: titlecolor ?? themeController.textcolor,
                    fontSize: 10.sp),
              ),
            ),
            if (price != null && price != '')
              FittedBox(
                child: Text(
                  Constants.currency + price!,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: themeController.textcolor.withOpacity(0.7),
                      fontSize: 9.sp),
                ),
              )
          ],
        ),
      ),
    );
  }
}
