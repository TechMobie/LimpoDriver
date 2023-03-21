import 'package:get/get.dart';

import '../../../helper/utils/constants.dart';
import '../../data/services/api_service/api_service.dart';

class PlusProvider extends GetxService {

  logoutUser(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.logoutUrl,
      body: reqData,
    );
    return response;
  }

  editProfileUser(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.editProfileUrl,
      body: reqData,
    );
    return response;
  }

  changePassword(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.changePasswordUrl,
      body: reqData,
    );
    return response;
  }

  addDriverDailyEntry(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.addDriverDailyEntry,
      body: reqData,
    );
    return response;
  }


  lastLogin(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.lastLoginUrl,
      body: reqData,
    );
    return response;
  }

 
}









