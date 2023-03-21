import 'package:get/get.dart';
import 'package:linpo_driver/app/modules/calendar/calendar_provider.dart';
import 'package:linpo_driver/helper/utils/common_functions.dart';
import 'package:linpo_driver/helper/utils/date_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  final calendarProvider = Get.put(CalendarProvider());

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  RxBool shoProgress = false.obs;
  RxList<CustomModelForCalendar> dateArray = <CustomModelForCalendar>[].obs;

  apiCallForCalendar() async {
    shoProgress.value = true;
    Map<String, dynamic> reqData = {
      "year": selectedDay.year.toString(),
      "month": selectedDay.month.toString()
    };
    final response = await calendarProvider.getCalendar(reqData);
    shoProgress.value = false;

    if (!isNullEmptyOrFalse(response)) {
      for (int i = 0; i < response['data'].length; i++) {
        if (response['data'][i]["pick_up_order"] != 0 ||
            response['data'][i]["delivery_order"] != 0) {
          dateArray.add(
            CustomModelForCalendar(
                dateTime: DateUtilities().getDateFromString(
                    response['data'][i]["date"],
                    formatter: DateUtilities.yyyy_mm_dd),
                isShow: true),
          );
        }
      }
      // print(response);
    }
    update();
  }

}

class CustomModelForCalendar {
  DateTime? dateTime = DateTime.now();
  bool? isShow = true;
  CustomModelForCalendar({this.dateTime, this.isShow});
}
