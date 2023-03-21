// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_driver/app/modules/plus/plus_controller.dart';
import 'package:linpo_driver/app/routes/app_pages.dart';
import 'package:linpo_driver/components/button/button.dart';
import 'package:linpo_driver/components/common_listtile.dart';
import 'package:linpo_driver/helper/utils/images.dart';
import 'package:linpo_driver/helper/utils/math_utils.dart';
import 'package:linpo_driver/schemata/color_schema.dart';
import 'package:linpo_driver/schemata/text_style.dart';
import '../../../components/common_textfield.dart';
import '../../../helper/utils/pref_utils.dart';

class PlusScreen extends StatefulWidget {
  const PlusScreen({Key? key}) : super(key: key);

  @override
  State<PlusScreen> createState() => _PlusScreenState();
}

class _PlusScreenState extends State<PlusScreen> {
  final plusController = Get.put<PlusController>(PlusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      resizeToAvoidBottomInset: false,
      body: GetBuilder<PlusController>(
        init: plusController,
        builder: (controller) => Padding(
          padding: EdgeInsets.only(
              left: getSize(20), right: getSize(20), top: getSize(30)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: getSize(10)),
                height: getSize(100),
                width: getSize(100),
                child: SvgPicture.asset(
                  ImageConstants.appIcon,
                  color: ColorSchema.primaryColor,
                ),
              ),
              Center(
                  child: Text(
                "${AppLocalizations.of(context)!.hiClean} ${PrefUtils.getInstance.readData(PrefUtils.getInstance.profileName)}!",
                style:
                    const TextStyle().bold20.textColor(ColorSchema.black2Color),
              )),
              SizedBox(
                height: getSize(40),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorSchema.greyColor)),
                child: Column(
                  children: [
                    CommonListTile(
                        txt: AppLocalizations.of(context)!.myAccount,
                        svgImage: ImageConstants.account,
                        padding: 5,
                        onTap: () {
                          Get.toNamed(Routes.myAccountScreen);
                        }),
                    const Divider(
                        color: ColorSchema.greyColor, thickness: 1, height: 0),
                    // CommonListTile(
                    //   txt: AppLocalizations.of(context)!.myTransport,
                    //   svgImage: ImageConstants.cargoTruck,
                    //   height: 22,
                    //   width: 22,
                    //   onTap: () {
                    //     Get.toNamed(Routes.myTransportScreen);
                    //   },
                    // ),
                    // const Divider(
                    //     color: ColorSchema.greyColor, thickness: 1, height: 0),
                    CommonListTile(
                      txt: AppLocalizations.of(context)!.changePassword,
                      svgImage: ImageConstants.lock,
                      onTap: () {
                        Get.toNamed(Routes.changePassword);
                      },
                    ),
                    const Divider(
                        color: ColorSchema.greyColor, thickness: 1, height: 0),
                    CommonListTile(
                        txt: AppLocalizations.of(context)!.orderOfTheDay,
                        svgImage: ImageConstants.shoppingList,
                        padding: 12,
                        onTap: () {
                          // showDialog(
                          //     context: context,
                          //     builder: (_) => Alertdialog(
                          //         titleWidget: Text(
                          //           AppLocalizations.of(context)!
                          //               .routesNotStarted,
                          //           style: TextStyle().medium20,
                          //         ),
                          //         contentText:
                          //             AppLocalizations.of(context)!.youMustStart,
                          //         actionText: AppLocalizations.of(context)!.close,
                          //         onTap: () {
                          //           Get.back();
                          //         }));
                          Get.toNamed(Routes.orderOfTheDayScreen);
                        }),
                    const Divider(
                        color: ColorSchema.greyColor, thickness: 1, height: 0),
                    CommonListTile(
                        txt: AppLocalizations.of(context)!.myStatistics,
                        svgImage: ImageConstants.statistics,
                        padding: 5,
                        onTap: () {
                          Get.toNamed(
                            Routes.dashBoardScreen,
                            arguments: true,
                          );
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CommonAppButton(
                  text: AppLocalizations.of(context)!.logOff,
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                          content:
                              Text(AppLocalizations.of(context)!.areLogout),
                          contentPadding: const EdgeInsets.only(
                              top: 30, left: 20, right: 20, bottom: 30),
                          contentTextStyle: const TextStyle()
                              .medium19
                              .textColor(ColorSchema.grey54Color),
                          actionsPadding: const EdgeInsets.only(bottom: 10),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(AppLocalizations.of(context)!.no,
                                      style: const TextStyle()
                                          .medium19
                                          .copyWith(
                                              color: ColorSchema.primaryColor)),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Get.offAllNamed(
                                      Routes.signIn,
                                    );
                                    plusController.logoutApiCall();
                                    PrefUtils.getInstance.clearLocalStorage();
                                  },
                                  child: Text(AppLocalizations.of(context)!.yes,
                                      style: const TextStyle()
                                          .medium19
                                          .copyWith(
                                              color: ColorSchema.primaryColor)),
                                ),
                              ],
                            ),
                          ]),
                    );
                  },
                  width: double.infinity,
                  style: const TextStyle()
                      .normal16
                      .textColor(ColorSchema.whiteColor),
                  borderRadius: 5),
            ],
          ),
        ),
      ),
    );
  }

  StatefulBuilder kilometersTextField(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return CommonTextfield(
        inputAction: TextInputAction.next,
        focusNode: plusController.kilometersFocusNode,
        textOption: TextFieldOption(
          inputController: plusController.kilometersController,
          keyboardType: TextInputType.number,
          labelText: AppLocalizations.of(context)!.kilometers,
          labelStyleText: plusController.isKilometersValid.value
              ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
              : const TextStyle().normal16.textColor(ColorSchema.redColor),
        ),
        clearIcon: false,
        onNextPress: () {
          plusController.licensePlateFocusNode.requestFocus();
        },
        validation: (val) {
          if (val!.isEmpty) {
            plusController.isKilometersValid.value = false;
            return AppLocalizations.of(context)!.enterKilometers;
          } else {
            plusController.isKilometersValid.value = true;
            return null;
          }
        },
        textCallback: (val) {
          setState(() {
            if (val.isEmpty) {
              plusController.isKilometersValid.value = false;
            } else {
              plusController.isKilometersValid.value = true;
            }
          });
        },
      );
    });
  }

  StatefulBuilder licensePlateTextField(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return CommonTextfield(
        inputAction: TextInputAction.done,
        focusNode: plusController.licensePlateFocusNode,
        textOption: TextFieldOption(
          inputController: plusController.licensePlateController,
          keyboardType: TextInputType.text,
          labelText: AppLocalizations.of(context)!.licensePlate,
          labelStyleText: plusController.isLicensePlateValid.value
              ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
              : const TextStyle().normal16.textColor(ColorSchema.redColor),
        ),
        clearIcon: false,
        validation: (val) {
          if (val!.isEmpty) {
            plusController.isLicensePlateValid.value = false;
            return AppLocalizations.of(context)!.enterLicensePlate;
          } else {
            plusController.isLicensePlateValid.value = true;
            return null;
          }
        },
        textCallback: (val) {
          setState(() {
            if (val.isEmpty) {
              plusController.isLicensePlateValid.value = false;
            } else {
              plusController.isLicensePlateValid.value = true;
            }
          });
        },
      );
    });
  }
// CommonTextfield fuelTextField(BuildContext context) {
//   return CommonTextfield(
//     inputAction: TextInputAction.next,
//     focusNode: plusController.fuelFocusNode,
//     textOption: TextFieldOption(
//       inputController: plusController.fuelController,
//       keyboardType: TextInputType.number,
//       labelText: AppLocalizations.of(context)!.fuel,
//       labelStyleText: plusController.isFuelValid.value
//           ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
//           : const TextStyle().normal16.textColor(ColorSchema.redColor),
//     ),
//     clearIcon: false,
//     onNextPress: () {
//       plusController.licensePlateFocusNode.requestFocus();
//     },
//     validation: (val) {
//       if (val!.isEmpty) {
//         plusController.isFuelValid.value = false;
//         return AppLocalizations.of(context)!.enterFuel;
//       } else {
//         plusController.isFuelValid.value = true;
//         return null;
//       }
//     },
//     textCallback: (val) {
//       if (val.isEmpty) {
//         plusController.isFuelValid.value = false;
//       } else {
//         plusController.isFuelValid.value = true;
//       }
//     },
//   );
// }
}
