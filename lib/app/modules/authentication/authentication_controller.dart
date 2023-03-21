// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../helper/utils/common_functions.dart';
import '../../../helper/utils/constants.dart';
import '../../../helper/utils/pref_utils.dart';
import '../../../schemata/color_schema.dart';
import '../../routes/app_pages.dart';
import 'auth_provider.dart';

class AuthenticationController extends GetxController {
  TextEditingController emailSignInController = TextEditingController();
  FocusNode emailSignInFocusNode = FocusNode();
  TextEditingController passwordSignInController = TextEditingController();
  FocusNode passwordSignInFocusNode = FocusNode();

  TextEditingController emailForgotController = TextEditingController();
  FocusNode emailForgotFocusNode = FocusNode();

  RxBool isSignInEmailValid = true.obs;
  RxBool isSignInPasswordValid = true.obs;
  RxBool isSignInEmailButtonValid = false.obs;
  RxBool isSignInPasswordButtonValid = false.obs;

  RxBool isForgotEmailValid = true.obs;
  RxBool isForgotEmailButtonValid = false.obs;

  final authProvider = Get.put(AuthProvider());

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  PackageInfo? packageInfo;
  IosDeviceInfo? iosInfo;
  AndroidDeviceInfo? androidInfo;

  getAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo!.version);
  }

//this is for you can get anydevices identifier like  a which is a device model,os etc.
  getDeviceIdentifier() async {
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      print(androidInfo!.model);
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
      print(iosInfo!.systemVersion);
      print(iosInfo!.model);
    }
  }

  Future<void> logInApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();
    Map<String, dynamic> reqData = {
      "email": emailSignInController.text,
      "password": passwordSignInController.text,
      "device_token": fcmToken,
      "device_os": Platform.operatingSystem,
      "device_os_version": (Platform.isAndroid)
          ? androidInfo?.version.release ?? ""
          : iosInfo?.systemVersion ?? "",
      "device_model":
          (Platform.isAndroid) ? androidInfo?.model ?? "" : iosInfo?.model ?? ""
    };
    final response = await authProvider.loginUser(reqData);
    print(response);
    CustomDialogs.getInstance.hideProgressDialog();
    // print(response['data']['user_session_token']);
    if (response['success'] == false) {
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.profileName,
        response['data']['first_name'],
      );
      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.accessToken,
        response['data']['user_session_token'],
      );
      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.profile,
        response,
      );
      Get.offAndToNamed(
        Routes.bottomBarScreen,
      );
    }
  }

  Future<void> forgotPasswordApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {"email": emailForgotController.text};
    final response = await authProvider.forgotPasswordUser(reqData);

    CustomDialogs.getInstance.hideProgressDialog();
    print(response);
    if (response['success'] == false) {
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      Get.back();
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.primaryColor.withOpacity(0.3),
      );
    }
  }

  // Future<void> signUpApiCall() async {
  //   Map<String, dynamic> reqData = {
  //     "first_name": firstNameSignUpController.text,
  //     "last_name": lastNameSignUpController.text,
  //     "email": emailSignUpController.text,
  //     "password": passwordSignUpController.text,
  //     "device_token": fcmToken,
  //     "device_os": Platform.operatingSystem,
  //     "device_os_version": (Platform.isAndroid)
  //         ? androidInfo?.version.release ?? ""
  //         : iosInfo?.systemVersion ?? "",
  //     "device_model":
  //     (Platform.isAndroid) ? androidInfo?.model ?? "" : iosInfo?.model ?? ""
  //   };
  //   final response = await authProvider.signUpUser(reqData);
  //   print(response);
  // }

  @override
  void onInit() {
    getDeviceIdentifier();
    getAppVersion();
    super.onInit();
    if (kDebugMode) {
      emailSignInController.text = "purvghori171@gmail.com";
      passwordSignInController.text = "12345678";
    }
  }
}
