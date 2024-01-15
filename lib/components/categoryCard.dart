import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/theme.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class categorybtn extends StatelessWidget {
  final String name;
  final String image;
  final Color? Colors;
  final Color? textColors;
  final Function() onTap;
  categorybtn({
    super.key,
    required this.name,
    required this.image,
    required this.onTap,
    this.Colors,
    this.textColors,
  });

  @override
  Widget build(BuildContext context) {
    return SpringWidget(
      onTap: onTap,
      child: GetBuilder<ThemeHelper>(
        builder: (themeController) => AnnotatedRegion(
          value: themeController.systemUiOverlayStyleForwhite,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 1, color: themeController.colorPrimary),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors ?? themeController.colorwhite.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: textColors ?? themeController.textcolor,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
          ).paddingSymmetric(horizontal: 5),
        ),
      ),
    );
  }
}
