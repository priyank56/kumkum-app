import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/routes/app_pages.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/ui/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/signup/controllers/signup_controller.dart';
import 'package:flutter_svg/svg.dart';
import '../../../custom/dialog/progressdialog.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import '../../../utils/utils.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
        id: Constant.isShowProgressUpload,
        builder: (logic) {
      return ProgressDialog(
        child: _signUpWidget(context,logic),
        inAsyncCall: logic.isShowProgress,
      );
    });
  }

  _signUpWidget(BuildContext context,SignupController logic){
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SignupController>(builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Sizes.height_3),
                      child: Image.asset("assets/login_flow/ic_sign_up.webp"),
                    ),
                    Material(
                      color: CColor.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        splashColor: CColor.black,
                        child: Container(
                          margin: EdgeInsets.all(Sizes.height_2),
                          child: SvgPicture.asset("assets/svg/login_flow/ic_back.svg",height: Sizes.height_4,width: Sizes.height_4,),
                        ),
                      ),
                    ),
                  ],
                ),
                _widgetRegisterText(),
                _widgetEmailIdEditText(),
                _widgetFullNameEditText(),
                _widgetPasswordEditText(),
                _widgetConfirmPasswordEditText(),
                _widgetTermsCondition(),
                _widgetRegisterBtn(logic, context),
                _widgetLoginText(logic, context),
              ],
            ),
          );
        }),
      ),
    );
  }

  _widgetRegisterText() {
    return Container(
      margin: EdgeInsets.only(
          top: Sizes.height_3, left: Sizes.width_7, right: Sizes.width_7),
      // padding: EdgeInsets.all(Sizes.height_2_5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "txtRegister".tr,
            style: TextStyle(
                color: CColor.black,
                fontSize: FontSize.size_18,
                fontFamily: Constant.appFont,
                fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _widgetEmailIdEditText() {
    return GetBuilder<SignupController>(
        id: Constant.idEmailEdit,
        builder: (logic) {
          return Container(
            margin: EdgeInsets.only(
                left: Sizes.width_7, right: Sizes.width_7, top: Sizes.height_2),
            child: Row(
              children: [
                /* const Icon(
              Icons.people_alt_rounded,
              color: CColor.grayDark,
            ),*/
                SvgPicture.asset("assets/svg/login_flow/ic_email.svg"),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: Sizes.width_5),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: CColor.theme,
                      controller: logic.emailIdEditController,
                      decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: CColor.theme),
                          ),
                          hintText: "txtEmailId".tr,
                          hintStyle: const TextStyle(color: CColor.grayDark)),
                      style: const TextStyle(
                        fontFamily: Constant.appFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _widgetFullNameEditText() {
    return GetBuilder<SignupController>(
        id: Constant.idFullNameEdit,
        builder: (logic) {
          return Container(
            margin: EdgeInsets.only(
                left: Sizes.width_7, right: Sizes.width_7, top: Sizes.height_4),
            child: Row(
              children: [
                /*const Icon(
              Icons.people_alt_rounded,
              color: CColor.grayDark,
            ),*/
                SvgPicture.asset("assets/svg/login_flow/ic_fullName.svg"),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: Sizes.width_5),
                    child: TextFormField(
                      controller: logic.fullNameEditController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: CColor.theme,
                      decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: CColor.theme),
                          ),
                          hintText: "txtFullName".tr,
                          hintStyle: const TextStyle(color: CColor.grayDark)),
                      style: const TextStyle(
                        fontFamily: Constant.appFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _widgetPasswordEditText() {
    return GetBuilder<SignupController>(
        id: Constant.idPassWord,
        builder: (logic) {
          return Container(
            margin: EdgeInsets.only(
                left: Sizes.width_7, right: Sizes.width_7, top: Sizes.height_3),
            child: Row(
              children: [
                /*const Icon(
                  Icons.lock,
                  color: CColor.grayDark,
                ),*/
                SvgPicture.asset("assets/svg/login_flow/ic_password.svg"),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: Sizes.width_5),
                    child: TextFormField(
                      controller: logic.passWordEditController,
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: CColor.theme,
                      obscureText: logic.isHidden,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: CColor.theme), //<-- SEE HERE
                        ),
                        hintText: "txtPassword".tr,
                        hintStyle: const TextStyle(color: CColor.grayDark),
                        focusColor: CColor.theme,
                        hoverColor: CColor.theme,
                        suffix: InkWell(
                          onTap: () {
                            logic.togglePasswordView();
                          },
                          child: Icon(
                            logic.isHidden
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: Constant.appFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _widgetConfirmPasswordEditText() {
    return GetBuilder<SignupController>(
        id: Constant.idPassWord,
        builder: (logic) {
          return Container(
            margin: EdgeInsets.only(
                left: Sizes.width_7, right: Sizes.width_7, top: Sizes.height_3),
            child: Row(
              children: [
                SvgPicture.asset("assets/svg/login_flow/ic_password.svg"),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: Sizes.width_5),
                    child: TextFormField(
                      controller: logic.confirmPassEditController,
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: CColor.theme,
                      obscureText: logic.isHiddenConfirm,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: CColor.theme), //<-- SEE HERE
                        ),
                        hintText: "txtConfirmPass".tr,
                        hintStyle: const TextStyle(color: CColor.grayDark),
                        focusColor: CColor.theme,
                        hoverColor: CColor.theme,
                        suffix: InkWell(
                          onTap: () {
                            logic.toggleConfirmPasswordView();
                          },
                          child: Icon(
                            logic.isHiddenConfirm
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: Constant.appFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _widgetRegisterBtn(SignupController logic, BuildContext context) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.theme,
        onTap: () {
          if(logic.validation(context)!){
            logic.callSignUp(context);
          }
          // Get.toNamed(AppRoutes.otp);
        },
        child: Container(
          margin: EdgeInsets.only(
              top: Sizes.height_3, left: Sizes.width_5, right: Sizes.width_5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: CColor.theme,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(Sizes.height_1_5),
          child: Text(
            "txtRegister".tr,
            style: TextStyle(
                color: CColor.white,
                fontSize: FontSize.size_12,
                fontFamily: Constant.appFont,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  _widgetLoginText(SignupController logic, BuildContext context) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.black,
        onTap: () {
          Get.back();
        },
        child: Container(
          margin:
              EdgeInsets.only(top: Sizes.height_3_5, bottom: Sizes.height_5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "txtJoinBefore".tr,
                style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_12,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              Text(
                " ${"txtLogin".tr}",
                style: TextStyle(
                    color: CColor.theme,
                    fontSize: FontSize.size_12,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _widgetTermsCondition() {
    return Container(
      margin: EdgeInsets.only(
          top: Sizes.height_3_5, left: Sizes.width_7, right: Sizes.width_7),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: FontSize.size_10,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(text: "txtTermsDesc1".tr),
            TextSpan(
                text: "txtTermsDesc2".tr,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, color: CColor.theme)),
          ],
        ),
      ),
    );
  }




}
