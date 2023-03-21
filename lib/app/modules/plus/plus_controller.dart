// ignore_for_file: avoid_print
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:linpo_driver/app/modules/plus/plus_provider.dart';
import 'package:linpo_driver/helper/utils/common_functions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../helper/utils/pref_utils.dart';
import '../../../schemata/color_schema.dart';
import '../../data/models/profile/profile_model.dart';

class PlusController extends GetxController {
  TextEditingController myFirstNameController = TextEditingController();
  FocusNode myFirstNameFocusNode = FocusNode();

  TextEditingController myLastNameController = TextEditingController();
  FocusNode myLastNameFocusNode = FocusNode();

  TextEditingController myEmailController = TextEditingController();
  FocusNode myEmailFocusNode = FocusNode();

  TextEditingController myPhoneNumberController = TextEditingController();
  FocusNode myPhoneNumberFocusNode = FocusNode();

  TextEditingController myRutController = TextEditingController();
  FocusNode myRutFocusNode = FocusNode();

  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordFocusNode = FocusNode();

  RxBool isFirstNameValid = true.obs;
  RxBool isLastNameValid = true.obs;
  RxBool isPhoneNumberValid = true.obs;
  RxBool isRutValid = true.obs;
  RxBool isEmailValid = true.obs;

  RxBool isFirstNameButtonValid = false.obs;
  RxBool isLastNameButtonValid = false.obs;
  RxBool isPhoneNumberButtonValid = false.obs;
  RxBool isRutButtonValid = false.obs;
  RxBool isEmailButtonValid = false.obs;
  RxBool isConfirmPasswordButtonValid = false.obs;

  RxBool isEditTransport = false.obs;
  RxBool isEditAccount = false.obs;
  RxBool isShowConfirmPassword = false.obs;
  RxBool isConfirmPasswordValid = true.obs;

  DateTime selectedDate = DateTime.now();

  TextEditingController brandController = TextEditingController();
  FocusNode brandFocusNode = FocusNode();

  TextEditingController modelController = TextEditingController();
  FocusNode modelFocusNode = FocusNode();

  TextEditingController yearController = TextEditingController();
  FocusNode yearFocusNode = FocusNode();

  TextEditingController patentController = TextEditingController();
  FocusNode patentFocusNode = FocusNode();

  TextEditingController abilityController = TextEditingController();
  FocusNode abilityFocusNode = FocusNode();

  TextEditingController externalController = TextEditingController();
  FocusNode externalFocusNode = FocusNode();

  TextEditingController drivingLicenceController = TextEditingController();
  FocusNode drivingLicenceFocusNode = FocusNode();

  TextEditingController safeImageController = TextEditingController();
  FocusNode safeImageFocusNode = FocusNode();

  RxBool isBrandValid = true.obs;
  RxBool isModelValid = true.obs;
  RxBool isYearValid = true.obs;
  RxBool isPatentValid = true.obs;
  RxBool isAbilityValid = true.obs;
  RxBool isExternalValid = true.obs;
  RxBool isDrivingLicenceValid = true.obs;
  RxBool isSafeImageValid = true.obs;
  RxBool isShowDrivingLicence = false.obs;
  RxBool isShowSafeImage = false.obs;

  TextEditingController kilometersController = TextEditingController();
  FocusNode kilometersFocusNode = FocusNode();

  TextEditingController fuelController = TextEditingController();
  FocusNode fuelFocusNode = FocusNode();

  TextEditingController licensePlateController = TextEditingController();
  FocusNode licensePlateFocusNode = FocusNode();

  RxBool isKilometersValid = true.obs;
  RxBool isFuelValid = true.obs;
  RxBool isLicensePlateValid = true.obs;

  TextEditingController oldPasswordController = TextEditingController();
  FocusNode oldPasswordFocusNode = FocusNode();

  TextEditingController newPasswordController = TextEditingController();
  FocusNode newPasswordFocusNode = FocusNode();

  RxBool isOldPasswordValid = true.obs;
  RxBool isNewPasswordValid = true.obs;
  RxBool isOldPasswordButtonValid = false.obs;
  RxBool isNewPasswordButtonValid = false.obs;

