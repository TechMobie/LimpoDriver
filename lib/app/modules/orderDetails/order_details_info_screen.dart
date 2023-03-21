// ignore_for_file: invalid_use_of_visible_for_testing_member, deprecated_member_use, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linpo_driver/app/data/models/order/all_order_model.dart';
import 'package:linpo_driver/app/data/models/order/order_status_model.dart'
    as orderstatusmodeldata;
import 'package:linpo_driver/app/modules/orderDetails/all_order_controller.dart';
import 'package:linpo_driver/components/button/button.dart';
import 'package:linpo_driver/components/common_class.dart';
import 'package:linpo_driver/components/common_textfield.dart';
import 'package:linpo_driver/helper/utils/common_container.dart';
import 'package:linpo_driver/helper/utils/common_functions.dart';
import 'package:linpo_driver/helper/utils/constants.dart';
import 'package:linpo_driver/helper/utils/math_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_driver/schemata/color_schema.dart';
import 'package:linpo_driver/schemata/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsInfoScreen extends StatefulWidget {
  const OrderDetailsInfoScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsInfoScreen> createState() => _OrderDetailsInfoScreenState();
}

class _OrderDetailsInfoScreenState extends State<OrderDetailsInfoScreen> {
  final AllOrderController allOrderController = Get.find<AllOrderController>();
  ScrollController scrollController = ScrollController();

  OrderData data = OrderData();

  // final List<String> accountType = [
  //   'Educator',
  //   'School Administrator',
  //   'Parent'
  // ];

