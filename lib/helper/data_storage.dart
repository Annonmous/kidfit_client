import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/app_service.dart';

class DataStroge extends GetxController {
  static DataStroge? _instance;
  static DataStroge get getInstance => _instance ??= DataStroge();
  late SharedPreferences _pref;

  late Map<String, dynamic> headersMap;

  Future<SharedPreferences> _initPrefs() async {
    _pref = await SharedPreferences.getInstance();
    return _pref;
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static RxString userName = ''.obs;
  static RxString userRole = ''.obs;
  static RxString userEmail = ''.obs;
  static RxString userDOB = ''.obs;
  static RxString userGender = ''.obs;
  static RxString userImage = ''.obs;
  static RxString userPhone = ''.obs;
  static RxString userToken = ''.obs;
  static RxString fcmToken = ''.obs;
  static RxString DeviceID = ''.obs;
  static RxString currentUserId = ''.obs;

  Future initiateSession() async {
    log("initiateSession called");
    await _initPrefs();
    headersMap = {
      'Authorization': 'Bearer ${_pref.getString('token')}',
    };

    AppService.getInstance.updateDioHeaders();
  }

  insertUserData({token, id, name, email, role, phone, image}) async {
    final SharedPreferences? prefs = await _prefs;

    await prefs?.setString('token', token);
    await prefs?.setString('id', id.toString());
    await prefs?.setString('name', name);
    await prefs?.setString('email', email);
    await prefs?.setString('phone_number', phone);
    await prefs?.setString('role', role);
    await prefs?.setString('image', image);
    await initiateSession();
    userName.value = name;
    userEmail.value = email;
    userImage.value = image;
    userRole.value = role;
    userPhone.value = phone;
    userToken.value = token;
    currentUserId.value = id.toString();
  }

  insertDeviceAndFCMInformation({FcmToken, deviceID}) async {
    final SharedPreferences? prefs = await _prefs;
    await prefs?.setString('fcmToken', FcmToken);
    await prefs?.setString('DeviceID', deviceID);

    fcmToken.value = FcmToken;
    DeviceID.value = deviceID;
  }

  Future setTokenAuth(String authToken) async {
    await _initPrefs();
    _pref.setString('token', authToken);
    await initiateSession();
    return true;
  }

  updateUserData({name, Phone, email, photo}) async {
    final SharedPreferences? prefs = await _prefs;

    if (photo != "") {
      await prefs?.setString('fullName', name);
      await prefs?.setString('email', email);
      await prefs?.setString('photo', photo);
      await prefs?.setString('phone_number', Phone);
      userName.value = name;
      userImage.value = photo;
      userEmail.value = email;
      userPhone.value = Phone;
    } else {
      await prefs?.setString('email', email);
      await prefs?.setString('fullName', name);
      await prefs?.setString('phone_number', Phone);
      userName.value = name;
      userEmail.value = email;
    }
  }

  getUserData() async {
    final SharedPreferences? prefs = await _prefs;
    userToken.value = prefs?.getString('token') ?? "";

    userName.value = prefs?.getString('name') ?? "";

    userEmail.value = prefs?.getString('email') ?? "";

    userImage.value = prefs?.getString('image') ?? "";

    userRole.value = prefs?.getString('role') ?? "";

    userPhone.value = prefs?.getString('phone_number') ?? "";

    currentUserId.value = prefs?.getString('id') ?? "";
  }

  logout() async {
    final SharedPreferences prefs = await _prefs;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await initiateSession();
    userRole.value = '';
    userName.value = '';
    userEmail.value = '';
    userImage.value = '';
    userPhone.value = '';
    userToken.value = '';
    currentUserId.value = '';
    // var tokenuser = prefs.getString('token') ?? "";
    log('Shared Preference Clear $userToken');
  }
}
