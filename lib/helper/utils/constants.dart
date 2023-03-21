// ignore_for_file: constant_identifier_names

import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ApiConstants {
  static const baseURL = "http://limpoapp.cl/public/dev/"; //DEV
  // static const baseURL = "https://limpoapp.cl/"; //Prod

  static const String apiV1Url = baseURL + "api/driver/";
  //Authentication
  static const loginUrl = apiV1Url + "login";
  static const registerUrl = apiV1Url + "register";
  static const editProfileUrl = apiV1Url + "edit-profile";
  static const logoutUrl = apiV1Url + "logout";
  static const forgotPasswordUrl = apiV1Url + "forgot-password";              
  static const changePasswordUrl = apiV1Url + "change-password";                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
  static const lastLoginUrl = apiV1Url + "last-login";
  static const addDriverDailyEntry = apiV1Url + "add-driver-daily-entry";
  static const profileUrl = apiV1Url + "profile/";
  static const fcmRegisterToken = apiV1Url + "fcm/registration";

  //Calender
  static const getCalender = apiV1Url + "get-calender";

  //Order Details
  static const getOrderDetailsInfo = apiV1Url + "get-order-detail";
  static const changeOrderStatus = apiV1Url + "change-order-status";
  static const getAllOrderStatus = apiV1Url + "get-all-order-status";
  static const getOrderByDate = apiV1Url + "get-order-by-date";
  static const getDailyEntry = apiV1Url + "get-driver-daily-entry";
  static const addDailyEntry = apiV1Url + "add-driver-daily-entry";

  //Chat
  static const String getChatUserId = apiV1Url + "chat/user/";

  //Dashboard
  static const String dashBoard = apiV1Url + "dashboard";
}

String fcmToken = "";
Rx<Position> currentLatLog = Rx<Position>(
  Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 100,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 100),
);
