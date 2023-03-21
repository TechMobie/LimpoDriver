import 'package:get/get.dart';
import 'package:linpo_driver/helper/utils/constants.dart';

import '../../data/services/api_service/api_service.dart';

class AllOrderProvider extends GetxService {
  getOrderByDate(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.getOrderByDate,
      body: reqData,
    );
    return response;
  }

  getOrderDetailInfo(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.getOrderDetailsInfo,
      body: reqData,
    );
    return response;
  }

  getAllOrderStatus(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.getAllOrderStatus,
      body: reqData,
    );
    return response;
  }

  getChangeOrderStatus(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.changeOrderStatus,
      body: reqData,
    );
    return response;
  }

  getDailyEntry(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.getDailyEntry,
      body: reqData,
    );
    return response;
  }

  addDailyEntry(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.addDailyEntry,
      body: reqData,
    );
    return response;
  }
}
