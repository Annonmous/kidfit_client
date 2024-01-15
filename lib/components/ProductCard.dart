import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class productcard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String SchoolImage;

  productcard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.SchoolImage,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
      builder: (themeController) => AnnotatedRegion(
        value: themeController.systemUiOverlayStyleForwhite,
        child: Container(
          width: 200.sp,
          height: 230.sp,
          decoration: BoxDecoration(
              color: themeController.colorwhite,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ImageWidget(
                          imageUrl: image,
                          width: double.infinity,
                          height: double.infinity,
                        ))),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Constants.currency} $price',
                            style: TextStyle(
                                color: themeController.colorPrimary,
                                fontSize: 10.sp),
                          ),
                          CircleAvatar(
                            backgroundColor: themeController.colorPrimary,
                            radius: 10.sp,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: ImageWidget(
                                  imageUrl: SchoolImage,
                                  height: 30,
                                  width: 30,
                                )),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
