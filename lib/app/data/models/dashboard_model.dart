class DashBoardModel {
  bool? success;
  String? message;
  Data? data;

  DashBoardModel({this.success, this.message, this.data});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
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
  int? todayPicked;
  int? todayDeliver;
  int? todayTodayOrder;
  int? allTimePicked;
  int? allTimeDeliver;
  int? allTimeOrder;

  Data(
      {this.todayPicked,
      this.todayDeliver,
      this.todayTodayOrder,
      this.allTimePicked,
      this.allTimeDeliver,
      this.allTimeOrder});

  Data.fromJson(Map<String, dynamic> json) {
    todayPicked = json['today_picked'];
    todayDeliver = json['today_deliver'];
    todayTodayOrder = json['today_today_order'];
    allTimePicked = json['all_time_picked'];
    allTimeDeliver = json['all_time_deliver'];
    allTimeOrder = json['all_time_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['today_picked'] = todayPicked;
    data['today_deliver'] = todayDeliver;
    data['today_today_order'] = todayTodayOrder;
    data['all_time_picked'] = allTimePicked;
    data['all_time_deliver'] = allTimeDeliver;
    data['all_time_order'] = allTimeOrder;
    return data;
  }
}
