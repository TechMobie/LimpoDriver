//your bottombar screen

// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/app/modules/bottomBar/bottombar_controller.dart';
import 'package:linpo_driver/app/modules/dashboard/dashboard_screen.dart';
import 'package:linpo_driver/app/modules/plus/plus_screen.dart';
import 'package:linpo_driver/app/modules/calendar/calendar_screen.dart';
import 'package:linpo_driver/app/modules/routesScreen/routes_screen.dart';
import 'package:linpo_driver/helper/utils/images.dart';
import 'package:linpo_driver/schemata/text_style.dart';
import '../../../schemata/color_schema.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomBarScreen extends StatelessWidget {
  final bottomBarScreenController =
      Get.put<BottomBarController>(BottomBarController());
  var pageController = PageController(initialPage: 0);
//this is for bottombar pages list ...
  List<Widget> pageList = [
  const  DashBoardScreen(),
    const CalendarScreen(),
    const RoutesScreen(),
    const PlusScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.start,
        ),
      ),
      activeIcon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.start,
          color: ColorSchema.primaryColor,
        ),
      ),
      label: AppLocalizations.of(Get.context!)!.start,
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.calender,
        ),
      ),
      activeIcon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.calender,
          color: ColorSchema.primaryColor,
        ),
      ),
      label: AppLocalizations.of(Get.context!)!.calendar,
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.routes,
        ),
      ),
      activeIcon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.routes,
          color: ColorSchema.primaryColor,
        ),
      ),
      label: AppLocalizations.of(Get.context!)!.route,
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.plus,
        ),
      ),
      activeIcon: SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          ImageConstants.plus,
          color: ColorSchema.primaryColor,
        ),
      ),
      label: AppLocalizations.of(Get.context!)!.plus,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: bottomBarScreenController.currentIndex.value,
            children: pageList,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: bottomBarScreenController.currentIndex.value,
            onTap: (val) {
              bottomBarScreenController.currentIndex.value = val;
              bottomBarScreenController.update();
              // pageController.jumpToPage(val);
            },
            type: BottomNavigationBarType.fixed,
            items: bottomItems,
            selectedLabelStyle:
                const TextStyle().normal12.textColor(ColorSchema.primaryColor),
            selectedFontSize: 12,
            selectedItemColor: ColorSchema.primaryColor,
            unselectedItemColor: disableColor(context),
            selectedIconTheme:
                IconThemeData(color: Theme.of(context).toggleableActiveColor),
            unselectedIconTheme: IconThemeData(color: disableColor(context)),
          )),
    );
  }

  Color disableColor(BuildContext context) => Theme.of(context).disabledColor;
}
