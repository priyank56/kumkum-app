import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/ui/login/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<LoginController>(builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: Sizes.height_3),
                  child: Image.asset("assets/login_flow/ic_login.png"),
                ),
                _widgetLoginText(),
                _widgetEmailIdEditText(),
                _widgetPasswordEditText(),
                _widgetForGotPaasText(),
                _widgetLoginButton(logic, context),
                _widgetOrView(),
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

  _widgetEmailIdEditText() {
    return Container(
      margin: EdgeInsets.only(
          left: Sizes.width_7, right: Sizes.width_7, top: Sizes.height_4),
      child: Row(
        children: [
          const Icon(
            Icons.people_alt_rounded,
            color: CColor.grayDark,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: Sizes.width_5),
              child: TextFormField(
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

  _widgetPasswordEditText() {
    return GetBuilder<LoginController>(
        id: Constant.idPassWord,
        builder: (logic) {
          return Container(
            margin: EdgeInsets.only(
                left: Sizes.width_7, right: Sizes.width_7, top: Sizes.height_3),
            child: Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: CColor.grayDark,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: Sizes.width_5),
                    child: TextFormField(
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
          onTap: () {},
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
        onTap: () {},
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
                fontWeight: FontWeight.w600),
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
}
