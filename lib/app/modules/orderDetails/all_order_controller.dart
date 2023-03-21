// ignore_for_file: avoid_print, deprecated_member_use, unused_local_variable, unnecessary_null_comparison
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:linpo_driver/app/data/models/directions_model.dart';
import 'package:linpo_driver/app/data/models/order/all_order_model.dart';
import 'package:linpo_driver/app/data/models/order/order_status_model.dart';
import 'package:linpo_driver/app/data/models/order/order_status_model.dart'
    as orderstatusdata;
import 'package:linpo_driver/app/modules/calendar/calendar_controller.dart';
import 'package:linpo_driver/app/modules/orderDetails/all_order_provider.dart';
import 'package:linpo_driver/components/button/button.dart';
import 'package:linpo_driver/components/common_class.dart';
import 'package:linpo_driver/components/common_textfield.dart';
import 'package:linpo_driver/helper/utils/common_container.dart';
import 'package:linpo_driver/helper/utils/common_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_driver/helper/utils/constants.dart';
import 'package:linpo_driver/helper/utils/images.dart';
import 'package:linpo_driver/helper/utils/math_utils.dart';
import 'package:linpo_driver/helper/utils/pref_utils.dart';
import 'package:linpo_driver/schemata/color_schema.dart';
import 'package:linpo_driver/schemata/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class AllOrderController extends GetxController {
  FocusNode commentFocusNode = FocusNode();
  TextEditingController commentTextEditingController = TextEditingController();
  TextEditingController kilometersController = TextEditingController();
  FocusNode kilometersFocusNode = FocusNode();

  TextEditingController fuelController = TextEditingController();
  FocusNode fuelFocusNode = FocusNode();

  TextEditingController licensePlateController = TextEditingController();
  FocusNode licensePlateFocusNode = FocusNode();
  Rx<File> pickedImage = Rx<File>(File(""));

  List pickUpStatusIds = [3, 4, 5, 6, 7];
  List deliveryStatusIds = [12, 13, 14, 15];
  List filterList = [
    AppLocalizations.of(Get.context!)!.remaining,
    AppLocalizations.of(Get.context!)!.inProgress,
    AppLocalizations.of(Get.context!)!.completed
  ];
  RxInt currentIndex = 0.obs;
  final allOrderProvider = Get.put(AllOrderProvider());
  final CalendarController calendarController = Get.find<CalendarController>();
  Rx<GetAllOrderModel> getAllOrderModel =
      Rx<GetAllOrderModel>(GetAllOrderModel());
  Rx<GetOrderStatusModel> getOrderStatusModel =
      Rx<GetOrderStatusModel>(GetOrderStatusModel());
  RxBool noOrderFound = false.obs;
  RxBool shoProgress = false.obs;
  DirectionsModel? directionsModel;
  RxList<OrderData> allOrderList = <OrderData>[].obs;
  RxList<OrderData> pickUpOrderList = <OrderData>[].obs;
  RxList<OrderData> completedOrderList = <OrderData>[].obs;
  RxList<OrderData> inProgressOrderList = <OrderData>[].obs;
  RxBool shoProgressForOrderInfo = false.obs;
  bool isKilometersValid = true;
  bool isFuelValid = true;
  bool isLicensePlateValid = true;

  RxBool isEdit = false.obs;
  double sliderValue = 1.0;
  Rx<orderstatusdata.Data> orderStatusData =
      Rx<orderstatusdata.Data>(orderstatusdata.Data());
  var formKey = GlobalKey<FormState>();
  dio.Dio call = dio.Dio();

  apiCallForGetDistance({required String lat, required String long}) async {
    print(lat);
    print(long);
    String baseUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${currentLatLog.value.latitude},${currentLatLog.value.longitude}&destination=$lat,$long&key=AIzaSyB5RWJRL77Ztz_1ipyP0OPH8W3ksbjJtig";
    final response = await call.get(baseUrl);
    if (response.statusCode == 200) {
      if (response.data['status'] != "ZERO_RESULTS") {
        directionsModel = DirectionsModel.fromMap(response.data);
        print(directionsModel!.totalDistance);
      }
    }
  }

  apiCallForGetDailyEntry({required OrderData data}) async {
    CustomDialogs.getInstance.showProgressDialog();
    final response = await allOrderProvider.getDailyEntry({});
    CustomDialogs.getInstance.hideProgressDialog();

    if (!isNullEmptyOrFalse(response)) {
      print(response);
      if (response["data"] == null) {
        isLicensePlateValid = true;
        isKilometersValid = true;
        isFuelValid = true;
        sliderValue = 1;
        licensePlateController.clear();

        kilometersController.clear();

        showDialog(
            context: Get.context!,
            useSafeArea: false,
            builder: (_) {
              return Dialog(
                insetPadding: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: StatefulBuilder(
                      builder: (context, setState1) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CommonHeader(
                            title: AppLocalizations.of(Get.context!)!.goToRoute,
                            headerStyle: const TextStyle().medium20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextfieldContainer(
                            widget: CommonTextfield(
                              inputAction: TextInputAction.next,
                              focusNode: kilometersFocusNode,
                              textOption: TextFieldOption(
                                inputController: kilometersController,
                                keyboardType: TextInputType.number,
                                labelText: AppLocalizations.of(Get.context!)!
                                    .kilometers,
                                labelStyleText: isKilometersValid
                                    ? const TextStyle()
                                        .normal16
                                        .textColor(ColorSchema.grey54Color)
                                    : const TextStyle()
                                        .normal16
                                        .textColor(ColorSchema.redColor),
                              ),
                              clearIcon: false,
                              onNextPress: () {
                                licensePlateFocusNode.requestFocus();
                              },
                              validation: (val) {
                                if (val!.isEmpty) {
                                  isKilometersValid = false;
                                  return AppLocalizations.of(Get.context!)!
                                      .enterKilometers;
                                } else {
                                  isKilometersValid = true;
                                  return null;
                                }
                              },
                              textCallback: (val) {
                                if (val.isEmpty) {
                                  isKilometersValid = false;
                                } else {
                                  isKilometersValid = true;
                                }
                                setState1(
                                  () {},
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: getSize(10),
                          ),
                          Text(
                            AppLocalizations.of(Get.context!)!.fuelTank,
                            style: const TextStyle().normal16,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                ImageConstants.signal,
                                height: 20,
                                width: 20,
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(Get.context!).copyWith(
                                    activeTrackColor: ColorSchema.primaryColor,
                                    inactiveTrackColor:
                                        ColorSchema.lightGreenColor,
                                    thumbColor: ColorSchema.primaryColor,
                                    // overlayColor:ColorSchema.grey38Color,
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 10.0,
                                    ),
                                    overlayShape: const RoundSliderOverlayShape(
                                        overlayRadius: 20.0),
                                  ),
                                  child: Slider(
                                      value: sliderValue,
                                      divisions: 5,
                                      min: 1,
                                      max: 5,
                                      onChangeEnd: (val) {
                                        sliderValue = val;
                                        print(sliderValue
                                            .floorToDouble()
                                            .toInt()
                                            .toString());
                                        setState1(() {});
                                      },
                                      // values: values.value,
                                      onChanged: (value) {
                                        // print(value.ceilToDouble());
                                        // print(
                                        //     "START: ${value.start}, End: ${value.end}");
                                        sliderValue = value;
                                        if (sliderValue == 1) {
                                          isFuelValid = false;
                                        } else {
                                          isFuelValid = true;
                                        }
                                        setState1(() {});
                                      }),
                                ),
                              ),
                              Image.asset(
                                ImageConstants.filSignal,
                                height: 20,
                                width: 20,
                              )
                            ],
                          ),
                          if (!isFuelValid)
                            Column(
                              children: [
                                SizedBox(
                                  height: getSize(10),
                                ),
                                Text(
                                  AppLocalizations.of(Get.context!)!.enterFuel,
                                  style: const TextStyle()
                                      .normal16
                                      .copyWith(color: ColorSchema.redColor),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: getSize(10),
                          ),
                          TextfieldContainer(
                            widget: CommonTextfield(
                              inputAction: TextInputAction.done,
                              focusNode: licensePlateFocusNode,
                              textOption: TextFieldOption(
                                inputController: licensePlateController,
                                keyboardType: TextInputType.text,
                                labelText: AppLocalizations.of(Get.context!)!
                                    .licensePlate,
                                labelStyleText: isLicensePlateValid
                                    ? const TextStyle()
                                        .normal16
                                        .textColor(ColorSchema.grey54Color)
                                    : const TextStyle()
                                        .normal16
                                        .textColor(ColorSchema.redColor),
                              ),
                              clearIcon: false,
                              validation: (val) {
                                if (val!.isEmpty) {
                                  isLicensePlateValid = false;
                                  return AppLocalizations.of(Get.context!)!
                                      .enterLicensePlate;
                                } else {
                                  isLicensePlateValid = true;
                                  return null;
                                }
                              },
                              textCallback: (val) {
                                if (val.isEmpty) {
                                  isLicensePlateValid = false;
                                } else {
                                  isLicensePlateValid = true;
                                }
                                setState1(() {});
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CommonAppButton(
                            width: double.infinity,
                            color: (isLicensePlateValid &&
                                    isKilometersValid &&
                                    isFuelValid &&
                                    kilometersController.text.isNotEmpty &&
                                    licensePlateController.text.isNotEmpty &&
                                    sliderValue != 1)
                                ? ColorSchema.primaryColor
                                : ColorSchema.grey38Color,
                            text: AppLocalizations.of(Get.context!)!.save,
                            style: const TextStyle().medium16.copyWith(
                                color: (isLicensePlateValid &&
                                        isKilometersValid &&
                                        isFuelValid &&
                                        kilometersController.text.isNotEmpty &&
                                        licensePlateController
                                            .text.isNotEmpty &&
                                        sliderValue != 1)
                                    ? ColorSchema.whiteColor
                                    : ColorSchema.black2Color),
                            onTap: () {
                              if (sliderValue == 1) {
                                isFuelValid = false;
                              }

                              if (formKey.currentState!.validate()) {
                                apiCallForAddDailyEntry(data: data);
                              }
                              setState1(() {});
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
              // contentText: "",
            });
      } else {
        if (currentLatLog != null) {
          String url = //Current+Location 21.230246,72.838258
              "https://www.google.com/maps/dir/?api=1&origin=${currentLatLog.value.latitude},${currentLatLog.value.longitude}&destination=${data.userAddress!.latitude.toString()},${data.userAddress!.longitude.toString()}";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        }
      }
    }
  }

  apiCallForAddDailyEntry({required OrderData data}) async {
    Get.back();
    CustomDialogs.getInstance.showProgressDialog();
    Map<String, dynamic> reqData = {
      "km": kilometersController.text,
      "fuel": sliderValue.floorToDouble().toInt().toString(),
      "plat_number": licensePlateController.text
    };
    final response = await allOrderProvider.addDailyEntry(reqData);
    kilometersController.clear();
    sliderValue = 0;
    licensePlateController.clear();
    print(response);
    CustomDialogs.getInstance.hideProgressDialog();
    if (currentLatLog != null) {
      String url = //Current+Location 21.230246,72.838258
          "https://www.google.com/maps/dir/?api=1&origin=${currentLatLog.value.latitude},${currentLatLog.value.longitude}&destination=${data.userAddress!.latitude.toString()},${data.userAddress!.longitude.toString()}";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  sortDataDistanceWise() async {
    // orderData.clear();
    for (var element in allOrderList) {
      await apiCallForGetDistance(
          lat: element.userAddress?.latitude ?? "",
          long: element.userAddress?.longitude ?? "");
      element.totalDistance = directionsModel?.totalDistance ?? "";
      element.totalDuration = directionsModel?.totalDuration ?? "";
      print(directionsModel?.totalDistance);

      // orderData.add(element);
    }

    allOrderList.sort((a, b) => a.totalDistance.compareTo(b.totalDistance));
  }

  apiCallForGetOrderByDate() async {
    allOrderList.value = [];
    pickUpOrderList.value = [];
    completedOrderList.value = [];
    inProgressOrderList.value = [];
    noOrderFound.value = false;
    shoProgress.value = true;
    await apiCallForGetAllOrderStatus();
    if (getOrderStatusModel.value.success ?? false) {
      Map<String, dynamic> reqData = {
        "date":
            "${calendarController.selectedDay.year.toString()}-${calendarController.selectedDay.month.toString().padLeft(2, "0")}-${calendarController.selectedDay.day.toString().padLeft(2, "0")}"
      };
      final response = await allOrderProvider.getOrderByDate(reqData);
      // final response =
      //     jsonDecode(await rootBundle.loadString('assets/local.json'));
      if (!isNullEmptyOrFalse(response)) {
        print(response);
        // getOrderDetailModel.value = GetOrderDetailModel.fromJson(response);
        // if (getOrderDetailModel.value.data!.pickUpOrder!.isEmpty) {
        //   pickUpNoData.value = true;
        // }
        // if (getOrderDetailModel.value.data!.deliveryOrder!.isEmpty) {
        //   deliverNoData.value = true;
        // }

        getAllOrderModel.value = GetAllOrderModel.fromJson(response);
        for (var element in getAllOrderModel.value.data!.pickUpOrder!) {
          element.isPickUpOrder = true;
          allOrderList.add(element);
        }
        for (var element in getAllOrderModel.value.data!.deliveryOrder!) {
          element.isPickUpOrder = false;
          allOrderList.add(element);
        }

        await sortDataDistanceWise();

        for (int i = 0; i < getOrderStatusModel.value.data!.length; i++) {
          for (var element in allOrderList) {
            if (getOrderStatusModel.value.data![i].id ==
                element.orderStatusId) {
              orderStatusData.value = getOrderStatusModel.value.data![i];
            }
            // if (pickUpStatusIds.contains(orderStatusData.value.id)) {
            //   element.orderType = "Pick up";
            // }
            // if (pickUpStatusIds.contains(orderStatusData.value.id)) {
            //   element.orderType = "Delivery";
            // }
          }
        }

        for (var element in allOrderList) {
          if (element.isPickUpOrder) {
            if ([3].contains(element.orderStatusId)) {
              pickUpOrderList.add(element);
            } else if ([4].contains(element.orderStatusId)) {
              inProgressOrderList.add(element);
            } else {
              completedOrderList.add(element);
            }
          } else {
            if ([12].contains(element.orderStatusId)) {
              pickUpOrderList.add(element);
            } else if ([13].contains(element.orderStatusId)) {
              inProgressOrderList.add(element);
            } else {
              completedOrderList.add(element);
            }
          }
        }
        pickUpOrderList.sort(
          (a, b) => a.totalDistance.compareTo(b.totalDistance),
        );
        inProgressOrderList.sort(
          (a, b) => a.totalDistance.compareTo(b.totalDistance),
        );
      } else {
        noOrderFound.value = true;
      }
      shoProgress.value = false;
    }
  }

  // apiCallForGetOrderDetailsInfo({String orderId = ""}) async {
  //   await apiCallForGetAllOrderStatus();

  //   Map<String, dynamic> reqData = {"order_id": orderId};
  //   final response = await orderDetailsProvider.getOrderDetailInfo(reqData);
  //   if (!isNullEmptyOrFalse(response)) {
  //     getAllOrderModel.value = GetAllOrderModel.fromJson(response);
  //   }
  //   for (int i = 0; i < getOrderStatusModel.value.data!.length; i++) {
  //     if (getOrderStatusModel.value.data![i].id ==
  //         getAllOrderModel.value.data!.orderStatusId) {
  //       orderStatusData.value = getOrderStatusModel.value.data![i];
  //     }
  //   }
  // }

  apiCallForGetAllOrderStatus() async {
    // getOrderStatusModel.value = GetOrderStatusModel();
    final response = await allOrderProvider.getAllOrderStatus({});
    if (!isNullEmptyOrFalse(response)) {
      print(response);
      final allStatus = GetOrderStatusModel.fromJson(response);
      getOrderStatusModel.value.message = allStatus.message;
      getOrderStatusModel.value.success = allStatus.success;
      getOrderStatusModel.value.data = [];
      for (int i = 0; i < (allStatus.data?.length ?? 0); i++) {
        if (allStatus.data![i].id != 4 &&
            allStatus.data![i].id != 5 &&
            allStatus.data![i].id != 6 &&
            allStatus.data![i].id != 13 &&
            allStatus.data![i].id != 14 &&
            allStatus.data![i].id != 15) {
        } else {
          getOrderStatusModel.value.data!.add(allStatus.data![i]);
        }
      }
    }
  }

  apiCallForChangeOrderStatus({required String? id}) async {
    CustomDialogs.getInstance.showProgressDialog();
    dio.FormData reqData = dio.FormData.fromMap({
      "order_id": int.parse(id.toString()),
      "order_status_id": int.parse(orderStatusData.value.id.toString()),
      if (commentTextEditingController.text.isNotEmpty)
        "comment": commentTextEditingController.text,
      if (!isNullEmptyOrFalse(pickedImage.value.path))
        "image": await dio.MultipartFile.fromFile(
          pickedImage.value.path,
        ),
    });

    // final response = await allOrderProvider.getChangeOrderStatus(reqData);
    final response = await call.post(
      ApiConstants.changeOrderStatus,
      data: reqData,
      options: dio.Options(
        headers: {
          "token": PrefUtils.getInstance.readData(
            PrefUtils.getInstance.accessToken,
          ),
        },
      ),
    );
    print(response.data);
    pickedImage.value = File("");
    commentTextEditingController.clear();

    CustomDialogs.getInstance.hideProgressDialog();
  }
}
