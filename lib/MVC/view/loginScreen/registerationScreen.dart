import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodeoapp/MVC/model/userModel.dart';
import 'package:foodeoapp/MVC/view/loginScreen/LoginWithEmailScreen.dart';
import 'package:foodeoapp/components/custom_textfiled.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:foodeoapp/services/app_service.dart';
import 'package:get/get.dart';
import '../../../components/round_button.dart';
import '../../../constant/flutter_toast.dart';
import '../../../helper/internet_controller.dart';

class RegisterationScreen extends StatelessWidget {
  RegisterationScreen({super.key});

  final internetController = Get.put(InternetController());

  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _ConfirmPasswordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  RxBool showpassword = false.obs;
  RxBool showConfirmpassword = false.obs;
  RxBool apihitting = false.obs;
  RxInt UserType = 1.obs;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForAuth,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.screenPadding),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SvgPicture.asset(
                            'assets/icons/foodeo.svg',
                            width: 70.sp,
                            height: 75.sp,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Constants.screenPadding),
                          child: Text(
                            'Watch, Order, Enjoy',
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: themecontroller.textcolor),
                          ),
                        ),
                        SizedBox(height: 5.sp),
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              CustomTextFieldWidget(
                                enabled: true,
                                label: 'Name',
                                controller: nameController,
                                hintText: "Enter Name",
                                inputType: TextInputType.name,
                                focusNode: _nameFocusNode,
                                onsubmit: () {},
                                onchange: (value) {
                                  apihitting.value = false;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an Name';
                                  }
                                  // const emailPattern =
                                  //     r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$';
                                  // if (!RegExp(emailPattern).hasMatch(value)) {
                                  //   return 'Please enter a valid email address';
                                  // }
                                  return null;
                                },
                              ),
                              // SizedBox(height: 12.sp),
                              // CustomTextFieldWidget(
                              //   enabled: true,
                              //   label: 'Phone Number',
                              //   controller: phoneController,
                              //   hintText: "Enter Phone Number",
                              //   inputType: TextInputType.phone,
                              //   focusNode: _phoneFocusNode,
                              //   onsubmit: () {},
                              //   onchange: (value) {
                              //     apihitting.value = true;
                              //   },
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Please enter an email address';
                              //     }
                              //     // const emailPattern =
                              //     //     r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$';
                              //     // if (!RegExp(emailPattern).hasMatch(value)) {
                              //     //   return 'Please enter a valid email address';
                              //     // }
                              //     return null;
                              //   },
                              // ),
                              SizedBox(height: 12.sp),
                              CustomTextFieldWidget(
                                enabled: true,
                                label: 'Email',
                                controller: emailController,
                                hintText: "Enter email",
                                inputType: TextInputType.emailAddress,
                                focusNode: _emailFocusNode,
                                onsubmit: () {},
                                onchange: (value) {
                                  apihitting.value = false;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email address';
                                  }
                                  const emailPattern =
                                      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$';
                                  if (!RegExp(emailPattern).hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 12.sp),
                              Obx(() => CustomTextFieldWidget(
                                    enabled: true,
                                    label: 'Confirm Password',
                                    controller: confirmPasswordController,
                                    hintText: "Enter password",
                                    inputType: TextInputType.visiblePassword,
                                    obscureText: showConfirmpassword.value,
                                    focusNode: _ConfirmPasswordFocusNode,
                                    onsubmit: () {},
                                    onchange: (value) {
                                      apihitting.value = false;
                                    },
                                    validator: (input) => input!.length < 3
                                        ? 'Please enter at least 3 characters'
                                        : input.length > 20
                                            ? 'Please enter only 20 characters'
                                            : null,
                                    suffixIcon: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        showpassword.value =
                                            !showpassword.value;
                                      },
                                      child: Icon(
                                        showpassword.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: themecontroller.textcolor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 12.sp),
                              Obx(() => CustomTextFieldWidget(
                                    enabled: true,
                                    label: 'Password',
                                    controller: PasswordController,
                                    hintText: "Enter password",
                                    inputType: TextInputType.visiblePassword,
                                    obscureText: showpassword.value,
                                    focusNode: _passwordFocusNode,
                                    onsubmit: () {},
                                    onchange: (value) {
                                      apihitting.value = false;
                                    },
                                    validator: (input) => input!.length < 3
                                        ? 'Please enter at least 3 characters'
                                        : input.length > 20
                                            ? 'Please enter only 20 characters'
                                            : null,
                                    suffixIcon: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        showpassword.value =
                                            !showpassword.value;
                                      },
                                      child: Icon(
                                        showpassword.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: themecontroller.textcolor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 20.sp),
                              Obx(() => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          UserType.value = 1;
                                        },
                                        child: Icon(
                                          UserType.value == 1
                                              ? Icons.check_circle_outline
                                              : Icons.circle_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Text(
                                        'Parent',
                                        style: TextStyle(
                                            color: themecontroller.colorPrimary,
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 30.sp,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          UserType.value = 0;
                                        },
                                        child: Icon(
                                          UserType.value == 0
                                              ? Icons.check_circle_outline
                                              : Icons.circle_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Text(
                                        'School',
                                        style: TextStyle(
                                            color: themecontroller.colorPrimary,
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.sp),
                        Obx(() => RoundButton(
                              gradient: true,
                              margin: 0,
                              backgroundColor: themecontroller.colorPrimary,
                              height: 60.sp,
                              loading: apihitting.value,
                              disabled: apihitting.value,
                              title: 'Register',
                              iconColor: themecontroller.colorwhite,
                              textColor: themecontroller.colorwhite,
                              onTap: () async {
                                await internetController.internetCheckerFun();

                                if (_formkey.currentState!.validate()) {
                                  // if (internetController
                                  //         .isInternetConnected.value ==
                                  //     true) {
                                  apihitting.value = true;
                                  var UserData = UserModel(
                                      id: 1,
                                      name: nameController.text,
                                      email: emailController.text,
                                      image: '',
                                      password: PasswordController.text,
                                      userRole: UserType.value == 1
                                          ? 'USER'
                                          : 'SCHOOL',
                                      createDate: DateTime.now().toString(),
                                      updateDate: DateTime.now().toString());
                                  AppService.getInstance
                                      .registeration(context, UserData);
                                  // } else {
                                  //   FlutterToastDisplay.getInstance.showToast(
                                  //       "Please check your internet");
                                  // }
                                }
                              },
                            )),
                        SizedBox(
                          height: 10.sp,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigation.getInstance.pagePushAndReplaceNavigation(
                                context, LoginWithEmail());
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                  color: themecontroller.textcolor
                                      .withOpacity(0.5),
                                  fontSize: 11.sp),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "if you already have account",
                                ),
                                TextSpan(
                                  text: ' login',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: themecontroller.colorPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
