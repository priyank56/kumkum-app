import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';

class PreviewController extends GetxController {

  bool isShowProgress = false;
  String selectedSendWp = "";
  String displayDefaultVal = "";
  bool isAdvanceEnabled = false;

  final List<String> listPersons = [];

  String? selectedValue;

  List<String> listTitle = [];
  CreateData createData = CreateData();
  dynamic argument = Get.arguments;


  changeAdvanced(){
    isAdvanceEnabled = !isAdvanceEnabled;
    update([Constant.idAllButton]);
  }

  changeDropDownValue(String value){
    selectedValue = value;
    update([Constant.idAllButton]);
  }

  changeDefaultOption(String value){
    selectedSendWp = value;
    if(value == Constant.selectedSendWpSarvo){
      displayDefaultVal = "txtSarvo".tr;
    }else if(value == Constant.selectedSendWpSajode){
      displayDefaultVal = "txtSajode".tr;
    }else if(value == Constant.selectedSendWp1Person){
      displayDefaultVal = "txt1".tr;
    }
    update([Constant.idAllButton]);
  }

  changeProgressValue(bool value){
    isShowProgress = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    isShowProgress = true;
    if(argument != null){
      if(argument[0] != null){
        createData = argument[0];
        Debug.printLog("createData==>> Preview==>> ${jsonEncode(createData)}");
      }
    }
    selectedSendWp = Constant.selectedSendWpSarvo;
    displayDefaultVal = "txtSarvo".tr;

    listTitle.add("txtJan".tr);
    listTitle.add("txtGitSandhya".tr);
    listTitle.add("txtBhojan".tr);
    listTitle.add("txtMadapMuhrat".tr);
    listTitle.add("txtRasGarba".tr);
    listTitle.add("txtHastMelap".tr);

    listPersons.add('txtSarvo'.tr,);
    listPersons.add('txtSajode'.tr,);
    listPersons.add('txt1'.tr,);
    update();
  }

  clearAddData(){
    Debug.printLog("Clear Data==>> ");
    selectedSendWp = Constant.selectedSendWpSarvo;
    displayDefaultVal = "txtSarvo".tr;
    isAdvanceEnabled = false;
    update([Constant.idAllButton]);
  }
}

