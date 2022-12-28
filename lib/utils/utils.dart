import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/preference.dart';
import 'package:spotify_flutter_code/utils/sizer_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'color.dart';
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

  static String translateMobileNumber(String mobileNumber) {
    var mobileNumberTrim = mobileNumber.toString();
    var translatedNumber = '';
    var currentLan = 'gu';
    for (int i = 0; i < mobileNumberTrim.length; i++) {
      switch (mobileNumberTrim[i]) {
        case '0':
          translatedNumber =
          currentLan == 'gu' ? '$translatedNumber૦' : '$translatedNumber૦';
          break;
        case '1':
          translatedNumber =
          currentLan == 'gu' ? '$translatedNumber૧' : '$translatedNumber१';
          break;
        case '2':
          translatedNumber =
          currentLan == 'gu' ? '$translatedNumber૨' : '$translatedNumber२';
          break;
        case '3':
          translatedNumber =
          currentLan == 'gu' ? '$translatedNumber૩' : '$translatedNumber३';
          break;
        case '4':
          translatedNumber =
          currentLan == 'gu' ? '$translatedNumber૪' : '$translatedNumber४';
          break;
        case '5':
          translatedNumber =
          currentLan == 'gu' ? '$translatedNumber૫' : '$translatedNumber५';
          break;
        case '6':
          translatedNumber =
          currentLan == 'gu' ? '$translatedNumber૬' : '$translatedNumber६';
          break;
        case '7':
          translatedNumber =
          currentLan == 'gu' ? '$translatedNumber૭' : '$translatedNumber७';
          break;
        case '8':
          translatedNumber =
          currentLan == 'gu' ? '$translatedNumber૮' : '$translatedNumber८';
          break;
        case '9':
          translatedNumber =
          currentLan == 'gu' ? '$translatedNumber૯' : '$translatedNumber९';
          break;
        case '-':
          translatedNumber = '$translatedNumber-';
          break;
        case ':':
          translatedNumber = '$translatedNumber:';
          break;
      }
    }
    return translatedNumber;
  }

  static List<String> getOtherTitlesList(){
    List<String> listOfAllOtherTitles = [];
    listOfAllOtherTitles.add("શ્રી");
    listOfAllOtherTitles.add("અ.સૌ.");
    listOfAllOtherTitles.add("ગં.સ્વ.");
    listOfAllOtherTitles.add("સ્વ.");
    listOfAllOtherTitles.add("કુ.");
    listOfAllOtherTitles.add("ચિ.");
    return listOfAllOtherTitles;
  }

  static String getDefaultSelectedTitle(){
    return "શ્રી";
  }

  static Widget bgShimmer(BuildContext context){
    return Shimmer.fromColors(
      baseColor: CColor.white50,
      highlightColor: CColor.black10,
      child: Container(
        height: Sizes.height_15,
        width: MediaQuery.of(context).size.width * 0.55,
        color: Colors.black,
      ),
    );
  }
}