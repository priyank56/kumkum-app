import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/preference.dart';
import 'package:spotify_flutter_code/utils/sizer_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Utils{
  static showToast(BuildContext context, String msg) {
    return Fluttertoast.showToast(
      msg: msg,
    );
  }

  static bool isFirstTime() {
    return Preference.shared.getBool(Preference.isFirstTime) ?? true;
  }

  static String getSelectedLanguage() {
    return Preference.shared.getString(Preference.selectedLanguage) ??
        Constant.languageEn;
  }

  /*static bool isLogin() {
    var accessToken = Preference.shared.getString(Preference.accessToken);
    return (accessToken != null && accessToken.isNotEmpty);
  }*/

  static bool isLogin() {
    return Preference.shared.getBool(Preference.userLogin)  ?? false;
  }

  static double getAddKankotriHeight(){
    return Sizes.height_6;
  }



}