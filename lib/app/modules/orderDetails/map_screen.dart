// ignore_for_file: deprecated_member_use, must_be_immutable, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:linpo_driver/app/data/models/order/all_order_model.dart';
import 'package:linpo_driver/app/modules/orderDetails/all_order_controller.dart';
import 'package:linpo_driver/app/routes/app_pages.dart';
import 'package:linpo_driver/components/button/button.dart';
import 'package:linpo_driver/components/common_class.dart';
import 'package:linpo_driver/helper/utils/constants.dart';
import 'package:linpo_driver/helper/utils/math_utils.dart';
import 'package:linpo_driver/schemata/color_schema.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:linpo_driver/schemata/text_style.dart';

class MapMapScreen extends StatefulWidget {
  List<OrderData>? allOrderList = [];

  MapMapScreen({Key? key, this.allOrderList}) : super(key: key);

  @override
  State<MapMapScreen> createState() => _MapMapScreenState();
}

class _MapMapScreenState extends State<MapMapScreen> {
  final AllOrderController allOrderController = Get.find<AllOrderController>();
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  List<PointLatLng> result = [];

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(
          const Duration(milliseconds: 200),
          () => controller.animateCamera(CameraUpdate.newLatLngBounds(
              MapUtils.boundsFromLatLngList(
                  _markers.map((loc) => loc.position).toList()),
              80)));
    });
  }

  Polyline? polyline;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
    _markers.add(Marker(
      markerId: const MarkerId("Current"),
      position:
          LatLng(currentLatLog.value.latitude, currentLatLog.value.longitude),
      infoWindow: const InfoWindow(
        title: 'Current',
      ),
      onTap: () {
        // print(element.id);
      },
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ));

    for (var element in widget.allOrderList!) {
      addMarker(element: element);
    }

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setPolyLinesPoints();
    });
  }

  addMarker({required OrderData element}) {
    _markers.add(
      Marker(
        markerId: MarkerId(element.id.toString()),
        position: LatLng(
          double.parse(element.userAddress!.latitude.toString()),
          double.parse(element.userAddress!.longitude.toString()),
        ),
        // infoWindow: InfoWindow(
        //   title: "A${element.id}",
        //   // snippet: element.id.toString(),
        // ),
        onTap: () {
          setState(() {});
          Get.bottomSheet(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: ColorSchema.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          offset: const Offset(2, 2),
                          spreadRadius: 3,
                        )
                      ]),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: ColorSchema.whiteColor,
                              border: Border.all(color: ColorSchema.blackColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: (element.isPickUpOrder)
                                ? Text(
                                    AppLocalizations.of(context)!.pickUpOrder,
                                    style: const TextStyle()
                                        .medium16
                                        .textColor(ColorSchema.black2Color),
                                  )
                                : Text(
                                    AppLocalizations.of(context)!.deliverOrder,
                                    style: const TextStyle()
                                        .medium16
                                        .textColor(ColorSchema.black2Color),
                                  ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(Get.context!)!.distance,
                              ),
                              Text(
                                element.totalDistance +
                                    " ${AppLocalizations.of(Get.context!)!.km}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(AppLocalizations.of(Get.context!)!
                                  .estimatedTime),
                              Text(element.totalDuration,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(Get.context!)!.client}: "),
                                    Text(
                                        (element.user?.firstName ??
                                                "".toString()) +
                                            " " +
                                            (element.user?.lastName ??
                                                "".toString()),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(Get.context!)!.serviceAreaName}: "),
                                    Expanded(
                                      child: Text(
                                          (element.userAddress
                                                  ?.serviceAreaName ??
                                              "".toString()),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(Get.context!)!.addressLabel}: "),
                                    Expanded(
                                      child: Text(
                                          (element.userAddress?.addressLabel ??
                                              "".toString()),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(Get.context!)!.direction}: "),
                                    Expanded(
                                      child: Text(
                                          (element.userAddress?.location ??
                                              "".toString()),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(Get.context!)!.addressNumber}: "),
                                    Text(
                                        ((element.userAddress?.address ?? "")
                                            .toString()),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.whoWillReceived}: "),
                                    Text(element.whoWillReceive ?? "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${AppLocalizations.of(context)!.description}: "),
                                    Text(element.comments ?? "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 60,
                            child: CommonAppButton(
                              borderRadius: 5,
                              color: ColorSchema.primaryColor,
                              width: double.infinity,
                              style: const TextStyle()
                                  .medium16
                                  .copyWith(color: ColorSchema.whiteColor),
                              height: 40,
                              text: AppLocalizations.of(Get.context!)!.call,
                              onTap: () async {
                                if (currentLatLog != null) {
                                  String url =
                                      "${AppLocalizations.of(Get.context!)!.tel}: ${element.user!.mobileNumber.toString()}";

                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                }
                              },
                              textColor: ColorSchema.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonAppButton(
                        borderRadius: 5,
                        color: ColorSchema.primaryColor,
                        width: double.infinity,
                        style: const TextStyle()
                            .medium16
                            .copyWith(color: ColorSchema.whiteColor),
                        height: 40,
                        text: AppLocalizations.of(Get.context!)!.seeOrder,
                        onTap: () async {
                          Get.back();
                          Get.back();
                          for (int i = 0;
                              i <
                                  allOrderController
                                      .getOrderStatusModel.value.data!.length;
                              i++) {
                            if (allOrderController
                                    .getOrderStatusModel.value.data![i].id ==
                                element.orderStatusId) {
                              allOrderController.orderStatusData.value =
                                  allOrderController
                                      .getOrderStatusModel.value.data![i];

                              // if (pickUpStatusIds.contains(orderStatusData.value.id)) {
                              //   element.orderType = "Pick up";
                              // }
                              // if (pickUpStatusIds.contains(orderStatusData.value.id)) {
                              //   element.orderType = "Delivery";
                              // }
                            }
                          }
                          Get.toNamed(Routes.orderDetailsInfoScreen,
                              arguments: element);
                        },
                        textColor: ColorSchema.whiteColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  setPolyLinesPoints() async {
    List<PolylineWayPoint> wayPoint = [];
    for (var element in widget.allOrderList!) {
      wayPoint.add(PolylineWayPoint(
          location:
              "${element.userAddress!.latitude.toString()},${element.userAddress!.longitude.toString()}"));
    }
    await polylinePoints
        .getRouteBetweenCoordinates(
      "AIzaSyB11EmBESLcoquOpKsU21a32a8oLxk2Q-c",
      PointLatLng(currentLatLog.value.latitude, currentLatLog.value.longitude),
      PointLatLng(
        double.parse(
            widget.allOrderList!.last.userAddress!.latitude.toString()),
        double.parse(
          widget.allOrderList!.last.userAddress!.longitude.toString(),
        ),
      ),
      wayPoints: wayPoint,
    )
        .then((value) {
      result.addAll(value.points);
    });

    if (result.isNotEmpty) {
      for (var point in result) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    setState(() {
      Polyline polyline = Polyline(
          polylineId: const PolylineId(""),
          color: const Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);
      _polyline.add(polyline);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          height: 55,
          // width: 100,
          margin: const EdgeInsets.only(bottom: 15, right: 5),
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              color: ColorSchema.primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.list,
                color: Colors.white,
              ),
              const SizedBox(
                width: 18,
              ),
              Text(
                AppLocalizations.of(context)!.viewList,
                style: const TextStyle()
                    .medium16
                    .textColor(ColorSchema.whiteColor),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: getSize(20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: CommonHeader(
                title: AppLocalizations.of(context)!.map,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GoogleMap(
                markers: _markers,
                polylines: _polyline,
                onMapCreated: _onMapCreated,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(currentLatLog.value.latitude,
                      currentLatLog.value.longitude),
                  // zoom:,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapUtils {
  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
}