  @override
  void initState() {
    data = Get.arguments;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(15.0)),
          child: GestureDetector(
            onTap: () {
              allOrderController.commentFocusNode.unfocus();
            },
            child: Column(
              children: [
                SizedBox(
                  height: getSize(20),
                ),
                CommonHeader(
                  title: AppLocalizations.of(context)!.ordersDetails,
                ),
                Obx(
                  () => (isNullEmptyOrFalse(data.id ?? ""))
                      ? const CircularProgressIndicator(
                          color: ColorSchema.primaryColor,
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 30),
                                  width: MathUtilities.screenWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: ColorSchema.primaryColor)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(Get.context!)!
                                                .number,
                                            style: const TextStyle().medium19,
                                          ),
                                          const Spacer(),
                                          Text(
                                            AppLocalizations.of(Get.context!)!
                                                .condition,
                                            style: const TextStyle().medium19,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: getSize(10),
                                      ),
                                      numberAndConditionWidget(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          kiloMeterAndTimeWidget(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          addressAndCallWidget(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: getSize(20),
                                      ),
                                      cartDetailsWidget(),
                                      SizedBox(
                                        height: getSize(20),
                                      ),
                                      dropDownWidget(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Obx(
                                        () => Column(
                                          children: [
                                            if (allOrderController
                                                        .orderStatusData
                                                        .value
                                                        .id ==
                                                    15 ||
                                                allOrderController
                                                        .orderStatusData
                                                        .value
                                                        .id ==
                                                    6)
                                              Column(
                                                children: [
                                                  imageWidget(),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            if (allOrderController
                                                        .orderStatusData
                                                        .value
                                                        .id ==
                                                    5 ||
                                                allOrderController
                                                        .orderStatusData
                                                        .value
                                                        .id ==
                                                    14 ||
                                                allOrderController
                                                        .orderStatusData
                                                        .value
                                                        .id ==
                                                    15 ||
                                                allOrderController
                                                        .orderStatusData
                                                        .value
                                                        .id ==
                                                    6)
                                              Column(
                                                children: [
                                                  commentWidget(context),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              ),
                                            Center(
                                              child: CommonAppButton(
                                                  height: 40,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  text: AppLocalizations.of(
                                                          Get.context!)!
                                                      .submit,
                                                  onTap: () async {
                                                    allOrderController
                                                        .commentFocusNode
                                                        .unfocus();
                                                    CustomDialogs.getInstance
                                                        .showProgressDialog();
                                                    await allOrderController
                                                        .apiCallForChangeOrderStatus(
                                                            id: data.id
                                                                .toString());

                                                    await allOrderController
                                                        .apiCallForGetOrderByDate();
                                                    CustomDialogs.getInstance
                                                        .hideProgressDialog();
                                                  },
                                                  // width: 100,
                                                  style: const TextStyle()
                                                      .normal18
                                                      .textColor(ColorSchema
                                                          .whiteColor),
                                                  borderRadius: 5),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ([3, 12, 4, 13].contains(data.orderStatusId))
            ? CommonAppButton(
                text: AppLocalizations.of(Get.context!)!.startRoute,
                onTap: () async {
                  allOrderController.apiCallForGetDailyEntry(data: data);
                },
                width: double.infinity,
                style: const TextStyle()
                    .normal16
                    .textColor(ColorSchema.whiteColor),
                borderRadius: 5)
            : null,
      ),
    );
  }

  TextfieldContainer commentWidget(BuildContext context) {
    return TextfieldContainer(
      widget: CommonTextfield(
        isEditable: true,
        inputAction: TextInputAction.done,
        focusNode: allOrderController.commentFocusNode,
        textOption: TextFieldOption(
            formatter: [
              TextInputFormatter.withFunction((oldValue, newValue) => newValue),
            ],
            inputController: allOrderController.commentTextEditingController,
            keyboardType: TextInputType.name,
            labelText: AppLocalizations.of(context)!.comment,
            labelStyleText:
                const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
        clearIcon: false,
        validation: (val) {
          return val;
        },
        textCallback: (val) {
          return val;
        },
      ),
    );
  }

  InkWell imageWidget() {
    return InkWell(
      onTap: () async {
        await ImagePicker.platform
            .pickImage(source: ImageSource.camera)
            .then((value) {
          if (value != null) {
            allOrderController.pickedImage.value = File(value.path);
          }
        });
      },
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ColorSchema.grey54Color),
        ),
        child: (isNullEmptyOrFalse(allOrderController.pickedImage.value.path))
            ? const Center(
                child: Icon(Icons.camera_alt_outlined, size: 40),
              )
            : Image.file(
                allOrderController.pickedImage.value,
                fit: BoxFit.contain,
              ),
      ),
    );
  }

  Widget dropDownWidget() {
    if (!allOrderController.shoProgress.value) {
      return DropdownButton<orderstatusmodeldata.Data>(
        // Initial Value
        value: allOrderController.orderStatusData.value,
        isExpanded: true,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: (allOrderController.getOrderStatusModel.value.data!)
            .map((orderstatusmodeldata.Data items) {
          return DropdownMenuItem<orderstatusmodeldata.Data>(
            value: items,
            child: Text(
              items.orderStatus.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (orderstatusmodeldata.Data? newValue) {
          allOrderController.commentTextEditingController.clear();
          allOrderController.pickedImage.value = File("");
          allOrderController.orderStatusData.value = newValue!;
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          });
        },
      );
    } else {
      return Container();
    }
  }

  Column cartDetailsWidget() {
    if (data.userPlanId == 0) {
      return Column(
        children: [
          SizedBox(
            height: getSize(15),
          ),
          const Divider(
            thickness: 0.4,
            color: ColorSchema.black2Color,
          ),
          SizedBox(
            height: getSize(15),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.cartDetails?.length ?? 0,
            itemBuilder: (BuildContext context, int indexOfCartDetails) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        data.cartDetails?[indexOfCartDetails].productName
                                .toString() ??
                            "",
                        style: const TextStyle().normal16,
                      ),
                      const Spacer(),
                      Text(
                        'x ${data.cartDetails?[indexOfCartDetails].quantity.toString()}',
                        style: const TextStyle().normal16,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(5),
                  ),
                  Text(
                    AppLocalizations.of(context)!.bags,
                    style: const TextStyle()
                        .normal14
                        .textColor(ColorSchema.grey54Color),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: getSize(15),
              );
            },
          )
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: getSize(15),
          ),
          const Divider(
            thickness: 0.4,
            color: ColorSchema.black2Color,
          ),
          SvgPicture.network(data.userPlan?.planDetail?.image ?? ""),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.planName,
              ),
              Text(data.userPlan?.planDetail?.name ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("${AppLocalizations.of(context)!.description}: "),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(
                      data: data.userPlan?.planDetail?.description ?? "",
                      style: {
                        "p": Style(
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.bold),
                      }),
                ),
              ),
              // Text(data.userPlan?.planDetail?.description ?? "",
              //     style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      );
    }
  }

  addressAndCallWidget() {
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
                        (data.userAddress?.serviceAreaName ?? "".toString()),
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
                        (data.userAddress?.addressLabel ?? "".toString()),
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
                    child: Text((data.userAddress?.location ?? "".toString()),
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
                  Text(((data.userAddress?.address ?? "").toString()),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${AppLocalizations.of(Get.context!)!.client}: "),
                  Text(
                      (data.user?.firstName ?? "".toString()) +
                          " " +
                          (data.user?.lastName ?? "".toString()),
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
                    child: Text(data.whoWillReceive ?? "",
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
                  Text(data.comments ?? "",
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
            style: const TextStyle().normal16.textColor(ColorSchema.whiteColor),
            height: 40,
            text: AppLocalizations.of(Get.context!)!.call,
            onTap: () async {
              if (currentLatLog != null) {
                String url =
                    "${AppLocalizations.of(Get.context!)!.tel}: ${data.user!.mobileNumber.toString()}";

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

  Row kiloMeterAndTimeWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(Get.context!)!.distance,
            ),
            Text(
                data.totalDistance +
                    " ${AppLocalizations.of(Get.context!)!.km}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              AppLocalizations.of(Get.context!)!.estimatedTime,
            ),
            Text(data.totalDuration,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Row numberAndConditionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            data.orderStatus?[0].orderId.toString() ?? "",
            style:
                const TextStyle().medium19.textColor(ColorSchema.grey54Color),
          ),
        ),
        // const Spacer(),
        Flexible(
          flex: 2,
          child: Text(
            allOrderController.orderStatusData.value.orderStatus.toString(),
            style:
                const TextStyle().medium19.textColor(ColorSchema.grey54Color),
          ),
        ),
      ],
    );
  }
}
