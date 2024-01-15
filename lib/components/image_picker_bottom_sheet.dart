import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/getx_helper.dart';
import 'package:get/get.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final bool forAddons;
  ImagePickerBottomSheet({
    Key? key,
    required this.forAddons,
  }) : super(key: key);
  @override

  /// it required two perm context and foraddons
  /// foraddons = true if will work for addons
  /// foraddons = false for normal uploading
  static Future show(BuildContext context, bool forAddons) {
    final themecontroller = Get.put(ThemeHelper());

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: themecontroller.bgcolor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      builder: (context) {
        return ImagePickerBottomSheet(
          forAddons: forAddons,
        );
      },
    );
  }

  final controllersProvider = Get.put(GetxControllersProvider());
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwhite,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
              // gradient: themecontroller.containerGradient,
              color: themecontroller.colorwhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 6,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Constants.screenPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                    Text(
                      "select image",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: themecontroller.textcolor,
                      ),
                    ),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Icon(
                            Icons.close,
                            color: themecontroller.disablecolor,
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.screenPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpringWidget(
                        onTap: () {
                          forAddons
                              ? controllersProvider.getFromCameraImage()
                              : controllersProvider
                                  .getFromCameraImageForAddons();
                        },
                        child: CircleAvatar(
                          radius: 30,
                          child: SvgPicture.asset("assets/icons/Camera.svg",
                              color: themecontroller.colorwhite
                              // width: 15,
                              ),
                          backgroundColor: themecontroller.colorPrimary,
                        ),
                      ),
                      SizedBox(
                        width: 30.sp,
                      ),
                      SpringWidget(
                        onTap: () {
                          forAddons
                              ? controllersProvider.getImage()
                              : controllersProvider.getImageForAddons();
                        },
                        child: CircleAvatar(
                          radius: 30,
                          child: SvgPicture.asset("assets/icons/upload.svg",
                              color: themecontroller.colorwhite
                              // width: 15,
                              ),
                          backgroundColor: themecontroller.colorPrimary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
