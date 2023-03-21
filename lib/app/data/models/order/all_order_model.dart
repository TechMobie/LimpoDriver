// ignore_for_file: unnecessary_null_comparison

class GetAllOrderModel {
  bool? success;
  String? message;
  Data? data;

  GetAllOrderModel({this.success, this.message, this.data});

  GetAllOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<OrderData>? pickUpOrder;
  List<OrderData>? deliveryOrder;

  Data({this.pickUpOrder, this.deliveryOrder});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pick_up_order'] != null) {
      pickUpOrder = <OrderData>[];
      json['pick_up_order'].forEach((v) {
        pickUpOrder!.add(OrderData.fromJson(v));
      });
    }
    if (json['delivery_order'] != null) {
      deliveryOrder = <OrderData>[];
      json['delivery_order'].forEach((v) {
        deliveryOrder!.add(OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pickUpOrder != null) {
      data['pick_up_order'] = pickUpOrder!.map((v) => v.toJson()).toList();
    }
    if (deliveryOrder != null) {
      data['delivery_order'] = deliveryOrder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  int? id;
  bool isPickUpOrder = false;
  int? userId;
  int? pickUpDriverId;
  int? deliverDriverId;
  int? cartId;
  int? userAddressId;
  String? pickupDate;
  String? orderType;
  String? pickupTime;
  String? deliveryDate;
  String? deliveryTime;
  String? whoWillReceive;
  String? comments;
  int? orderStatusId;
  String? buyOrder;
  String? cardNumber;
  String? accountingDate;
  String? transactionDate;
  int? amount;
  String? paymentStatus;
  String? authorizationCode;
  String? paymentTypeCode;
  String? commerceCode;
  String? response;
  int? isPickUp;
  int? isDeliver;
  int? isDelete;
  String? createdAt;
  String? updatedAt;
  List<OrderStatus>? orderStatus;
  Cart? cart;
  List<CartDetails>? cartDetails;
  User? user;
  UserAddress? userAddress;
  String totalDistance = "";
  String totalDuration = "";
  String? orderStatusName;
  UserPlan? userPlan;
  int? userPlanId;

  OrderData(
      {this.id,
      this.userId,
      this.pickUpDriverId,
      this.deliverDriverId,
      this.cartId,
      this.userAddressId,
      this.pickupDate,
      this.pickupTime,
      this.deliveryDate,
      this.deliveryTime,
      this.whoWillReceive,
      this.comments,
      this.orderStatus,
      this.orderStatusId,
      this.buyOrder,
      this.cardNumber,
      this.accountingDate,
      this.userPlan,
      this.transactionDate,
      this.amount,
      this.paymentStatus,
      this.authorizationCode,
      this.paymentTypeCode,
      this.commerceCode,
      this.response,
      this.isPickUp,
      this.isDeliver,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.orderStatusName,
      this.cart,
      this.cartDetails,
      this.user,
      this.userPlanId,
      this.userAddress});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userPlanId = (json['user_plan_id'] == null) ? 0 : json['user_plan_id'];

    pickUpDriverId = json['pick_up_driver_id'];
    deliverDriverId = json['deliver_driver_id'];
    cartId = json['cart_id'];
    userAddressId = json['user_address_id'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    whoWillReceive = json['who_will_receive'];
    comments = json['comments'];
    orderStatusId = json['order_status_id'];
    buyOrder = json['buyOrder'];
    cardNumber = json['cardNumber'];
    accountingDate = json['accountingDate'];
    transactionDate = json['transactionDate'];
    amount = json['amount'];
    paymentStatus = json['payment_status'];
    authorizationCode = json['authorizationCode'];
    paymentTypeCode = json['paymentTypeCode'];
    commerceCode = json['commerceCode'];
    response = json['response'];
    isPickUp = json['is_pick_up'];
    isDeliver = json['is_deliver'];
    orderStatusName = json["order_status_name"];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_status'] != null) {
      orderStatus = <OrderStatus>[];
      json['order_status'].forEach((v) {
        orderStatus!.add(OrderStatus.fromJson(v));
      });
    }
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    if (json['cart_details'] != null) {
      cartDetails = <CartDetails>[];
      json['cart_details'].forEach((v) {
        cartDetails!.add(CartDetails.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    userAddress = json['user_address'] != null
        ? UserAddress.fromJson(json['user_address'])
        : null;
    userPlan =
        json['user_plan'] != null ? UserPlan.fromJson(json['user_plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['pick_up_driver_id'] = pickUpDriverId;
    data['deliver_driver_id'] = deliverDriverId;
    data['cart_id'] = cartId;
    data['user_address_id'] = userAddressId;
    data['pickup_date'] = pickupDate;
    data['pickup_time'] = pickupTime;
    data['delivery_date'] = deliveryDate;
    data['delivery_time'] = deliveryTime;
    data['who_will_receive'] = whoWillReceive;
    data['comments'] = comments;
    data['order_status_id'] = orderStatusId;
    data['buyOrder'] = buyOrder;
    data['cardNumber'] = cardNumber;
    data['accountingDate'] = accountingDate;
    data['transactionDate'] = transactionDate;
    data['amount'] = amount;
    data['payment_status'] = paymentStatus;
    data['authorizationCode'] = authorizationCode;
    data['paymentTypeCode'] = paymentTypeCode;
    data['commerceCode'] = commerceCode;
    data['response'] = response;
    data['is_pick_up'] = isPickUp;
    data['is_deliver'] = isDeliver;
    data['is_delete'] = isDelete;
    data['user_plan_id'] = userPlanId;

    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data["order_status_name"] = orderStatusName;
    if (orderStatus != null) {
      data['order_status'] = orderStatus!.map((v) => v.toJson()).toList();
    }
    if (cart != null) {
      data['cart'] = cart!.toJson();
    }
    if (cartDetails != null) {
      data['cart_details'] = cartDetails!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (userAddress != null) {
      data['user_address'] = userAddress!.toJson();
    }
    if (userPlan != null) {
      data['user_plan'] = userPlan!.toJson();
    }
    return data;
  }
}

class OrderStatus {
  int? id;
  int? orderId;
  int? orderStatusId;
  String? comment;
  int? adminId;
  int? driverId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? orderStatus;

  OrderStatus(
      {this.id,
      this.orderId,
      this.orderStatusId,
      this.comment,
      this.adminId,
      this.driverId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.orderStatus});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    orderStatusId = json['order_status_id'];
    comment = json['comment'];
    adminId = json['admin_id'];
    driverId = json['driver_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['order_status_id'] = orderStatusId;
    data['comment'] = comment;
    data['admin_id'] = adminId;
    data['driver_id'] = driverId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['order_status'] = orderStatus;
    return data;
  }
}

class Cart {
  int? id;
  int? userId;
  double? totalAmount;
  int? isCheckout;
  String? createdAt;
  String? updatedAt;

  Cart(
      {this.id,
      this.userId,
      this.totalAmount,
      this.isCheckout,
      this.createdAt,
      this.updatedAt});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalAmount = double.parse(json['total_amount'].toString());
    isCheckout = json['is_checkout'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['total_amount'] = totalAmount;
    data['is_checkout'] = isCheckout;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class CartDetails {
  int? id;
  int? cartId;
  int? typeOfServiceId;
  int? productId;
  int? quantity;
  int? price;
  String? createdAt;
  String? updatedAt;
  String? productName;

  CartDetails(
      {this.id,
      this.cartId,
      this.typeOfServiceId,
      this.productId,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.productName});

  CartDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    typeOfServiceId = json['type_of_service_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = double.parse(json['price'].toString()).toInt();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cart_id'] = cartId;
    data['type_of_service_id'] = typeOfServiceId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['product_name'] = productName;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? emailVerifiedAt;
  String? mobileCountryCode;
  String? mobileNumber;
  String? dateOfBirth;
  String? profilePicture;
  String? rut;
  String? userSessionToken;
  String? deviceToken;
  String? deviceOs;
  String? deviceOsVersion;
  String? deviceModel;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? lastLoginAt;

  User(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerifiedAt,
      this.mobileCountryCode,
      this.mobileNumber,
      this.dateOfBirth,
      this.profilePicture,
      this.rut,
      this.userSessionToken,
      this.deviceToken,
      this.deviceOs,
      this.deviceOsVersion,
      this.deviceModel,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.lastLoginAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobileCountryCode = json['mobile_country_code'];
    mobileNumber = json['mobile_number'];
    dateOfBirth = json['date_of_birth'];
    profilePicture = json['profile_picture'];
    rut = json['rut'];
    userSessionToken = json['user_session_token'];
    deviceToken = json['device_token'];
    deviceOs = json['device_os'];
    deviceOsVersion = json['device_os_version'];
    deviceModel = json['device_model'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastLoginAt = json['last_login_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['mobile_country_code'] = mobileCountryCode;
    data['mobile_number'] = mobileNumber;
    data['date_of_birth'] = dateOfBirth;
    data['profile_picture'] = profilePicture;
    data['rut'] = rut;
    data['user_session_token'] = userSessionToken;
    data['device_token'] = deviceToken;
    data['device_os'] = deviceOs;
    data['device_os_version'] = deviceOsVersion;
    data['device_model'] = deviceModel;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_login_at'] = lastLoginAt;
    return data;
  }
}

class UserAddress {
  int? id;
  int? userId;
  String? addressLabel;
  String? location;
  String? address;
  String? latitude;
  String? longitude;
  int? isDefaultAddress;
  String? createdAt;
  String? updatedAt;
  String? serviceAreaName;

  UserAddress(
      {this.id,
      this.userId,
      this.addressLabel,
      this.location,
      this.address,
      this.latitude,
      this.longitude,
      this.isDefaultAddress,
      this.createdAt,
      this.serviceAreaName,
      this.updatedAt});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressLabel = json['address_label'];
    location = json['location'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    serviceAreaName = json['service_area_name'];
    isDefaultAddress = json['is_default_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['address_label'] = addressLabel;
    data['location'] = location;
    data['address'] = address;
    data["service_area_name"] = serviceAreaName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_default_address'] = isDefaultAddress;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UserPlan {
  int? id;
  int? userId;
  int? planId;
  int? typeOfPlanId;
  int? userAddressId;
  String? comments;
  String? buyOrder;
  String? cardNumber;
  String? accountingDate;
  String? transactionDate;
  int? amount;
  String? paymentStatus;
  String? authorizationCode;
  String? paymentTypeCode;
  String? commerceCode;
  String? response;
  String? startDate;
  String? endDate;
  String? renewalDate;
  int? isCancel;
  String? createdAt;
  String? updatedAt;
  PlanDetail? planDetail;

  UserPlan(
      {this.id,
      this.userId,
      this.planId,
      this.typeOfPlanId,
      this.userAddressId,
      this.comments,
      this.buyOrder,
      this.cardNumber,
      this.accountingDate,
      this.transactionDate,
      this.amount,
      this.paymentStatus,
      this.authorizationCode,
      this.paymentTypeCode,
      this.commerceCode,
      this.response,
      this.startDate,
      this.endDate,
      this.renewalDate,
      this.isCancel,
      this.createdAt,
      this.updatedAt,
      this.planDetail});

  UserPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    planId = json['plan_id'];
    typeOfPlanId = json['type_of_plan_id'];
    userAddressId = json['user_address_id'];
    comments = json['comments'];
    buyOrder = json['buyOrder'];
    cardNumber = json['cardNumber'];
    accountingDate = json['accountingDate'];
    transactionDate = json['transactionDate'];
    amount = json['amount'];
    paymentStatus = json['payment_status'];
    authorizationCode = json['authorizationCode'];
    paymentTypeCode = json['paymentTypeCode'];
    commerceCode = json['commerceCode'];
    response = json['response'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    renewalDate = json['renewal_date'];
    isCancel = json['is_cancel'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    planDetail = json['plan_detail'] != null
        ? PlanDetail.fromJson(json['plan_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['plan_id'] = planId;
    data['type_of_plan_id'] = typeOfPlanId;
    data['user_address_id'] = userAddressId;
    data['comments'] = comments;
    data['buyOrder'] = buyOrder;
    data['cardNumber'] = cardNumber;
    data['accountingDate'] = accountingDate;
    data['transactionDate'] = transactionDate;
    data['amount'] = amount;
    data['payment_status'] = paymentStatus;
    data['authorizationCode'] = authorizationCode;
    data['paymentTypeCode'] = paymentTypeCode;
    data['commerceCode'] = commerceCode;
    data['response'] = response;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['renewal_date'] = renewalDate;
    data['is_cancel'] = isCancel;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (planDetail != null) {
      data['plan_detail'] = planDetail!.toJson();
    }
    return data;
  }
}

class PlanDetail {
  int? id;
  int? typeOfPlanId;
  String? name;
  String? description;
  int? price;
  String? image;
  String? monthlyServiceOf;
  int? status;
  String? createdAt;
  String? updatedAt;

  PlanDetail({
    this.id,
    this.typeOfPlanId,
    this.name,
    this.description,
    this.price,
    this.image,
    this.monthlyServiceOf,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  PlanDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeOfPlanId = json['type_of_plan_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    monthlyServiceOf = json['monthly_service_of'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type_of_plan_id'] = typeOfPlanId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['monthly_service_of'] = monthlyServiceOf;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
