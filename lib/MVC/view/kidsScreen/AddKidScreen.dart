import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:foodeoapp/MVC/controller/kidController.dart';
import 'package:foodeoapp/MVC/model/kidsModel.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';

import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/constant/constants.dart';

import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/internet_controller.dart';
import 'package:get/get.dart';

class AddKidScreen extends StatelessWidget {
  AddKidScreen({super.key});

  final internetController = Get.put(InternetController());
  final kidsController = Get.put(KidsController());
  RxBool apihitting = false.obs;
  final NameController = TextEditingController();
  final FocusNode _NameFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwhite,
        child: SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(
              Title: 'Add Children',
              showShop: false,
              leading: Icons.arrow_back,
              Ontapleading: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: themecontroller.bgcolor,
            resizeToAvoidBottomInset: false,
            body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Constants.screenPadding,
                    vertical: Constants.screenPadding),
                child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextFieldWidget(
                          enabled: true,
                          label: '',
                          controller: NameController,
                          fieldColor: themecontroller.colorwhite,
                          hintText: "Enter Name",
                          inputType: TextInputType.name,
                          focusNode: _NameFocusNode,
                          onsubmit: () {},
                          onchange: (value) {
                            apihitting.value = false;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an Name';
                            }

                            return null;
                          },
                        ),
                        Obx(() => RoundButton(
                              gradient: true,
                              margin: 0,
                              backgroundColor: themecontroller.colorPrimary,
                              height: 60.sp,
                              loading: apihitting.value,
                              disabled: apihitting.value,
                              title: 'Add',
                              iconColor: themecontroller.colorwhite,
                              textColor: themecontroller.colorwhite,
                              onTap: () async {
                                await internetController.internetCheckerFun();

                                if (_formkey.currentState!.validate()) {
                                  // if (internetController
                                  //         .isInternetConnected.value ==
                                  //     true) {
                                  apihitting.value = true;
                                  if (kidsController.KidsList.isEmpty) {
                                    var kidData = KidsModel(
                                        id: 1,
                                        name: NameController.text,
                                        parentId: 1,
                                        schoolId: 1,
                                        schoolName: 'schoolName',
                                        createDate: DateTime.now(),
                                        updateDate: DateTime.now());
                                    kidsController.AddKids(kidData);
                                    Navigator.pop(context);
                                  } else {
                                    var kidData = KidsModel(
                                        id: kidsController.KidsList.length,
                                        name: NameController.text,
                                        parentId: 1,
                                        schoolId: 1,
                                        schoolName: 'schoolName',
                                        createDate: DateTime.now(),
                                        updateDate: DateTime.now());
                                    kidsController.AddKids(kidData);
                                    Navigator.pop(context);
                                  }
                                  // controller.loginWithEmail(
                                  //     context,
                                  //     controller.emailController.value.text,
                                  //     controller.passwordController.value.text);
                                  // } else {
                                  //   FlutterToastDisplay.getInstance
                                  //       .showToast("Please check your internet");
                                  // }
                                }
                              },
                            )),
                      ],
                    ))),
          ),
        ),
      );
    });
  }
}
