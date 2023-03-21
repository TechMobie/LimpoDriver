import 'package:flutter/material.dart';
import '../../schemata/color_schema.dart';
import 'math_utils.dart';

class TextfieldContainer extends StatelessWidget {
  final Widget? widget;
  final double? height;

  const TextfieldContainer({Key? key, this.widget, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? getSize(55),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: ColorSchema.grey54Color)),
        padding:
            EdgeInsets.symmetric(vertical: getSize(9), horizontal: getSize(10)),
        child: widget);
  }
}
