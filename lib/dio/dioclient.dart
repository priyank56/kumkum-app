import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/preference.dart';

import '../utils/debug.dart';

class DioClient {
  var cancelToken = CancelToken();
  var dio = Dio(
    BaseOptions(
      connectTimeout: 20000,
      receiveTimeout: 20000,
      baseUrl: getBaseURL(),
    ),

  );

  DioClient(BuildContext? context, {bool isMultipart = false,bool isPassAuth = false}) {
    var header = Preference.shared.getString(Preference.accessToken) ?? "";
    Debug.printLog("headerheader==>>> $header");
    // dio.interceptors.add(AppInterceptors(context));
    dio.interceptors.add(AppInterceptors());
    dio.options.headers = {
      'Content-Type': !isMultipart
          ? 'application/json'
          : 'multipart/form-data',
      // 'Content-Type': 'application/json',
      'Accept': 'application/json',
      'requiresToken': '',
      if(isPassAuth && header != "")
      'Authorization': "Bearer $header",
    };
  }
}

String getBaseURL() {
  return Constant.getMainURL();
}

class AppInterceptors extends Interceptor {
 /* BuildContext context;

  AppInterceptors(this.context);*/


  AppInterceptors();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Debug.printLog("On Request ==>> ");
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Debug.printLog("On DioError ==>> ${err.message}");
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Debug.printLog("On Response ==>> ");
    super.onResponse(response, handler);
  }
}
