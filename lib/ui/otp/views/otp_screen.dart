import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spotify_flutter_code/ui/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/otp/controllers/otp_controller.dart';
import 'package:spotify_flutter_code/ui/otp/controllers/otp_controller.dart';
import 'package:spotify_flutter_code/ui/otp/controllers/otp_controller.dart';
import 'package:spotify_flutter_code/ui/otp/controllers/otp_controller.dart';
import 'package:spotify_flutter_code/ui/signup/controllers/signup_controller.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<OtpController>(builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Sizes.height_3),
                      child: Image.asset("assets/login_flow/ic_enter_otp.webp"),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.all(Sizes.height_2),
                        child: SvgPicture.asset("assets/svg/login_flow/ic_back.svg",height: Sizes.height_4,width: Sizes.height_4,),
                      ),
                    ),
                  ],
                ),
                _widgetOTPText(),
                _widgetOTPDesc(),
                _widgetFillPinCode(context),
                _widgetDidNotGetText(),
                _widgetRegisterBtn(logic, context),
              ],
            ),
          );
        }),
      ),
    );
  }

  _widgetOTPText() {
    return Container(
      margin: EdgeInsets.only(
          top: Sizes.height_5, left: Sizes.width_7, right: Sizes.width_7),
      // padding: EdgeInsets.all(Sizes.height_2_5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "txtEnterOtp".tr,
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

  _widgetOTPDesc() {
    return Container(
      margin: EdgeInsets.only(
          top: Sizes.height_1, left: Sizes.width_7, right: Sizes.width_7),
      alignment: Alignment.centerLeft,
      child: AutoSizeText(
        "txtOtpDescDome".tr,
        style: TextStyle(
            color: CColor.grayDark,
            fontSize: FontSize.size_11,
            fontFamily: Constant.appFont,
            fontWeight: FontWeight.w500),
        textAlign: TextAlign.start,
      ),
    );
  }


  _widgetRegisterBtn(OtpController logic, BuildContext context) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.theme,
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(
              top: Sizes.height_3, left: Sizes.width_5, right: Sizes.width_5,bottom: Sizes.height_3),
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
    );
  }

  _widgetDidNotGetText() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
          top: Sizes.height_3, left: Sizes.width_7, right: Sizes.width_7),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: FontSize.size_12,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(text: "${"txtNoGet".tr} "),
            TextSpan(
                text: "txtResend".tr.toUpperCase(),
                style: const TextStyle(
                    fontWeight: FontWeight.w700, color: CColor.theme)),
          ],
        ),
      ),
    );
  }

  _widgetFillPinCode(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Sizes.width_6,right: Sizes.width_6,top: Sizes.height_4),
      child: PinCodeTextField(
        backgroundColor: CColor.white,
        appContext: context,
        /*pastedTextStyle: const TextStyle(
          color: CColor.white,
          fontWeight: FontWeight.w700,
        ),*/
        length: 6,
        obscureText: false,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          selectedColor: CColor.white,
          activeColor: CColor.white,
          selectedFillColor: CColor.white,
          disabledColor: CColor.white,
          errorBorderColor: CColor.white,
          inactiveColor: CColor.white,
          inactiveFillColor: CColor.white,
        ),
        cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        // errorAnimationController: errorController,
        // controller: textEditingController,
        keyboardType: TextInputType.number,
        boxShadows: const [
          BoxShadow(
            offset: Offset(0, 0),
            color: Colors.black,
            blurRadius: 1,
          )
        ],
        onCompleted: (v) {
          debugPrint("Completed==>> $v");
        },
        // onTap: () {
        //   print("Pressed");
        // },
        onChanged: (value) {
          debugPrint(value);
        },
        beforeTextPaste: (text) {
          debugPrint("Allowing to paste $text");
          return true;
        },
      ),
    );
  }
}
