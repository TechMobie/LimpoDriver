import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/app/data/models/dashboard_model.dart';
import 'package:linpo_driver/app/modules/bottomBar/bottombar_provider.dart';
import 'package:linpo_driver/components/button/button.dart';
import 'package:linpo_driver/helper/utils/constants.dart';
import 'package:linpo_driver/schemata/color_schema.dart';
import 'package:linpo_driver/schemata/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//your bottombar controller
class BottomBarController extends GetxController {
  RxInt currentIndex = 0.obs;
  bool isOpenDialog = false;
  bool isOpenDialogForAllowLocation = false;
  bool serviceEnabled = false;
  final BottombarProvider bottombarProvider =
      Get.put<BottombarProvider>(BottombarProvider());
  Rx<DashBoardModel> dashBoardModel = Rx<DashBoardModel>(DashBoardModel());

  Future<bool> _determinePosition() async {
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // Future.error('Location services are disabled.');
      if (!isOpenDialog) {
        isOpenDialog = true;
        showDialog(
            context: Get.context!,
            builder: (context) => WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: AlertDialog(
                    title: Text(
                      AppLocalizations.of(context)!.location,
                    ),
                    content: Text(
                      AppLocalizations.of(context)!.onYourLocation,
                    ),
                    actions: [
                      CommonAppButton(
                        height: 40,
                        text: AppLocalizations.of(context)!.openSetting,
                        width: 120,
                        style: const TextStyle()
                            .medium16
                            .copyWith(color: ColorSchema.whiteColor),
                        onTap: () async {
                          await Geolocator.openLocationSettings()
                              .then((value) async {
                            if (value) {
                              serviceEnabled =
                                  await Geolocator.isLocationServiceEnabled();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                )).then((value) {
          isOpenDialog = false;
        });
      }
    } else {
      Get.back();
      isOpenDialog = true;
      serviceEnabled = true;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          if (!isOpenDialogForAllowLocation) {
            isOpenDialogForAllowLocation = true;
            showDialog(
                context: Get.context!,
                builder: (context) => WillPopScope(
                      onWillPop: () async {
                        return false;
                      },
                      child: AlertDialog(
                        title: Text(
                          AppLocalizations.of(context)!.location,
                        ),
                        content: Text(
                          AppLocalizations.of(context)!.allowLocation,
                        ),
                        // actions: [
                        //   CommonAppButton(
                        //     height: 40,
                        //     text: AppLocalizations.of(context)!.allow,
                        //     width: 120,
                        //     style: TextStyle()
                        //         .medium16
                        //         .copyWith(color: Colors.white),
                        //     onTap: () async {
                        //       isOpenDialogForAllowLocation = false;

                        //       _determinePosition();
                        //     },
                        //   ),
                        // ],
                      ),
                    ));
          }
        } else {
          currentLatLog.value = await Geolocator.getCurrentPosition();
        }
      } else {
        currentLatLog.value = await Geolocator.getCurrentPosition();
      }
    }
    if (kDebugMode) {
      print(currentLatLog);
    }
    return serviceEnabled;
  }

  dashBoardApiCall() async {
    try {
      final response = await bottombarProvider.dashBoardApiCall();
      dashBoardModel.value = DashBoardModel.fromJson(response);
    } catch (e) {}
  }

  @override
  void onInit() {
    super.onInit();
    dashBoardApiCall();
    _determinePosition();
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (serviceEnabled) {
        timer.cancel();
      } else {
        _determinePosition();
      }
    });
  }
}
