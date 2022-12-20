import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/connectivitymanager/connectivitymanager.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_flutter_code/utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../custom/validators/email/email_validator.dart';
import '../../../utils/color.dart';
import '../../../utils/debug.dart';
import '../../../utils/sizer_utils.dart';

class SignupController extends GetxController {

  bool isShowProgress = false;
  bool isHidden = true;
  bool isHiddenConfirm = true;
  TextEditingController emailIdEditController = TextEditingController();
  TextEditingController fullNameEditController = TextEditingController();
  TextEditingController passWordEditController = TextEditingController();
  TextEditingController confirmPassEditController = TextEditingController();

  final firebaseAuth = FirebaseAuth.instance;

  void togglePasswordView() {
      isHidden = !isHidden;
      update([Constant.idPassWord]);
  }

  void toggleConfirmPasswordView() {
    isHiddenConfirm = !isHiddenConfirm;
    update([Constant.idPassWord]);
  }

  bool? validation(BuildContext context){
    if(emailIdEditController.text == ""){
      Utils.showToast(context, "txtEnterEmail".tr);
      return false;
    }
    if(!EmailValidator.validate(emailIdEditController.text.trim(), true)){
      Utils.showToast(context, "txtEnterValidEmail".tr);
      return false;
    }
    if(fullNameEditController.text == ""){
      Utils.showToast(context, "txtEnterFullName".tr);
      return false;
    }
    if(passWordEditController.text == ""){
      Utils.showToast(context, "txtEnterPass".tr);
      return false;
    }
    if(confirmPassEditController.text == ""){
      Utils.showToast(context, "txtEnterConfirmPass".tr);
      return false;
    }
    if(passWordEditController.text != confirmPassEditController.text){
      Utils.showToast(context, "txtEnterMatchPass".tr);
      return false;
    }
    if(passWordEditController.text.length < 6 || confirmPassEditController.text.length < 6){
      Utils.showToast(context, "txtEnterInvalidPass".tr);
      return false;
    }
    return true;
  }

  void callSignUp(BuildContext context)async{
    if(await InternetConnectivity.isInternetConnect()){
      isShowProgress= true;
      update([Constant.isShowProgressUpload]);

      try {
       var user = await firebaseAuth.createUserWithEmailAndPassword(
                      email: emailIdEditController.text,
                      password: passWordEditController.text);
       if(user.user != null){
         await firebaseAuth.currentUser!.sendEmailVerification();
         showCustomizeDialogForAddName(context,emailIdEditController.text);
         // Get.offAllNamed(AppRoutes.login);
       }
       Debug.printLog("user==>> Signup $user");
       isShowProgress= false;
       update([Constant.isShowProgressUpload]);

      }  on FirebaseAuthException catch (e) {
        isShowProgress= false;
        update([Constant.isShowProgressUpload]);
        Utils.showToast(context, e.message.toString());
        Debug.printLog("Firebase Error==>> ${e.message}");
      }
    }else{
      Utils.showToast(context, "txtNoInternet".tr);
    }
  }

  showCustomizeDialogForAddName(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            runAlignment: WrapAlignment.center,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: contentBox(context,text),
              ),
            ],
          );
        });
  }

  contentBox(BuildContext context, String text) {
    return GetBuilder<SignupController>(
        id: Constant.idGodNames,
        builder: (logic) {
          return Container(
            margin: EdgeInsets.only(top: Sizes.height_2),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Sizes.width_5),
                  child: Text(
                    "txtVerificationMsg".tr,
                    style: TextStyle(
                        color: CColor.grayDark,
                        fontSize: FontSize.size_12,
                        fontFamily: Constant.appFont,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left:  Sizes.width_3,right:  Sizes.width_3,top: Sizes.height_2),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: CColor.grayDark,
                        fontSize: FontSize.size_12,
                        fontFamily: Constant.appFont,
                        fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Material(
                  color: CColor.transparent,
                  child: InkWell(
                    splashColor: CColor.black,
                    onTap: () async {
                      try {
                        await firebaseAuth.currentUser!.sendEmailVerification();
                        Utils.showToast(context, "txtVerificationMsg".tr);
                      }  on FirebaseAuthException catch (e) {
                        Utils.showToast(context, e.message.toString());
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: Sizes.height_3, left: Sizes.width_7, right: Sizes.width_7),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: FontSize.size_12,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: "${"txtNoGetMail".tr}? "),
                            TextSpan(
                                text: "txtResend".tr.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, color: CColor.theme)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom:Sizes.height_3,top: Sizes.height_3,right: Sizes.width_3,left: Sizes.width_5),
                  child: Material(
                    color: CColor.transparent,
                    child: InkWell(
                      splashColor: CColor.grayDark,
                      onTap: () {
                        Get.offAllNamed(AppRoutes.login);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          right: Sizes.width_2,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.width_4, vertical: Sizes.height_1),
                        decoration: BoxDecoration(
                          color: CColor.grayDark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "txtLogin".tr,
                          style: TextStyle(
                            color: CColor.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: Constant.appFont,
                            fontSize: FontSize.size_12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }


}

