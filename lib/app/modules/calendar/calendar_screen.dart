import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/app/modules/calendar/calendar_controller.dart';
import 'package:linpo_driver/app/routes/app_pages.dart';
import 'package:linpo_driver/helper/utils/common_functions.dart';
import 'package:linpo_driver/helper/utils/math_utils.dart';
import 'package:linpo_driver/schemata/color_schema.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../helper/utils/images.dart';
import '../../../helper/utils/pref_utils.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final calendarController = Get.put<CalendarController>(CalendarController());

  Map<DateTime, List<String>> selectedEvents = {};

  List<String> _getEventsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void initState() {
    super.initState();
    calendarController.apiCallForCalendar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.hello} ${PrefUtils.getInstance.readData(PrefUtils.getInstance.profileName)}!",
                    style: TextStyle(
                      color: ColorSchema.grey54Color,
                      fontWeight: FontWeight.w700,
                      fontSize: getSize(18),
                    ),
                  ),
                  SvgPicture.asset(
                    ImageConstants.appIcon,
                    width: 100,
                    height: 45,
                    color: ColorSchema.primaryColor,
                  ),
                  // Image.asset(
                  //   "assets/logo_color.png",
                  //   width: 100,
                  //   height: 45,
                  //   color: ColorSchema.greenColor,
                  // ),
                ],
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              Obx(
                () => (calendarController.shoProgress.value)
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorSchema.primaryColor,
                          ),
                        ),
                      )
                    : _calendarWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calendarWidget() {
    return GetBuilder(
      init: CalendarController(),
      builder: (controller) => TableCalendar(
        locale: "es", // Spanish, no country code
        availableGestures: AvailableGestures.horizontalSwipe,

        focusedDay: calendarController.selectedDay,
        firstDay: DateTime(2021),
        // firstDay: DateTime(DateTime.now().year, DateTime.now().month),

        lastDay: DateTime.now(),
        calendarFormat: calendarController.format,
        onFormatChanged: (CalendarFormat _format) {
          calendarController.format = _format;
          calendarController.update();
        },

        onPageChanged: (focusedDay) async {
          calendarController.selectedDay = focusedDay;
          CustomDialogs.getInstance.showProgressDialog();
          await calendarController.apiCallForCalendar();
          CustomDialogs.getInstance.hideProgressDialog();
        },

        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, events) {
            for (int i = 0; i < calendarController.dateArray.length; i++) {
              if (day.toString().contains(
                      calendarController.dateArray[i].dateTime.toString()) &&
                  calendarController.dateArray[i].isShow == true) {
                return Container(
                  margin: EdgeInsets.only(
                    top: getSize(10),
                    bottom: getSize(10),
                    left: getSize(6),
                    right: getSize(6),
                  ),
                  decoration: BoxDecoration(
                    color: ColorSchema.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                    border: (day == calendarController.selectedDay)
                        ? Border.all(color: ColorSchema.primaryColor, width: 3)
                        : const Border(),
                  ),
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(
                        color: const Color.fromRGBO(
                          252,
                          252,
                          253,
                          1,
                        ),
                        fontWeight: FontWeight.w700,
                        fontSize: getSize(22),
                      ),
                    ),
                  ),
                );
              }
              // return Container();
            }
            return null;
          },
          selectedBuilder: (context, day, focusedDay) {
            return Container(
              height: getSize(43),
              margin: EdgeInsets.only(
                top: getSize(8),
                bottom: getSize(8),
                left: getSize(5),
                right: getSize(5),
              ),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: ColorSchema.primaryColor, width: 3)),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    color: ColorSchema.black2Color,
                    fontWeight: FontWeight.w700,
                    fontSize: getSize(22),
                  ),
                ),
              ),
            );
          },
          defaultBuilder: (context, day, focusedDay) {
            return Container(
              height: getSize(43),
              margin: EdgeInsets.only(
                top: getSize(10),
                bottom: getSize(10),
                left: getSize(6),
                right: getSize(6),
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                // border: Border.all(
                //   color: ColorSchema.blackColor,
                // )
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    color: ColorSchema.black2Color,
                    fontWeight: FontWeight.w700,
                    fontSize: getSize(22),
                  ),
                ),
              ),
            );
          },
          singleMarkerBuilder: (context, day, event) => Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: day == calendarController.selectedDay
                    ? ColorSchema.whiteColor
                    : ColorSchema.primaryColor), //Change color
            width: 0.0,
            height: 0.0,
          ),
        ),
        daysOfWeekHeight: 40,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: ColorSchema.whiteColor,
            fontSize: getSize(17),
            fontWeight: FontWeight.w500,
          ),
          weekendStyle: TextStyle(
            color: ColorSchema.whiteColor,
            fontSize: getSize(17),
            fontWeight: FontWeight.w500,
          ),
          decoration: BoxDecoration(
            color: ColorSchema.primaryColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),

        //Day Changed
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          calendarController.selectedDay = selectDay;
          calendarController.focusedDay = focusDay;

          for (int i = 0; i < calendarController.dateArray.length; i++) {
            if (calendarController.selectedDay.toString().contains(
                    calendarController.dateArray[i].dateTime.toString()) &&
                calendarController.dateArray[i].isShow == true) {
              // _determinePosition();
              Get.toNamed(Routes.orderDetailsScreen);

              break;
            } else {
              calendarController.update();
            }
          }
          calendarController.update();
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(calendarController.selectedDay, date);
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        eventLoader: _getEventsFromDay,
        //To style the Calendar
        calendarStyle: CalendarStyle(
          tableBorder:
              TableBorder.all(color: ColorSchema.grey54Color, width: 1),
          defaultTextStyle: TextStyle(
            color: Colors.black,
            fontSize: getSize(22),
            fontWeight: FontWeight.w700,
          ),
          todayTextStyle: TextStyle(
              color: Colors.black,
              fontSize: getSize(22),
              fontWeight: FontWeight.w700),
          holidayTextStyle: TextStyle(
            color: const Color.fromRGBO(29, 41, 57, 1),
            fontSize: getSize(22),
            fontWeight: FontWeight.w700,
          ),
          weekendTextStyle: TextStyle(
            color: const Color.fromRGBO(29, 41, 57, 1),
            fontSize: getSize(50),
            fontWeight: FontWeight.w700,
          ),
          rangeEndTextStyle: TextStyle(
            // color: const Color.fromRGBO(29, 41, 57, 1),
            fontSize: getSize(22),
            fontWeight: FontWeight.w700,
          ),
          rangeStartTextStyle: TextStyle(
            color: ColorSchema.blackColor,
            fontSize: getSize(22),
            fontWeight: FontWeight.w500,
          ),
          withinRangeTextStyle: TextStyle(
            color: const Color.fromRGBO(29, 41, 57, 1),
            fontSize: getSize(22),
            fontWeight: FontWeight.w700,
          ),
          outsideTextStyle: TextStyle(
            color: Colors.grey,
            fontSize: getSize(22),
            fontWeight: FontWeight.w400,
          ),
          disabledTextStyle: TextStyle(
            color: Colors.grey,
            fontSize: getSize(22),
            fontWeight: FontWeight.w400,
          ),
          isTodayHighlighted: false,
          selectedDecoration: BoxDecoration(
            color: ColorSchema.greyColor,
            // shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: ColorSchema.primaryColor,
              width: 3,
            ),
          ),
          selectedTextStyle: TextStyle(
            color: const Color.fromRGBO(29, 41, 57, 1),
            fontSize: getSize(22),
            fontWeight: FontWeight.w700,
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
            color: ColorSchema.redColor,
          ),
        ),
        headerStyle: HeaderStyle(
          titleTextStyle: TextStyle(
            color: ColorSchema.primaryColor,
            fontSize: getSize(22),
            fontWeight: FontWeight.w600,
          ),
          titleCentered: true,
          formatButtonVisible: false,
          headerPadding: const EdgeInsets.all(0),
          headerMargin: EdgeInsets.only(top: getSize(30), bottom: getSize(20)),
          leftChevronMargin: EdgeInsets.only(
            left: getSize(5),
            bottom: getSize(0),
          ),
          rightChevronMargin: EdgeInsets.only(
            bottom: getSize(0),
            right: getSize(8),
          ),
          leftChevronPadding: const EdgeInsets.all(0),
          rightChevronPadding: const EdgeInsets.all(0),
        ),
      ),
    );
  }
}
