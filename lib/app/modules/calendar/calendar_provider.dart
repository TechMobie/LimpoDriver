import 'package:get/get.dart';
import 'package:linpo_driver/helper/utils/constants.dart';

import '../../data/services/api_service/api_service.dart';

class CalendarProvider extends GetxService {
  getCalendar(reqData) async {
    final response = await ApiService.postRequest(
      ApiConstants.getCalender,
      body: reqData,
    );
    return response;
  }
}
  