// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/schemata/text_style.dart';
import '../helper/utils/math_utils.dart';
import '../schemata/color_schema.dart';

class CommonHeader extends StatelessWidget {
  final String? title;
  final TextStyle? headerStyle;

  const CommonHeader({Key? key, this.title, this.headerStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: headerStyle ??
              const TextStyle().semibold24.textColor(ColorSchema.black2Color),
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const CircleAvatar(
            radius: 18,
            child: Icon(
              Icons.close_rounded,
              color: ColorSchema.whiteColor,
              size: 20,
            ),
            backgroundColor: ColorSchema.primaryColor,
          ),
        )
      ],
    );
  }
}

class CommonContainer extends StatelessWidget {
  final Widget? widget;
  final Color? borderColor;

  const CommonContainer({Key? key, this.widget, this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
          padding: EdgeInsets.symmetric(
              vertical: getSize(20), horizontal: getSize(20)),
          // margin: EdgeInsets.symmetric(horizontal: getSize(15)),
          //height: getSize(180),
          width: MathUtilities.screenWidth(context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  width: 1, color: borderColor ?? ColorSchema.black2Color)),
          child: widget),
    );
  }
}
