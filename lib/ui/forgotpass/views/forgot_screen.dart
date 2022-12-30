import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/routes/app_pages.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/ui/forgotpass/controllers/forgot_controller.dart';
import 'package:spotify_flutter_code/ui/forgotpass/controllers/forgot_controller.dart';
import 'package:spotify_flutter_code/ui/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_flutter_code/utils/utils.dart';
import '../../../custom/dialog/progressdialog.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotController>(
        id: Constant.isShowProgressUpload,
        builder: (logic) {
          return ProgressDialog(
            child: _forgotPassWidget(context,logic),
            inAsyncCall: logic.isShowProgress,
          );
        });
  }

  _forgotPassWidget(BuildContext context,ForgotController logic){
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ForgotController>(builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Sizes.height_3),
                      child: Image.asset("assets/login_flow/ic_forgot_pass.webp"),
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
                _widgetForgotText(),
                _widgetForgoDesc(),
                _widgetEmailIdEditText(logic),
                _widgetSubmitBtn(logic, context),
              ],
            ),
          );
        }),
      ),
    );
  }

  _widgetForgotText() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
          top: Sizes.height_3, left: Sizes.width_7, right: Sizes.width_7),
      // padding: EdgeInsets.all(Sizes.height_2_5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "txtForgot".tr,
            style: TextStyle(
                color: CColor.black,
                fontSize: FontSize.size_18,
                fontFamily: Constant.appFont,
                fontWeight: FontWeight.w800),
          ),
          Text(
            "${"txtPassword".tr} ?",
            style: TextStyle(
                color: CColor.black,
                fontSize: FontSize.size_18,
                fontFamily: Constant.appFont,
                fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  _widgetForgoDesc() {
    return Container(
      margin: EdgeInsets.only(
          top: Sizes.height_1, left: Sizes.width_7, right: Sizes.width_7),
      alignment: Alignment.centerLeft,
      child: AutoSizeText(
        "txtForgotDesc".tr,
        style: TextStyle(
            color: CColor.grayDark,
            fontSize: FontSize.size_11,
            fontFamily: Constant.appFont,
            fontWeight: FontWeight.w500),
        textAlign: TextAlign.start,
      ),
    );
  }

  _widgetEmailIdEditText(ForgotController logic) {
    return Container(
      margin: EdgeInsets.only(
          left: Sizes.width_7, right: Sizes.width_7, top: Sizes.height_4),
      child: Row(
        children: [
          SvgPicture.asset("assets/svg/login_flow/ic_email.svg"),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: Sizes.width_5),
              child: TextFormField(
                controller: logic.textForgotController,
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

  _widgetSubmitBtn(ForgotController logic, BuildContext context) {
    /*return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.theme,
        onTap: () {
          if(logic.validation(context)!){
            logic.callForgotPassword(context);
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: Sizes.height_5, left: Sizes.width_5, right: Sizes.width_5,bottom: Sizes.height_5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: CColor.theme,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(Sizes.height_1_5),
          child: Text(
            "txtSubmit".tr,
            style: TextStyle(
                color: CColor.white,
                fontSize: FontSize.size_12,
                fontFamily: Constant.appFont,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );*/
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: Sizes.height_5, left: Sizes.width_5, right: Sizes.width_5,bottom: Sizes.height_5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CColor.theme,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // <-- Radius
          ),
          textStyle: TextStyle(
              color: CColor.white,
              fontSize: FontSize.size_12,
              fontFamily: Constant.appFont,
              fontWeight: FontWeight.w500),
        ),
        onPressed: () {
          if(logic.validation(context)!){
            logic.callForgotPassword(context);
          }
        },
        child: Container(
          padding: EdgeInsets.all(Sizes.height_1_5),
          child: Text("txtSubmit".tr,),
        ),
      ),
    );
  }

}
