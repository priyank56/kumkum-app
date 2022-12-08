import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/preference.dart';
import 'package:spotify_flutter_code/utils/sizer_utils.dart';


class Utils{
  static showToast(BuildContext context, String msg) {
    return Fluttertoast.showToast(
      msg: "This is toast",
    );
  }

  static bool isFirstTime() {
    return Preference.shared.getBool(Preference.isFirstTime) ?? true;
  }

  static String getSelectedLanguage() {
    return Preference.shared.getString(Preference.selectedLanguage) ??
        Constant.languageEn;
  }

  static bool isLogin() {
    var accessToken = Preference.shared.getString(Preference.accessToken);
    return (accessToken != null && accessToken.isNotEmpty);
  }
  static double getAddKankotriHeight(){
    return Sizes.height_6;
  }
  //Check contacts permission

}