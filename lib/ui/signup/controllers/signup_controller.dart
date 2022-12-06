import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/utils/constant.dart';

class SignupController extends GetxController {

  bool isHidden = false;
  bool isHiddenConfirm = false;
  TextEditingController emailIdEditController = TextEditingController();
  TextEditingController fullNameEditController = TextEditingController();
  TextEditingController passWordEditController = TextEditingController();
  TextEditingController confirmPassEditController = TextEditingController();

  void togglePasswordView() {
      isHidden = !isHidden;
      update([Constant.idPassWord]);
  }

  void toggleConfirmPasswordView() {
    isHiddenConfirm = !isHiddenConfirm;
    update([Constant.idPassWord]);
  }


}

