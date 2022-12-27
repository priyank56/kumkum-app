import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spotify_flutter_code/utils/debug.dart';

import '../../../main.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainController extends GetxController {

  int currentPageViewPos = 0;
  PageController? pageController = PageController(initialPage: 0);
  var auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  changePageViewPos(int val) async{
    if(val == 3){
      if (await Permission.contacts.request().isGranted) {
        currentPageViewPos = val;
        pageController!.jumpToPage(val);
      } else if (await Permission.contacts.request().isPermanentlyDenied) {
        showAlertDialogPermission(Get.context!,this);
      } else if (await Permission.contacts.request().isDenied) {
        Get.back();
      }
    }else {
      currentPageViewPos = val;
      pageController!.jumpToPage(val);
    }
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

  void deleteAccount()async{

    ///For Login With Email
    var a =EmailAuthProvider.credential(email: auth.currentUser!.email!, password: "111111");
    var result = await  auth.currentUser!.reauthenticateWithCredential(a);
    await result.user!.delete().then((value) => (){
      Get.offAllNamed(AppRoutes.login);
    });
    ///For Login With Google
    GoogleAuthProvider.credential(idToken: '', accessToken: '');

  }
  User? getUserData(){
   return auth.currentUser;
  }

  showAlertDialogPermission(BuildContext context,MainController logic) {
    // Create button
    Widget okButton = TextButton(
      child: Text("txtOk".tr),
      onPressed: () async {
        await openAppSettings();
      },
    );

    Widget cancelButton = TextButton(
      child: Text("txtCancel".tr),
      onPressed: () {
        Get.back();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("txtPermission".tr),
      content: Text("txtPermissionDesc".tr),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  void onInit() {
    super.onInit();
    Debug.printLog("User Data==>> ${getUserData()}");
    getUserData()!.getIdToken().then((value) => Preference.shared.setString(Preference.accessToken, value));
    // showNotification();
    /*auth.currentUser!.delete().then((value) => (){
      Get.offAllNamed(AppRoutes.login);
    });*/
  }


  showNotification()async{
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(
        "12345",
        "kumkum_app",
        importance: Importance.defaultImportance,
        priority: Priority.max);

    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        12345,
        "KumKum App",
        "PDF Download successfully",
        platformChannelSpecifics,
        payload: '/storage/emulated/0/Download/prebuilt card 1_8cdc71f0.pdf');
  }

}

