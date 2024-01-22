import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodeoapp/MVC/model/kidsModel.dart';
import 'package:foodeoapp/MVC/model/product_model.dart';
import 'package:foodeoapp/MVC/model/userModel.dart';
import 'package:foodeoapp/MVC/view/home/BottomNav.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/constant/flutter_toast.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:get/get.dart';
import '../helper/data_storage.dart';

class AppService {
  static AppService? _instance;
  static AppService get getInstance => _instance ??= AppService();

  late Dio dio;
  final _pref = DataStroge();

  AppService() {
    log("headerMap: ${DataStroge.getInstance.headersMap}");
    dio = Dio(
      BaseOptions(
        baseUrl: Constants.API_HOST,
        headers: DataStroge.getInstance.headersMap,
      ),
    );
    print("[AppService] ${DataStroge.getInstance.headersMap}");
  }
  void updateDioHeaders() {
    if (dio != null) {
      dio.options.headers = DataStroge.getInstance.headersMap;
    }
  }

  ///Login Function
  ///It requires:
  ///1) Context
  ///2) Email
  ///3) password
  Future<void> login(
      BuildContext context, String Email, String password) async {
    try {
      var response = await dio.post(Constants.PostLogin, data: {
        'email': Email,
        'password': password,
      });

      if (response.data['status']) {
        log("login API =>${response.data['status']}👌✅");
        final json = response.data;

        AuthResponse UserData = AuthResponse.fromJson(json);

        log("userEmail ${UserData.data.email}");
        log("username ${UserData.data.email}");
        await _pref.insertUserData(UserData.data, UserData.accessToken);
        FlutterToastDisplay.getInstance.showToast("Welcome To Kidfit");
        Navigation.getInstance
            .pagePushAndReplaceNavigation(context, BottomNavBar());
      } else {
        print('Unknown Error Occurred ${(response.data['message'])} ');
        FlutterToastDisplay.getInstance
            .showToast("${response.data['message']}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        FlutterToastDisplay.getInstance
            .showToast("${e.response!.data['message']}");
        print("Error msg data: ${e.response!.data['message']}");
      } else {
        print("Error sending data: $e");
      }
      print(e);
    }
  }

  ///Login Function
  ///It requires:
  ///1) Context
  ///2) User Object
  ///
  ///Return user object and OTP

  Future<void> registeration(BuildContext context, UserModel UserData) async {
    try {
      var response = await dio.post(Constants.PostRegister, data: {
        'name': UserData.name,
        'email': UserData.email,
        'password': UserData.password,
        'confirm_password': UserData.password,
        'userRole': UserData.userRole,
      });

      if (response.data['status']) {
        log("Registeration API =>${response.data['status']}👌✅");
        final json = response.data;

        AuthResponse UserData = AuthResponse.fromJson(json);

        log("userEmail: ${UserData.data.email}");

        Navigation.getInstance
            .pagePushAndReplaceNavigation(context, BottomNavBar());
        // FlutterToastDisplay.getInstance
        // .showToast("Your OTP is ${UserData.verificationcode}");
      } else {
        print('Unknown Error Occurred ${(response.data['message'])} ');
        FlutterToastDisplay.getInstance
            .showToast("${response.data['message']}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        FlutterToastDisplay.getInstance
            .showToast("${e.response!.data['message']}");
        print("Error msg data: ${e.response!.data['message']}");
      } else {
        print("Error sending data: $e");
      }
      print(e);
    }
  }

  Future<void> addKid(BuildContext context, KidsModel kidData) async {
    try {
      var response = await dio.post(Constants.PostRegister, data: {
        "name": kidData.name,
        "parentId": kidData.parentId,
        "schoolId": kidData.schoolId,
        "classNo": kidData.classNo
      });

      if (response.data['status']) {
        log("addKid API =>${response.data['status']}👌✅");
        final json = response.data;
        Navigator.pop(context);
      } else {
        print('Unknown Error Occurred ${(response.data['message'])} ');
        FlutterToastDisplay.getInstance
            .showToast("${response.data['message']}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        FlutterToastDisplay.getInstance
            .showToast("${e.response!.data['message']}");
        print("Error msg data: ${e.response!.data['message']}");
      } else {
        print("Error sending data: $e");
      }
      print(e);
    }
  }

  Future<void> addProduct(BuildContext context, KidsModel kidData) async {
    try {
      var response = await dio.post(Constants.PostRegister, data: {
        "name": kidData.name,
        "parentId": kidData.parentId,
        "schoolId": kidData.schoolId,
        "classNo": kidData.classNo
      });

      if (response.data['status']) {
        log("addKid API =>${response.data['status']}👌✅");
        final json = response.data;
        Navigator.pop(context);
      } else {
        print('Unknown Error Occurred ${(response.data['message'])} ');
        FlutterToastDisplay.getInstance
            .showToast("${response.data['message']}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        FlutterToastDisplay.getInstance
            .showToast("${e.response!.data['message']}");
        print("Error msg data: ${e.response!.data['message']}");
      } else {
        print("Error sending data: $e");
      }
      print(e);
    }
  }




  getAllProduct(int school_id) async {
    try {
      var response;
      response = await dio.get(Constants.GetAllProduct,
          options: Options(
            headers: {
              'Authorization': 'Bearer ${DataStroge.userToken}',
            },
          ),
          data: {
            'schoolId': school_id,
          });

      print("statusCode => " + response.statusCode.toString());
      print('getAllProduct API done 👌✅');
      print(response.data['message']);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List) {
          List<ProductModel> Datalist = (response.data as List)
              .map((data) => ProductModel.fromJson(data))
              .toList();

          return Datalist;
        } else if (responseData is Map) {
          List<ProductModel> Datalist = (responseData['message'] as List)
              .map((data) => ProductModel.fromJson(data))
              .toList();

          return Datalist;
        }
      }
    } on DioException catch (e) {
      print(e);
      FlutterToastDisplay.getInstance
          .showToast("${e.response!.data['message']}");
      return [];
    }
  }

  getAllChildrenByParentId() async {
    try {
      var response;
      response = await dio.get(Constants.getAllChild,
          options: Options(
            headers: {
              'Authorization': 'Bearer ${DataStroge.userToken}',
            },
          ),
          data: {
            'schoolId': '',
            'parentId': DataStroge.currentUserId,
          });

      print("statusCode => " + response.statusCode.toString());
      print('getAllProduct API done 👌✅');
      print(response.data['message']);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List) {
          List<KidsModel> Datalist = (response.data as List)
              .map((data) => KidsModel.fromJson(data))
              .toList();

          return Datalist;
        } else if (responseData is Map) {
          List<KidsModel> Datalist = (responseData['message'] as List)
              .map((data) => KidsModel.fromJson(data))
              .toList();

          return Datalist;
        }
      }
    } on DioException catch (e) {
      print(e);
      FlutterToastDisplay.getInstance
          .showToast("${e.response!.data['message']}");
      return [];
    }
  }

  getAllSchools() async {
    try {
      var response;
      response = await dio.get(
        Constants.GetAllSchool,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${DataStroge.userToken}',
          },
        ),
      );

      print("statusCode => " + response.statusCode.toString());
      print('getAllSchools API done 👌✅');
      print(response.data['message']);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List) {
          List<SchoolModel> Datalist = (response.data as List)
              .map((data) => SchoolModel.fromJson(data))
              .toList();

          return Datalist;
        } else if (responseData is Map) {
          List<SchoolModel> Datalist = (responseData['message'] as List)
              .map((data) => SchoolModel.fromJson(data))
              .toList();

          return Datalist;
        }
      }
    } on DioException catch (e) {
      print(e);
      FlutterToastDisplay.getInstance
          .showToast("${e.response!.data['message']}");
      return [];
    }
  }
}
