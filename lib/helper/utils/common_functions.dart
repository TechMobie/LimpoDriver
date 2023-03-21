import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../schemata/color_schema.dart';

final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

//check null, empty or false.
bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}

// use to capitalize string
// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1)}";
//   }
// }
showToast({String? msg = "", Color? color}) {
  return Get.snackbar(
    "Limpo",
    msg!,
    backgroundColor: color ?? ColorSchema.black2Color.withOpacity(0.2),
    snackPosition: SnackPosition.TOP,
  );
  // return Fluttertoast.showToast(
  //     msg: msg!,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: ColorConstants.buttonColor.withOpacity(0.4),
  //     textColor: ColorConstants.whiteColor,
  //     fontSize: 16.0);
}

class ProgressDialog2 {
  static Future<void> showLoadingDialog(
      {bool isBarrierDismissible = false}) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: isBarrierDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              return isBarrierDismissible;
            },
            child: const Center(
              // child:  Image(image: AssetImage("assets/loader.gif",),height: 50,width: 50,),
              child: CircularProgressIndicator(
                color: ColorSchema.primaryColor,
              ),
            ));
      },
    );
  }
}

// class ProgressDialog2 {
//   static Future<void> showLoadingDialog(BuildContext context,
//       {bool isCancellable = true}) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: isCancellable,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0))),
//           content: Builder(builder: (context) {
//             return WillPopScope(
//               onWillPop: () async {
//                 return isCancellable;
//               },
//               // child: SpinKitThreeBounce(
//               //   color: ColorConstants.whiteColor,
//               //   size: 50.0,
//               // ),
//               child: SizedBox(
//                 height: 40.0,
//                 width: 40.0,
//                 child: Image.asset(
//                   "assets/loader.gif",
//                   height: 40.0,
//                   width: 40.0,
//                 ),
//               ),
//             );
//           }),
//         );
//       },
//     );
//   }
// }

class CustomDialogs {
  static CustomDialogs? _shared;

  CustomDialogs._();

  static CustomDialogs get getInstance =>
      _shared = _shared ?? CustomDialogs._();

  showCircularIndicator(
    BuildContext context, {
    double size = 40.0,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/loader.gif",
          height: size,
          width: size,
        ),
      ],
    );
  }

  void showProgressDialog() {
    ProgressDialog2.showLoadingDialog(isBarrierDismissible: false);
  }

  void hideProgressDialog() {
    Get.back();
  }
}

// showToast({
//   String? msg,
//   ToastGravity? gravity,
//   int timer = 2000,
// }) {
//   if (kDebugMode) {
//     FToast().init(Get.overlayContext!);
//     Widget toast = Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 16,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(
//           40,
//         ),
//         color: ColorSchema.primaryColor.withOpacity(0.5),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             msg ?? "",
//             style: const TextStyle(
//               color: ColorSchema.whiteColor,
//               fontSize: 16,
//             ),
//             textAlign: TextAlign.center,
//           )
//         ],
//       ),
//     );

//     FToast().showToast(
//       child: toast,
//       gravity: gravity ?? ToastGravity.BOTTOM,
//       toastDuration: Duration(
//         milliseconds: timer,
//       ),
//     );
//   }
// }

commonDivider() {
  return const Divider(
    color: ColorSchema.black2Color,
    thickness: 1,
    height: 0,
  );
}

String getUserRole() {
  return GetStorage().read("userDetails")['role'];
}
