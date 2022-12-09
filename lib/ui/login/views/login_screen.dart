import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/ui/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '../../../custom/dialog/progressdialog.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        id: Constant.isShowProgressUpload,
        builder: (logic) {
          return ProgressDialog(
            child: _loginWidget(context,logic),
            inAsyncCall: logic.isShowProgress,
          );
        });
  }
  _loginWidget(BuildContext context,LoginController logic){
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<LoginController>(builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: Sizes.height_3),
                  child: Image.asset("assets/login_flow/ic_login.webp"),
                ),
                _widgetLoginText(),
                _widgetEmailIdEditText(logic),
                _widgetPasswordEditText(logic),
                _widgetForGotPaasText(),
                _widgetLoginButton(logic, context),
                _widgetOrView(),
                _widgetGoogleButton(logic, context),
                _widgetRegisterText(logic, context),
              ],
            ),
          );
        }),
      ),
    );
  }

  _widgetLoginText() {
    return Container(
      margin: EdgeInsets.only(
          top: Sizes.height_5, left: Sizes.width_7, right: Sizes.width_7),
      // padding: EdgeInsets.all(Sizes.height_2_5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "txtLogin".tr,
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

  _widgetEmailIdEditText(LoginController logic) {
    return Container(
      margin: EdgeInsets.only(
          left: Sizes.width_7, right: Sizes.width_7, top: Sizes.height_4),
      child: Row(
        children: [
          /*const Icon(
            Icons.people_alt_rounded,
            color: CColor.grayDark,
          ),*/
          SvgPicture.asset("assets/svg/login_flow/ic_email.svg"),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: Sizes.width_5),
              child: TextFormField(
                controller: logic.emailIdEditController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: CColor.theme,
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
  }

  _widgetPasswordEditText(LoginController logic) {
    return GetBuilder<LoginController>(
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

  _widgetForGotPaasText() {
    return Container(
      alignment: Alignment.centerRight,
      child: Material(
        color: CColor.transparent,
        child: InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.forgotPass);
          },
          splashColor: CColor.theme,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 200.0,
              maxWidth: 200.0,
            ),
            child: Container(
              margin:
                  EdgeInsets.only(top: Sizes.height_2_5, right: Sizes.width_6),
              child: Text(
                "${"txtForgotPass".tr}?",
                style: TextStyle(
                    color: CColor.theme,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.size_12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _widgetLoginButton(LoginController logic, BuildContext context) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.theme,
        onTap: () {
          if(logic.validation(context)!) {
            logic.callLogin(context);
          }
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
            "txtLogin".tr,
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

  _widgetOrView() {
    return Container(
      margin: EdgeInsets.only(
          left: Sizes.width_5, right: Sizes.width_5, top: Sizes.height_3),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              thickness: 2,
              color: CColor.grayEF,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
            child: Text(
              "txtOr".tr.toUpperCase(),
              style: const TextStyle(color: CColor.grayDark),
            ),
          ),
          const Expanded(
            child: Divider(
              thickness: 2,
              color: CColor.grayEF,
            ),
          ),
        ],
      ),
    );
  }

  _widgetGoogleButton(LoginController logic, BuildContext context) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.grayEF,
        onTap: () {
          logic.loginWithGoogle(context);
        },
        child: Container(
          margin: EdgeInsets.only(
              top: Sizes.height_3, left: Sizes.width_5, right: Sizes.width_5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: CColor.grayEF,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(Sizes.height_1_5),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: Sizes.width_5),
                child: Image.asset(
                  "assets/login_flow/ic_google.png",
                  height: Sizes.width_7,
                  width: Sizes.width_7,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "txtLoginWithGoogle".tr,
                  style: TextStyle(
                      color: CColor.black,
                      fontSize: FontSize.size_12,
                      fontFamily: Constant.appFont,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _widgetRegisterText(LoginController logic, BuildContext context) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.black,
        onTap: () {
          Get.toNamed(AppRoutes.signUp);
        },
        child: Container(
          margin: EdgeInsets.only(top: Sizes.height_3_5,bottom: Sizes.height_5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "txtNewLogin".tr,
                style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_12,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              Text(
                " ${"txtRegister".tr}",
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
}
