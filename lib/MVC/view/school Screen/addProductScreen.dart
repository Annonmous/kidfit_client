import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/MVC/controller/homeController.dart';

import 'package:foodeoapp/MVC/controller/kidController.dart';
import 'package:foodeoapp/MVC/model/kidsModel.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';

import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/flutter_toast.dart';

import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/helper/internet_controller.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final internetController = Get.put(InternetController());
  final kidsController = Get.put(KidsController());
  final homeController = Get.put(HomeController());
  RxBool apihitting = false.obs;
  final NameController = TextEditingController();
  final FocusNode _NameFocusNode = FocusNode();
  final PriceController = TextEditingController();
  final FocusNode _PriceFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  final RxInt SelectedSchoolId = 0.obs;
  final RxString SelectedSchool = ''.obs;
  @override
  Widget build(BuildContext context) {
    homeController.getAllSchools();
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwhite,
        child: SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(
              Title: 'Add Product',
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
                        SizedBox(
                          height: 20.sp,
                        ),
                        SpringWidget(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(child: GetBuilder<ThemeHelper>(
                                    builder: (themecontroller) {
                                  return Container(
                                    height: 300.sp,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (homeController
                                              .schoolList.isNotEmpty)
                                            SizedBox(
                                              height: 30.sp,
                                            ),
                                          if (homeController
                                              .schoolList.isNotEmpty)
                                            Text(
                                              'Select School',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          if (homeController
                                              .schoolList.isNotEmpty)
                                            SizedBox(
                                              height: 30.sp,
                                            ),
                                          Obx(
                                            () => homeController
                                                    .schoolList.isEmpty
                                                ? Text(
                                                    'No School added yet..',
                                                    style: TextStyle(
                                                        color: themecontroller
                                                            .colorPrimary),
                                                  )
                                                : Container(
                                                    height: 200.sp,
                                                    child: ListView.builder(
                                                      itemCount: homeController
                                                          .schoolList.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return SpringWidget(
                                                          onTap: () {
                                                            SelectedSchoolId
                                                                    .value =
                                                                homeController
                                                                    .schoolList[
                                                                        index]
                                                                    .id;

                                                            SelectedSchool
                                                                    .value =
                                                                homeController
                                                                    .schoolList[
                                                                        index]
                                                                    .name;

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: ListTile(
                                                            title: Text(
                                                                homeController
                                                                    .schoolList[
                                                                        index]
                                                                    .name),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                          )
                                        ]),
                                  );
                                }));
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: ListTile(
                              title: Obx(
                                () => Text(
                                  SelectedSchool.value == ''
                                      ? 'Select School ..'
                                      : SelectedSchool.value,
                                  style: TextStyle(
                                      color: themecontroller.textcolor,
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomTextFieldWidget(
                          enabled: true,
                          label: '',
                          controller: PriceController,
                          fieldColor: themecontroller.colorwhite,
                          hintText: "Class No",
                          inputType: TextInputType.name,
                          focusNode: _PriceFocusNode,
                          onsubmit: () {},
                          onchange: (value) {
                            apihitting.value = false;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Class No';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.sp,
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
                                  if (internetController
                                          .isInternetConnected.value ==
                                      true) {
                                    apihitting.value = true;
                                    var kidData = KidsModel(
                                        id: 1,
                                        name: NameController.text,
                                        parentId: int.parse(
                                            DataStroge.currentUserId.value),
                                        schoolId: SelectedSchoolId.value,
                                        classNo: PriceController.text,
                                        image: '',
                                        createdAt: DateTime.now().toString(),
                                        updatedAt: DateTime.now().toString());
                                    kidsController.AddKids(context, kidData);
                                    
                                  } else {
                                    FlutterToastDisplay.getInstance.showToast(
                                        "Please check your internet");
                                  }
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
