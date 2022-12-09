import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../custom/validators/email/email_validator.dart';
import '../../../utils/debug.dart';
import '../../../utils/utils.dart';

class ForgotController extends GetxController {

  bool isHidden = false;
  bool isShowProgress = false;

  TextEditingController textForgotController = TextEditingController();
  var firebaseAuth = FirebaseAuth.instance;
  void togglePasswordView() {
      isHidden = !isHidden;
      update([Constant.idPassWord]);
  }


  bool? validation(BuildContext context){
    if(textForgotController.text == ""){
      Utils.showToast(context, "txtEnterEmail".tr);
      return false;
    }
    if(!EmailValidator.validate(textForgotController.text.trim(), true)){
      Utils.showToast(context, "txtEnterValidEmail".tr);
      return false;
    }
    return true;
  }



  void callForgotPassword(BuildContext context)async{
    if(await InternetConnectivity.isInternetConnect()){
      isShowProgress= true;
      update([Constant.isShowProgressUpload]);
      try {
        await firebaseAuth
            .sendPasswordResetEmail(
            email: textForgotController.text);
        Utils.showToast(context, "txtMailSent".tr);
        Get.offAllNamed(AppRoutes.login);
        isShowProgress= false;
        update([Constant.isShowProgressUpload]);
      } on FirebaseAuthException catch (e) {
        isShowProgress= false;
        update([Constant.isShowProgressUpload]);
        Debug.printLog("Firebase Error==>> ${e.message}");
        Utils.showToast(context, e.message.toString());
      }

    }else{
      Utils.showToast(context, "txtNoInternet".tr);
    }
  }
}