  RxBool isShowOldPassword = false.obs;
  RxBool isShowNewPassword = false.obs;

  RangeValues values = const RangeValues(1, 5);

  final plusProvider = Get.put(PlusProvider());

  ProfileModel profileModel = ProfileModel();

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

  Future<void> logoutApiCall() async {
    // CustomDialogs.getInstance.showProgressDialog();
    Map<String, dynamic> reqData = {};
    final response = await plusProvider.logoutUser(reqData);
    print(response);
    // CustomDialogs.getInstance.hideProgressDialog();
    if (response['success'] == true) {
      // Get.offAllNamed(
      //   Routes.signIn,
      // );
      PrefUtils.getInstance.clearLocalStorage();
    } else {
      showToast(
        msg: response['error'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    }
  }

  Future<void> editProfileApiCall() async {
    Map<String, dynamic> reqData = {
      "first_name": myFirstNameController.text,
      "last_name": myLastNameController.text,
      "email": myEmailController.text,
      "rut": myRutController.text,
      "mobile_country_code": "+56",
      "mobile_number": myPhoneNumberController.text
    };
    final response = await plusProvider.editProfileUser(reqData);
    if (response['success'] == false) {
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
      // if (response['error'].keys.toList()[0] == 'mobile_number') {
      //   showToast(
      //     msg: response['error']['mobile_number'][0].toString(),
      //     color: ColorSchema.redColor.withOpacity(0.3),
      //   );
      // } else {
      //   showToast(
      //     msg: response['error']['email'][0].toString(),
      //     color: ColorSchema.redColor.withOpacity(0.3),
      //   );
      // }
    } else {
      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.profile,
        response,
      );
      Get.back();
    }
  }

  Future<void> changePasswordApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();

    Map<String, dynamic> reqData = {
      "old_password": oldPasswordController.text,
      "new_password": newPasswordController.text
    };
    final response = await plusProvider.changePassword(reqData);

    if (response['success'] == false) {
      CustomDialogs.getInstance.hideProgressDialog();
      // if (response['error'].keys.toList()[0] == 'old_password') {
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      Get.back();
      CustomDialogs.getInstance.hideProgressDialog();

      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.primaryColor.withOpacity(0.3),
      );
    }
  }

  Future<void> addDriverDailyEntryApiCall() async {
    CustomDialogs.getInstance.showProgressDialog();
    Map<String, dynamic> reqData = {
      "km": kilometersController.text,
      "fuel": fuelController.text,
      "plat_number": licensePlateController.text
    };
    final response = await plusProvider.addDriverDailyEntry(reqData);
    if (response['success'] == false) {
      CustomDialogs.getInstance.hideProgressDialog();
      // if (response['error'].keys.toList()[0] == 'old_password') {
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      Get.back();
      CustomDialogs.getInstance.hideProgressDialog();
    }
    print(response);
  }

  Future<void> lastLoginApiCall() async {
    Map<String, dynamic> reqData = {
      "device_token": "123555777",
      "device_os": Platform.operatingSystem,
      "device_os_version": (Platform.isAndroid)
          ? androidInfo?.version.release ?? ""
          : iosInfo?.systemVersion ?? "",
      "device_model":
          (Platform.isAndroid) ? androidInfo?.model ?? "" : iosInfo?.model ?? ""
    };
    final response = await plusProvider.lastLogin(reqData);

    if (response['success'] == false) {
      showToast(
        msg: response['message'].toString(),
        color: ColorSchema.redColor.withOpacity(0.3),
      );
    } else {
      profileModel = ProfileModel.fromJson(response);
      PrefUtils.getInstance.writeData(
        PrefUtils.getInstance.profile,
        response,
      );
      update();
    }
    // print(response);
  }

  @override
  void onInit() async {
    super.onInit();

    // if(!SignInScreen.isGuestUser)
    if (PrefUtils.getInstance.isUserLogin()) {
      await getDeviceIdentifier();
      await getAppVersion();
      await lastLoginApiCall();
    }
  }
}
