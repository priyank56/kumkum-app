import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/preference.dart';

class MainController extends GetxController {

  int currentPageViewPos = 0;
  PageController? pageController = PageController(initialPage: 0);

  changePageViewPos(int val) {
    currentPageViewPos = val;
    pageController!.jumpToPage(val);
    // Preference.shared.setBool(Preference.isOpenPageFirstTime,true);
    update();
  }

  changePosFromMain(int val){
    pageController!.jumpToPage(val);
  }


}

