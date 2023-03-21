import 'package:get/get.dart';
import 'package:linpo_driver/app/modules/bottomBar/bottombar_screen.dart';
import 'package:linpo_driver/app/modules/dashboard/dashboard_screen.dart';
import 'package:linpo_driver/app/modules/orderDetails/order_details_info_screen.dart';
import 'package:linpo_driver/app/modules/orderDetails/all_order_screen.dart';
import 'package:linpo_driver/app/modules/plus/my_account_screen.dart';

import '../modules/authentication/forgot_screen.dart';
import '../modules/authentication/sign_in_screen.dart';
import '../modules/plus/change_password.dart';
import '../modules/plus/my_transport_screen.dart';
import '../modules/plus/order_of_the_day_screen.dart';
import '../modules/splash/splash_screen.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const SplashScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.signIn,
      page: () => SignInScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.forgotScreen,
      page: () => ForgotScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.bottomBarScreen,
      page: () => BottomBarScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.myAccountScreen,
      page: () => const MyAccountScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.myTransportScreen,
      page: () => MyTransportScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.orderOfTheDayScreen,
      page: () => const OrderOfTheDayScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.orderDetailsScreen,
      page: () => const OrderDetailsScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.orderDetailsInfoScreen,
      page: () => const OrderDetailsInfoScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePassword(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.dashBoardScreen,
      page: () =>const DashBoardScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
