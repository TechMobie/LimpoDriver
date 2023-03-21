import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../helper/utils/pref_utils.dart';
import '../../../routes/app_pages.dart';

class ApiMethodType {
  static const String post = "POST";
  static const String patch = "PATCH";
  static const String get = "GET";
  static const String put = "PUT";
  static const String delete = "DELETE";
}

class ApiService {
  static Future getRequest(
    String endpoint, {
    Object? query,
  }) async {
    return await ApiServiceMethods()
        .makeApiCall(endpoint, ApiMethodType.get, params: query);
  }

  static Future postRequest(
    String endpoint, {
    Object? body,
  }) async {
    return await ApiServiceMethods()
        .makeApiCall(endpoint, ApiMethodType.post, params: body);
  }

  static Future putRequest(
    String endpoint, {
    Object? body,
  }) async {
    return await ApiServiceMethods()
        .makeApiCall(endpoint, ApiMethodType.put, params: body);
  }

  static Future deleteRequest(
    String endpoint, {
    Object? query,
  }) async {
    return await ApiServiceMethods()
        .makeApiCall(endpoint, ApiMethodType.delete, params: query);
  }
}

class ApiServiceMethods extends GetConnect {
  Future getRequest(String endpoint, {Object? query}) async {
    return await makeApiCall(endpoint, ApiMethodType.get, params: query);
  }

  Future postRequest(String endpoint, {Object? body}) async {
    return await makeApiCall(endpoint, ApiMethodType.post, params: body);
  }

  Future putRequest(String endpoint, {Object? body}) async {
    return await makeApiCall(endpoint, ApiMethodType.put, params: body);
  }

  Future deleteRequest(String endpoint, {Object? query}) async {
    return await makeApiCall(endpoint, ApiMethodType.delete, params: query);
  }

  Future makeApiCall(
    String baseUrl,
    String method, {
    Object? params,
    Map<String, dynamic>? headers,
  }) async {
    //For charles proxy
    Response? response;
    // String proxy = '192.168.29.142:8888';
    // HttpClient httpClient = HttpClient();
    // httpClient.findProxy = (uri) {
    //   return "PROXY $proxy;";
    // };

    //WITH PROXY
    // IOClient myClient = IOClient(httpClient);

    //WITHOUT PROXY
    // IOClient myClient = IOClient();

    // HEADER
    Map<String, String> commonHeader = <String, String>{};

    if (PrefUtils.getInstance.isUserLogin()) {
      if (kDebugMode) {
        print(PrefUtils.getInstance.readData(
          PrefUtils.getInstance.accessToken,
        ));
      }
      commonHeader['token'] = PrefUtils.getInstance.readData(
        PrefUtils.getInstance.accessToken,
      );
      commonHeader['Content-Type'] = "application/json";
      commonHeader['Accept'] = "application/json";
    }

    if (method == ApiMethodType.post) {
      response = await post(
        baseUrl,
        params,
        headers: commonHeader,
      );
    } else if (method == ApiMethodType.get) {
      response = await get(
        baseUrl, headers: commonHeader,
        // query: params,
      );
    } else if (method == ApiMethodType.put) {
      response = await put(
        baseUrl,
        params,
        headers: commonHeader,
      );
    } else if (method == ApiMethodType.delete) {
      response = await delete(
        baseUrl,
        headers: commonHeader,
      );
    }
    String message = "";
    bool success = false;
    var decodedResponse = response!.body;
    message = decodedResponse['message'] ?? "";
    success = decodedResponse['success'];
    // int statuscode = decodedResponse['code'];
    if (success == true) {
      return response.body;
    } else if (message == "Login Expired" ||
        (response.body?["error"] ?? "") == "Login Expired") {
      PrefUtils.getInstance.clearLocalStorage();

      Get.offAllNamed(Routes.signIn);
    } else {
      return response.body;
    }
  }
}
