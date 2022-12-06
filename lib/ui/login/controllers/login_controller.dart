import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/utils/constant.dart';

class LoginController extends GetxController {


  TextEditingController emailIdEditController = TextEditingController();
  TextEditingController passWordEditController = TextEditingController();


  bool isHidden = false;

  void togglePasswordView() {
      isHidden = !isHidden;
      update([Constant.idPassWord]);
  }


}

