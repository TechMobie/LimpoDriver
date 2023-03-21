// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/app/data/models/order/all_order_model.dart';
import 'package:linpo_driver/app/modules/calendar/calendar_controller.dart';
import 'package:linpo_driver/app/modules/orderDetails/all_order_controller.dart';
import 'package:linpo_driver/app/modules/orderDetails/map_screen.dart';
import 'package:linpo_driver/app/routes/app_pages.dart';
import 'package:linpo_driver/components/button/button.dart';
import 'package:linpo_driver/components/common_class.dart';
import 'package:linpo_driver/helper/utils/constants.dart';
import 'package:linpo_driver/helper/utils/images.dart';
import 'package:linpo_driver/schemata/color_schema.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:linpo_driver/schemata/text_style.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final CalendarController calendarController = Get.find<CalendarController>();

  final AllOrderController allOrderController =
      Get.put<AllOrderController>(AllOrderController());
  @override
  void initState() {
    super.initState();
    allOrderController.currentIndex.value = 0;
    allOrderController.apiCallForGetOrderByDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CommonHeader(
              title: AppLocalizations.of(Get.context!)!.distance,
            ),
            filterWidget(),
            Obx(
              () => (allOrderController.noOrderFound.value)
                  ? Expanded(
                      child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            AppLocalizations.of(context)!.youHaveNoOrder,
                            style: const TextStyle()
                                .medium16
                                .textColor(ColorSchema.black2Color),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SvgPicture.asset(
                            ImageConstants.limpoTrack,
                            //  color: ColorSchema.primaryColor,
                          ),
                        ],
                      ),
                    ))
                  : (allOrderController.shoProgress.value)
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ColorSchema.primaryColor,
                            ),
                          ),
                        )
                      : Expanded(
                          child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                RefreshIndicator(
                                  onRefresh: () async {
                                    await allOrderController
                                        .apiCallForGetOrderByDate();
                                  },
                                  child: Obx(
                                    () => getOrderList().isEmpty
                                        ? Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 50,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .youHaveNoOrder,
                                                  style: const TextStyle()
                                                      .medium16
                                                      .textColor(ColorSchema
                                                          .black2Color),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                SvgPicture.asset(
                                                  ImageConstants.limpoTrack,
                                                  //  color: ColorSchema.primaryColor,
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListView.separated(
                                            // shrinkWrap: true,
                                            itemCount: (allOrderController
                                                        .currentIndex.value ==
                                                    0)
                                                ? allOrderController
                                                    .pickUpOrderList.length
                                                : (allOrderController
                                                            .currentIndex
                                                            .value ==
                                                        1)
                                                    ? allOrderController
                                                        .inProgressOrderList
                                                        .length
                                                    : allOrderController
                                                        .completedOrderList
                                                        .length,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  for (int i = 0;
                                                      i <
                                                          allOrderController
                                                              .getOrderStatusModel
                                                              .value
                                                              .data!
                                                              .length;
                                                      i++) {
                                                    if (allOrderController
                                                            .getOrderStatusModel
                                                            .value
                                                            .data![i]
                                                            .id ==
                                                        getOrderList()[index]
                                                            .orderStatusId) {
                                                      allOrderController
                                                              .orderStatusData
                                                              .value =
                                                          allOrderController
                                                              .getOrderStatusModel
                                                              .value
                                                              .data![i];

                                                      // if (pickUpStatusIds.contains(orderStatusData.value.id)) {
                                                      //   element.orderType = "Pick up";
                                                      // }
                                                      // if (pickUpStatusIds.contains(orderStatusData.value.id)) {
                                                      //   element.orderType = "Delivery";
                                                      // }
                                                    }
                                                  }
                                                  allOrderController.pickedImage
                                                      .value = File("");
                                                  Get.toNamed(
                                                      Routes
                                                          .orderDetailsInfoScreen,
                                                      arguments: getOrderList()[
                                                          index]);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: ColorSchema
                                                          .whiteColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: ColorSchema
                                                              .blackColor
                                                              .withOpacity(
                                                                  0.06),
                                                          offset: const Offset(
                                                              2, 2),
                                                          spreadRadius: 3,
                                                        )
                                                      ]),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5,
                                                                    bottom: 5,
                                                                    left: 10,
                                                                    right: 10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ColorSchema
                                                                  .whiteColor,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child: (getOrderList()[
                                                                        index]
                                                                    .isPickUpOrder)
                                                                ? Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .pickUpOrder,
                                                                    style: const TextStyle()
                                                                        .medium16
                                                                        .textColor(
                                                                            ColorSchema.blackColor),
                                                                  )
                                                                : Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .deliverOrder,
                                                                    style: const TextStyle()
                                                                        .medium16
                                                                        .textColor(
                                                                            ColorSchema.blackColor),
                                                                  ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      if (allOrderController
                                                              .currentIndex
                                                              .value !=
                                                          2)
                                                        kilometerAndTimeWidget(
                                                            context, index),
                                                      addressAndCallWidget(
                                                          index, context),
                                                      nameWidget(context, index)
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              height: 20,
                                            ),
                                          ),
                                  ),
                                ),
                                ((allOrderController.currentIndex.value == 0)
                                            ? allOrderController.pickUpOrderList
                                            : (allOrderController
                                                        .currentIndex.value ==
                                                    1)
                                                ? allOrderController
                                                    .inProgressOrderList
                                                : allOrderController
                                                    .completedOrderList)
                                        .isNotEmpty
                                    ? (allOrderController.currentIndex.value !=
                                            2)
                                        ? mapWidget(context)
                                        : Container()
                                    : Container(),
                              ]),
                        ),
            )
          ],
        ),
      ),
    ));
  }

  GestureDetector mapWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapMapScreen(
              allOrderList: [
                ...allOrderController.pickUpOrderList,
                ...allOrderController.inProgressOrderList
              ],
            ),
          ),
        );
      },
      child: Container(
        height: 55,
        // width: 100,
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: ColorSchema.primaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.map_outlined,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              AppLocalizations.of(context)!.viewInMap,
              style:
                  const TextStyle().medium16.textColor(ColorSchema.whiteColor),
            )
          ],
        ),
      ),
    );
  }

  Column nameWidget(BuildContext context, int index) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalizations.of(context)!.time}: "),
                Text(getOrderList()[index].pickupTime.toString()),
              ],
            ),
            // const Spacer(),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(getOrderList()[index].orderStatusName.toString()),
            ),
            // Text(getOrderList()[index].orderStatusId.toString()),
          ],
        )
      ],
    );
  }

  addressAndCallWidget(int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${AppLocalizations.of(Get.context!)!.serviceAreaName}: "),
                  Expanded(
                    child: Text(
                        (getOrderList()[index].userAddress?.serviceAreaName ??
                            "".toString()),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${AppLocalizations.of(Get.context!)!.addressLabel}: "),
                  Expanded(
                    child: Text(
                        (getOrderList()[index].userAddress?.addressLabel ??
                            "".toString()),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${AppLocalizations.of(Get.context!)!.direction}: "),
                  Expanded(
                    child: Text(
                        (getOrderList()[index].userAddress?.location ??
                            "".toString()),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("${AppLocalizations.of(Get.context!)!.addressNumber}: "),
                  Text(
                      ((getOrderList()[index].userAddress?.address ?? "")
                          .toString()),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${AppLocalizations.of(context)!.client}: "),
                  Text(
                      (getOrderList()[index].user?.firstName ?? "".toString()) +
                          " " +
                          (getOrderList()[index].user?.lastName ??
                              "".toString()),
                      style: const TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${AppLocalizations.of(context)!.whoWillReceived}: "),
                  Flexible(
                    child: Text(getOrderList()[index].whoWillReceive ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${AppLocalizations.of(context)!.description}: "),
                  Text(getOrderList()[index].comments ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 60,
          child: CommonAppButton(
            borderRadius: 5,
            color: ColorSchema.primaryColor,
            width: double.infinity,
            height: 40,
            style: const TextStyle().medium16.textColor(ColorSchema.whiteColor),
            text: AppLocalizations.of(context)!.call,
            onTap: () async {
              if (currentLatLog != null) {
                String url =
                    "${AppLocalizations.of(context)!.tel}: ${getOrderList()[index].user!.mobileNumber.toString()}";

                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              }
            },
            textColor: ColorSchema.whiteColor,
          ),
        ),
      ],
    );
  }

  Column kilometerAndTimeWidget(BuildContext context, int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.distance,
                ),
                Text(
                  getOrderList()[index].totalDistance +
                      " ${AppLocalizations.of(context)!.km}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(AppLocalizations.of(context)!.estimatedTime),
                Text(getOrderList()[index].totalDuration,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  SizedBox filterWidget() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: allOrderController.filterList.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 10,
          );
        },
        itemBuilder: (context, index) {
          return Obx(
            () => GestureDetector(
                onTap: () {
                  allOrderController.currentIndex.value = index;
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: (allOrderController.currentIndex.value == index)
                        ? ColorSchema.primaryColor
                        : ColorSchema.whiteColor,
                    border: Border.all(
                      color: (allOrderController.currentIndex.value == index)
                          ? Colors.transparent
                          : ColorSchema.blackColor,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      allOrderController.filterList[index],
                      style: const TextStyle().medium14.copyWith(
                          color:
                              (allOrderController.currentIndex.value == index)
                                  ? ColorSchema.whiteColor
                                  : ColorSchema.blackColor),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  List<OrderData> getOrderList() {
    return (allOrderController.currentIndex.value == 0)
        ? allOrderController.pickUpOrderList
        : (allOrderController.currentIndex.value == 1)
            ? allOrderController.inProgressOrderList
            : allOrderController.completedOrderList;
  }
}
