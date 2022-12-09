import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/utils/debug.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainController extends GetxController {

  int currentPageViewPos = 0;
  PageController? pageController = PageController(initialPage: 0);
  var auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  changePageViewPos(int val) {
    currentPageViewPos = val;
    pageController!.jumpToPage(val);
    // Preference.shared.setBool(Preference.isOpenPageFirstTime,true);
    update();
  }

  changePosFromMain(int val){
    pageController!.jumpToPage(val);
  }

  void logout() {
    Preference.clearLogout();
    auth.signOut();
    googleSignIn.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  User? getUserData(){
   return auth.currentUser;
  }

  @override
  void onInit() {
    super.onInit();
    Debug.printLog("User Data==>> ${getUserData()}");
  }

}

