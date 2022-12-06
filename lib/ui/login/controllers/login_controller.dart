import 'package:get/get.dart';
import 'package:spotify_flutter_code/utils/constant.dart';

class LoginController extends GetxController {

  bool isHidden = false;

  void togglePasswordView() {
      isHidden = !isHidden;
      update([Constant.idPassWord]);
  }

}

