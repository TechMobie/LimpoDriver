// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:linpo_driver/app/modules/orderDetails/order_details_controller.dart';
// import 'package:linpo_driver/app/routes/app_pages.dart';
// import 'package:linpo_driver/helper/utils/common_functions.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import '../../../helper/utils/math_utils.dart';

// class DeliveryOrderScreen extends StatelessWidget {
//   DeliveryOrderScreen({Key? key}) : super(key: key);
//   final OrderDetailsController orderDetailsController =
//       Get.find<OrderDetailsController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => orderDetailsController.deliverNoData.value
//             ? Center(
//                 child: Text(
//                 AppLocalizations.of(context)!.noOrderFound,
//               ))
//             : (isNullEmptyOrFalse(orderDetailsController
//                         .getOrderDetailModel.value.data?.deliveryOrder ??
//                     ""))
//                 ? const Center(child: CircularProgressIndicator())
//                 : ListView.separated(
//                     padding:
//                         const EdgeInsets.only(top: 10, right: 10, left: 10),
//                     itemCount: orderDetailsController.getOrderDetailModel.value
//                             .data?.deliveryOrder?.length ??
//                         0,
//                     separatorBuilder: (context, index) {
//                       return SizedBox(
//                         height: getSize(10),
//                       );
//                     },
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {
//                           orderDetailsController.apiCallForGetOrderDetailsInfo(
//                               orderId: orderDetailsController
//                                       .getOrderDetailModel
//                                       .value
//                                       .data
//                                       ?.deliveryOrder?[index]
//                                       .id
//                                       .toString() ??
//                                   "");
//                           Get.toNamed(Routes.orderDetailsInfoScreen);
//                         },
//                         child: Container(
//                           // height: 50,
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               border: Border.all(width: 0.5)),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Number: " +
//                                             (orderDetailsController
//                                                     .getOrderDetailModel
//                                                     .value
//                                                     .data
//                                                     ?.deliveryOrder?[index]
//                                                     .id
//                                                     .toString() ??
//                                                 ""),
//                                       ),
//                                       // Text((orderDetailsController
//                                       //         .getOrderDetailModel
//                                       //         .value
//                                       //         .data
//                                       //         ?.deliveryOrder?[index]
//                                       //         .id
//                                       //         .toString() ??
//                                       //     "")),
//                                     ],
//                                   ),
//                                   // Column(
//                                   //   crossAxisAlignment:
//                                   //       CrossAxisAlignment.start,
//                                   //   children: [
//                                   //     const Text(
//                                   //       "Condition",
//                                   //     ),
//                                   //     Text((orderDetailsController
//                                   //             .getOrderDetailModel
//                                   //             .value
//                                   //             .data
//                                   //             ?.deliveryOrder?[index]
//                                   //             .o
//                                   //             .toString() ??
//                                   //         "")),
//                                   //   ],
//                                   // ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Text("Comments: " +
//                                   (orderDetailsController
//                                           .getOrderDetailModel
//                                           .value
//                                           .data
//                                           ?.deliveryOrder?[index]
//                                           .comments
//                                           .toString() ??
//                                       "")),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Text("Amount: " +
//                                   (orderDetailsController
//                                           .getOrderDetailModel
//                                           .value
//                                           .data
//                                           ?.deliveryOrder?[index]
//                                           .amount
//                                           .toString() ??
//                                       "")),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//       ),
//     );
//   }
// }
