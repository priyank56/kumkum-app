import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spotify_flutter_code/ui/addKankotri/controllers/add_kankotri_controller.dart';
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

class AddKankotriScreen extends StatelessWidget {
  const AddKankotriScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AddKankotriController>(builder: (logic) {
          return Container(
            color: CColor.theme,
          );
        }),
      ),
    );
  }
}
