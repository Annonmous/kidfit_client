import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/MVC/controller/kidController.dart';
import 'package:foodeoapp/MVC/view/kidsScreen/AddKidScreen.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/kidListTile.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/internet_controller.dart';
import 'package:get/get.dart';



class KidsListScreen extends StatelessWidget {
  KidsListScreen({super.key});

  final internetController = Get.put(InternetController());
  final kidsController = Get.put(KidsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
          value: themecontroller.systemUiOverlayStyleForwhite,
          child: SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(
                Title: 'Children List',
                showShop: false,
                leading: Icons.arrow_back,
                Ontapleading: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: themecontroller.bgcolor,
              resizeToAvoidBottomInset: false,
              floatingActionButton: SpringWidget(
                onTap: () {
                  Navigation.getInstance
                      .screenNavigation(context, AddKidScreen());
                },
                child: CircleAvatar(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    backgroundColor: themecontroller.colorPrimary,
                    radius: 30.sp),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Constants.screenPadding,
                    vertical: Constants.screenPadding),
                child: Obx(
                  () => kidsController.KidsList.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'No children Added yet..',
                                style: TextStyle(
                                    color: themecontroller.colorPrimary),
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: kidsController.KidsList.map((e) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.sp),
                                child: KidListTile(
                                  KidsData: e,
                                ),
                              )).toList()),
                ),
              ),
            ),
          ));
    });
  }
}
