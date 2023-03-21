// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/app/modules/calendar/calendar_controller.dart';
import 'package:linpo_driver/app/modules/orderDetails/all_order_controller.dart';
import 'package:linpo_driver/app/modules/orderDetails/all_order_screen.dart';
import 'package:linpo_driver/app/modules/plus/plus_controller.dart';

class OrderOfTheDayScreen extends StatefulWidget {
  const OrderOfTheDayScreen({Key? key}) : super(key: key);

  @override
  State<OrderOfTheDayScreen> createState() => _OrderOfTheDayScreenState();
}

class _OrderOfTheDayScreenState extends State<OrderOfTheDayScreen> {
  final formKey = GlobalKey<FormState>();

  final plusController = Get.put<PlusController>(PlusController());

  final allOrderController = Get.find<AllOrderController>();
  final CalendarController calendarController =
      Get.put<CalendarController>(CalendarController());

  @override
  void initState() {
    super.initState();

    calendarController.selectedDay = DateTime.now();
    // allOrderController.apiCallForGetOrderByDate();
  }

  @override
  Widget build(BuildContext context) {
    return const OrderDetailsScreen();
  }
}
