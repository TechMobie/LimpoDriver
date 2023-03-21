import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:linpo_driver/app/data/services/api_service/api_service.dart';
import 'package:linpo_driver/helper/utils/constants.dart';

class BottombarProvider extends GetxService {
  dashBoardApiCall() async {
    final response = await ApiService.postRequest(ApiConstants.dashBoard);
    return response;
  }
}
