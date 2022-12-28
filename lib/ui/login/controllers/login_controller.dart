import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import 'package:spotify_flutter_code/utils/preference.dart';

import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../custom/validators/email/email_validator.dart';
import '../../../utils/utils.dart';

class LoginController extends GetxController {
  TextEditingController emailIdEditController = TextEditingController();
  TextEditingController passWordEditController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;
  bool isShowProgress = false;

  bool isHidden = true;

  void togglePasswordView() {
    isHidden = !isHidden;
    update([Constant.idPassWord]);
  }

  bool? validation(BuildContext context) {
    if (emailIdEditController.text == "") {
      Utils.showToast(context, "txtEnterEmail".tr);
      return false;
    }
    if (!EmailValidator.validate(emailIdEditController.text.trim(), true)) {
      Utils.showToast(context, "txtEnterValidEmail".tr);
      return false;
    }
    if (passWordEditController.text == "") {
      Utils.showToast(context, "txtEnterPass".tr);
      return false;
    }

    if (passWordEditController.text.length < 6) {
      Utils.showToast(context, "txtEnterInvalidPass".tr);
      return false;
    }
    return true;
  }

  String? validatePassword(String value) {
    if (passWordEditController.text.length < 6 && value.isNotEmpty) {
      return "txtEnterInvalidPass".tr;
    }
    return null;
  }

  String? validateEmail(String value) {
    if (!EmailValidator.validate(emailIdEditController.text.trim(), true) && value.isNotEmpty) {
      return "txtEnterValidEmail".tr;
    }
    return null;
  }

  void callLogin(BuildContext context) async {
    if (await InternetConnectivity.isInternetConnect()) {
      isShowProgress = true;
      update([Constant.isShowProgressUpload]);
      try {
        var user = await firebaseAuth.signInWithEmailAndPassword(
            email: emailIdEditController.text,
            password: passWordEditController.text);
        isShowProgress = false;
        update([Constant.isShowProgressUpload]);
        if (user.user!.emailVerified) {
          Utils.showToast(context, "txtLoginSuccess".tr);
          user.user!.getIdToken().then((value) => Debug.printLog("Token Login Normal==>> $value"));
          Get.offAllNamed(AppRoutes.main);
          Preference.shared.setBool(Preference.userLogin, true);
        } else {
          Utils.showToast(context, "txtPleaseVerifyMain".tr);
        }
        Debug.printLog("user==>> ${user.toString()}");
      } on FirebaseAuthException catch (e) {
        isShowProgress = false;
        update([Constant.isShowProgressUpload]);
        Debug.printLog("Firebase Error==>> ${e.message}");
        Utils.showToast(context, e.message.toString());
      }
    } else {
      Utils.showToast(context, "txtNoInternet".tr);
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    isShowProgress = true;
    update([Constant.isShowProgressUpload]);
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await firebaseAuth.signInWithCredential(authCredential);
      User? user = result.user;

      isShowProgress = false;
      update([Constant.isShowProgressUpload]);
      if (user!.emailVerified) {
        Utils.showToast(context, "txtLoginSuccess".tr);
        Preference.shared.setBool(Preference.userLogin, true);
        Get.offAllNamed(AppRoutes.main);
      }
      user.getIdToken().then((value) => Debug.printLog("Token Login Google+==>> $value"));
      Debug.printLog("Google User Data==>> ${user.toString()}");
    }else{
      isShowProgress = false;
      update([Constant.isShowProgressUpload]);
    }
  }
}
