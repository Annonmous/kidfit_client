import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/MVC/controller/homeController.dart';

import 'package:foodeoapp/MVC/controller/kidController.dart';
import 'package:foodeoapp/MVC/model/kidsModel.dart';
import 'package:foodeoapp/MVC/model/product_model.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';

import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/flutter_toast.dart';

import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/helper/getx_helper.dart';
import 'package:foodeoapp/helper/internet_controller.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final internetController = Get.put(InternetController());

  final homeController = Get.put(HomeController());
  final getcontroller = Get.put(GetxControllersProvider());
  RxBool apihitting = false.obs;
  final NameController = TextEditingController();
  final FocusNode _NameFocusNode = FocusNode();
  final PriceController = TextEditingController();
  final FocusNode _PriceFocusNode = FocusNode();
  final descriptionController = TextEditingController();
  final FocusNode _DescriptionFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  final RxInt SelectedSchoolId = 0.obs;
  final RxString SelectedSchool = ''.obs;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        initState: (state) {},
        builder: (themecontroller) {
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
                            Obx(
                              () => SpringWidget(
                                onTap: () {
                                  getcontroller.getImage();
                                },
                                child: getcontroller.imagePath.value.isNotEmpty
                                    ? Container(
                                        height: 200.sp,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(File(
                                                  getcontroller
                                                      .imagePath.value)),
                                            )),
                                      )
                                    : Container(
                                        height: 200.sp,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(getcontroller
                                                  .defaultImagePath
                                                  .toString()),
                                            )),
                                      ),
                              ),
                            ),
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
                            CustomTextFieldWidget(
                              enabled: true,
                              label: '',
                              controller: PriceController,
                              fieldColor: themecontroller.colorwhite,
                              hintText: "Price",
                              inputType: TextInputType.number,
                              focusNode: _PriceFocusNode,
                              onsubmit: () {},
                              onchange: (value) {
                                apihitting.value = false;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Price';
                                }

                                return null;
                              },
                            ),
                            CustomTextFieldWidget(
                              enabled: true,
                              label: '',
                              controller: descriptionController,
                              fieldColor: themecontroller.colorwhite,
                              hintText: "Description",
                              maxLines: 3,
                              inputType: TextInputType.name,
                              focusNode: _DescriptionFocusNode,
                              onsubmit: () {},
                              onchange: (value) {
                                apihitting.value = false;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Description';
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
                                  title: 'Add Product',
                                  iconColor: themecontroller.colorwhite,
                                  textColor: themecontroller.colorwhite,
                                  onTap: () async {
                                    await internetController
                                        .internetCheckerFun();

                                    if (_formkey.currentState!.validate()) {
                                      if (getcontroller.imagePath.value != '') {
                                        if (internetController
                                                .isInternetConnected.value ==
                                            true) {
                                          apihitting.value = true;
                                          var Data = ProductModel(
                                              id: 1,
                                              name: NameController.text,
                                              schoolId: int.parse(DataStroge
                                                  .currentUserId.value),
                                              image:
                                                  getcontroller.imagePath.value,
                                              description:
                                                  descriptionController.text,
                                              createDate: DateTime.now(),
                                              updateDate: DateTime.now(),
                                              Price: int.parse(
                                                  PriceController.text));
                                          homeController.AddProduct(
                                              context, Data);
                                          getcontroller.imagePath.value = '';
                                        } else {
                                          FlutterToastDisplay.getInstance
                                              .showToast(
                                                  "Please check your internet");
                                        }
                                      } else {
                                        FlutterToastDisplay.getInstance
                                            .showToast(
                                                "Please Add Product image");
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
