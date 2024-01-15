import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchproductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String restaurantImage;

  const SearchproductCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.restaurantImage,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
      builder: (themeController) => AnnotatedRegion(
        value: themeController.systemUiOverlayStyleForwhite,
        child: SpringWidget(
          onTap: () {
            // Navigation.getInstance.RightToLeft_PageNavigation(context, ProductDetailScreen(productId: productId, reelId: reelId))
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: themeController.colorwhite,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ImageWidget(
                          imageUrl: image,
                          height: 90.sp,
                          width: 80.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        color: themeController.textcolor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: themeController.colorPrimary,
                                radius: 10.sp,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: ImageWidget(
                                      imageUrl: restaurantImage,
                                      height: 30,
                                      width: 30,
                                    )),
                              ),
                            ],
                          ),
                       
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
