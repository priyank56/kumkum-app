import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/utils/color.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:spotify_flutter_code/utils/sizer_utils.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class InternetConnectivity {
  // ------------------ SINGLETON -----------------------
  static final InternetConnectivity _internetConnectivity =
      InternetConnectivity._internal();

  factory InternetConnectivity() {
    return _internetConnectivity;
  }

  InternetConnectivity._internal();

  static InternetConnectivity get shared => _internetConnectivity;

  static Connectivity? _connectivity;

  /* make connection with preference only once in application */
  Future<Connectivity?> instance() async {
    if (_connectivity != null) return _connectivity;

    _connectivity = Connectivity();

    return _connectivity;
  }

  static Future<ConnectivityResult> getStatus() {
    return _connectivity!.checkConnectivity();
  }

  static Future<bool> isInternetConnect() async {
    ConnectivityResult result = await getStatus();

    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  static Future isInternetAvailable(BuildContext context,
      {required Function success,
      required Function cancel,
      required Function retry}) async {
    ConnectivityResult result = await getStatus();

    if (result != ConnectivityResult.none) {
      success();
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text("No Internet Connection"),
          title: Text(
            "noInternetConnection".tr,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: CColor.black,
                fontSize: FontSize.size_16),
          ),
          content: Text(
            "descNoInternetConnection".tr,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: CColor.black,
              fontSize: FontSize.size_14,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "cancel".tr,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: CColor.black,
                  fontSize: FontSize.size_14,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                cancel();
              },
            ),
            TextButton(
              child: Text(
                "retry".tr,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: CColor.black,
                  fontSize: FontSize.size_14,
                ),
              ),
              onPressed: () async {
                Navigator.pop(context);
                retry();
              },
            ),
          ],
        );
      },
    );
  }
}
