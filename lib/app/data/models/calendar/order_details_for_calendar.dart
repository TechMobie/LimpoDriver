// class GetOrderDetailModel {
//   Data? data;

//   GetOrderDetailModel({this.data});

//   GetOrderDetailModel.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ?  Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   List<PickUpOrder>? pickUpOrder;
//   List<PickUpOrder>? deliveryOrder;

//   Data({this.pickUpOrder, this.deliveryOrder});

//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['pick_up_order'] != null) {
//       pickUpOrder = <PickUpOrder>[];
//       json['pick_up_order'].forEach((v) {
//         pickUpOrder!.add( PickUpOrder.fromJson(v));
//       });
//     }
//     if (json['delivery_order'] != null) {
//       deliveryOrder = <PickUpOrder>[];
//       json['delivery_order'].forEach((v) {
//         deliveryOrder!.add( PickUpOrder.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
//     if (pickUpOrder != null) {
//       data['pick_up_order'] = pickUpOrder!.map((v) => v.toJson()).toList();
//     }
//     if (deliveryOrder != null) {
//       data['delivery_order'] =
//           deliveryOrder!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class PickUpOrder {
//   int? id;
//   int? userId;
//   int? pickUpDriverId;
//   int? deliverDriverId;
//   int? cartId;
//   int? userAddressId;
//   String? pickupDate;
//   String? pickupTime;
//   String? deliveryDate;
//   String? deliveryTime;
//   String? whoWillReceive;
//   String? comments;
//   int? orderStatusId;
//   String? buyOrder;
//   String? cardNumber;
//   String? accountingDate;
//   String? transactionDate;
//   int? amount;
//   String? paymentStatus;
//   String? authorizationCode;
//   String? paymentTypeCode;
//   String? commerceCode;
//   String? response;
//   int? isPickUp;
//   int? isDeliver;
//   int? isDelete;
//   String? createdAt;
//   String? updatedAt;

//   PickUpOrder(
//       {this.id,
//       this.userId,
//       this.pickUpDriverId,
//       this.deliverDriverId,
//       this.cartId,
//       this.userAddressId,
//       this.pickupDate,
//       this.pickupTime,
//       this.deliveryDate,
//       this.deliveryTime,
//       this.whoWillReceive,
//       this.comments,
//       this.orderStatusId,
//       this.buyOrder,
//       this.cardNumber,
//       this.accountingDate,
//       this.transactionDate,
//       this.amount,
//       this.paymentStatus,
//       this.authorizationCode,
//       this.paymentTypeCode,
//       this.commerceCode,
//       this.response,
//       this.isPickUp,
//       this.isDeliver,
//       this.isDelete,
//       this.createdAt,
//       this.updatedAt});

//   PickUpOrder.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     pickUpDriverId = json['pick_up_driver_id'];
//     deliverDriverId = json['deliver_driver_id'];
//     cartId = json['cart_id'];
//     userAddressId = json['user_address_id'];
//     pickupDate = json['pickup_date'];
//     pickupTime = json['pickup_time'];
//     deliveryDate = json['delivery_date'];
//     deliveryTime = json['delivery_time'];
//     whoWillReceive = json['who_will_receive'];
//     comments = json['comments'];
//     orderStatusId = json['order_status_id'];
//     buyOrder = json['buyOrder'];
//     cardNumber = json['cardNumber'];
//     accountingDate = json['accountingDate'];
//     transactionDate = json['transactionDate'];
//     amount = json['amount'];
//     paymentStatus = json['payment_status'];
//     authorizationCode = json['authorizationCode'];
//     paymentTypeCode = json['paymentTypeCode'];
//     commerceCode = json['commerceCode'];
//     response = json['response'];
//     isPickUp = json['is_pick_up'];
//     isDeliver = json['is_deliver'];
//     isDelete = json['is_delete'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['pick_up_driver_id'] = pickUpDriverId;
//     data['deliver_driver_id'] = deliverDriverId;
//     data['cart_id'] = cartId;
//     data['user_address_id'] = userAddressId;
//     data['pickup_date'] = pickupDate;
//     data['pickup_time'] = pickupTime;
//     data['delivery_date'] = deliveryDate;
//     data['delivery_time'] = deliveryTime;
//     data['who_will_receive'] = whoWillReceive;
//     data['comments'] = comments;
//     data['order_status_id'] = orderStatusId;
//     data['buyOrder'] = buyOrder;
//     data['cardNumber'] = cardNumber;
//     data['accountingDate'] = accountingDate;
//     data['transactionDate'] = transactionDate;
//     data['amount'] = amount;
//     data['payment_status'] = paymentStatus;
//     data['authorizationCode'] = authorizationCode;
//     data['paymentTypeCode'] = paymentTypeCode;
//     data['commerceCode'] = commerceCode;
//     data['response'] = response;
//     data['is_pick_up'] = isPickUp;
//     data['is_deliver'] = isDeliver;
//     data['is_delete'] = isDelete;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
