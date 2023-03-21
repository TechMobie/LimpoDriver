// ignore_for_file: avoid_print
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../helper/utils/constants.dart';
import '../../../helper/utils/images.dart';
import '../../../helper/utils/pref_utils.dart';
import '../../../schemata/color_schema.dart';
import '../../routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNextSplash();
  }

  goToNextSplash() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.getToken().then((value) {
      fcmToken = value!;
      if (kDebugMode) {
        print("Firebase_token ---> " + fcmToken);
      }
    });

    PrefUtils.getInstance.readData(PrefUtils.getInstance.profile);
    Future.delayed(const Duration(milliseconds: 2500), () async {
    //  throw Exception();

      // FirebaseCrashlytics.instance.crash();
      if (await PrefUtils.getInstance.isUserLogin()) {
        // PrefUtils.getInstance.initializeUser();
        Get.offAllNamed(Routes.bottomBarScreen);
      } else {
        Get.offAllNamed(Routes.signIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchema.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: SvgPicture.asset(
                ImageConstants.appIcon,
                color: ColorSchema.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
