import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/app/modules/bottomBar/bottombar_controller.dart';
import 'package:linpo_driver/components/common_class.dart';
import 'package:linpo_driver/schemata/color_schema.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_driver/schemata/text_style.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final bottombarcontroller = Get.find<BottomBarController>();

  bool isFromMyStatastics = false;
  @override
  void dispose() {
    super.dispose();
    isFromMyStatastics = false;
    // if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    isFromMyStatastics = Get.arguments ?? false;
    return Scaffold(
        backgroundColor: ColorSchema.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Obx(
              () => Column(
                children: [
                  if (isFromMyStatastics)
                    CommonHeader(
                        title: AppLocalizations.of(context)!.myStatistics),
                  if (isFromMyStatastics)
                    const SizedBox(
                      height: 20,
                    ),
                  Expanded(
                    child: Row(
                      children: [
                        getContainer(
                          context,
                          order: (bottombarcontroller.dashBoardModel.value.data
                                      ?.allTimeOrder ??
                                  0)
                              .toString(),
                          title: AppLocalizations.of(context)!.allOrder,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        getContainer(
                          context,
                          order: (bottombarcontroller.dashBoardModel.value.data
                                      ?.todayTodayOrder ??
                                  0)
                              .toString(),
                          title: AppLocalizations.of(context)!.todayAllOrder,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        getContainer(
                          context,
                          order: (bottombarcontroller
                                      .dashBoardModel.value.data?.todayPicked ??
                                  0)
                              .toString(),
                          title: AppLocalizations.of(context)!.todayPickup,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        getContainer(
                          context,
                          order: (bottombarcontroller.dashBoardModel.value.data
                                      ?.todayDeliver ??
                                  0)
                              .toString(),
                          title: AppLocalizations.of(context)!.todayDelivery,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        getContainer(
                          context,
                          order: (bottombarcontroller.dashBoardModel.value.data
                                      ?.allTimePicked ??
                                  0)
                              .toString(),
                          title: AppLocalizations.of(context)!.allPickUp,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        getContainer(
                          context,
                          order: (bottombarcontroller.dashBoardModel.value.data
                                      ?.allTimeDeliver ??
                                  0)
                              .toString(),
                          title: AppLocalizations.of(context)!.allDelivery,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Expanded getContainer(
    BuildContext context, {
    required String order,
    required String title,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: ColorSchema.primaryColor.withOpacity(0.2),
                offset: const Offset(2, 2),
                spreadRadius: 3,
                blurRadius: 1)
          ],
          borderRadius: BorderRadius.circular(10),
          color: ColorSchema.primaryColor.withOpacity(0.8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              order,
              style: const TextStyle().bold26.textColor(ColorSchema.whiteColor),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style:
                  const TextStyle().normal16.textColor(ColorSchema.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
