import 'package:get/get.dart';
import 'package:spotify_flutter_code/utils/constant.dart';

class ContactController extends GetxController {

  int currentPos = 1;
  String selectedSendWp = Constant.selectedSendWpSarvo;
  bool isCheck = false;


  changeBottomViewPos(int pos){
    currentPos = pos;
    update([Constant.idNextPrevious,Constant.idBottomText,Constant.idBottomViewPos,Constant.idMainPage,]);
  }

  changeSendOption(String value){
    selectedSendWp = value;
    update([Constant.idBottomViewPos]);
  }

  changeCheckValue(bool value){
    isCheck = !isCheck;
    update([Constant.idBottomViewPos,Constant.idMainPage]);
  }
}

