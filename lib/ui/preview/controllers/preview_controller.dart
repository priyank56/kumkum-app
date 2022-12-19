import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/ui/preview/datamodel/functionUploadData.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';

import '../../addKankotri/controllers/add_kankotri_controller.dart';

class PreviewController extends GetxController {

  bool isShowProgress = false;
  String selectedSendWp = "";
  String displayDefaultVal = "";
  bool isAdvanceEnabled = false;

  final List<OptionsClass> listPersons = [];
  List<FunctionPreview>? functionsUploadList = [];

  String? selectedValue;

  // List<String> listTitle = [];
  List<PreviewFunctions> functionStringTitleList = [];

  CreateData createData = CreateData();
  dynamic argument = Get.arguments;


  changeAdvanced(){
    isAdvanceEnabled = !isAdvanceEnabled;
    update([Constant.idAllButton]);
  }

  changeDropDownValue(String value, int index){
    // selectedValue = value;
    listPersons[listPersons.indexOf(listPersons[index])].selectedValue = value;
    functionStringTitleList[functionStringTitleList.indexOf(functionStringTitleList[index])].fPerson = value;
    update([Constant.idAllButton]);
  }

  changeDefaultOption(String value){
    selectedSendWp = value;
    if(value == Constant.selectedSendWpSarvo){
      displayDefaultVal = "txtSarvo".tr;
    }else if(value == Constant.selectedSendWpSajode){
      displayDefaultVal = "txtSajode".tr;
    }else if(value == Constant.selectedSendWp1Person){
      displayDefaultVal = "txtAppShri".tr;
    }
    addDropDownMenuData(regenerateData: true,value: displayDefaultVal);
    update([Constant.idAllButton]);
  }

  changeProgressValue(bool value){
    isShowProgress = value;
    update();
  }

  addDropDownMenuData({bool regenerateData = false,String? value = ""}){
    if(regenerateData){
      listPersons.clear();
      /*if(argument[1] != null){
        functionStringTitleList = argument[1];
        Debug.printLog("listTitle==>> Preview==>> $functionStringTitleList");
      }*/
    }

    for(int i =0 ; i<functionStringTitleList.length;i++){
      if(regenerateData){
        listPersons.add(OptionsClass(functionStringTitleList[i].fId.toString(), value,
            ['txtSarvo'.tr, 'txtSajode'.tr, 'txtAppShri'.tr]));
      }else {
        listPersons.add(OptionsClass(functionStringTitleList[i].fId.toString(), 'txtSarvo'.tr,
            ['txtSarvo'.tr, 'txtSajode'.tr, 'txtAppShri'.tr]));
      }
    }
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
      if(argument[1] != null){
        functionStringTitleList = argument[1];
        Debug.printLog("listTitle==>> Preview==>> $functionStringTitleList");
      }
    }
    selectedSendWp = Constant.selectedSendWpSarvo;
    displayDefaultVal = "txtSarvo".tr;
    addDropDownMenuData();

    update();
  }

  clearAddData(){
    Debug.printLog("Clear Data==>> ");
    selectedSendWp = Constant.selectedSendWpSarvo;
    displayDefaultVal = "txtSarvo".tr;
    isAdvanceEnabled = false;
    update([Constant.idAllButton]);
  }

  void generateUploadFunctionsData() {
    if(functionsUploadList!.isNotEmpty){
      functionsUploadList!.clear();
    }
    for(int i = 0 ;i< functionStringTitleList.length;i++){
      functionsUploadList!.add(FunctionPreview(
          functionsId: functionStringTitleList[i].fId,
          banquetPerson: functionStringTitleList[i].fPerson));
    }
    var previewData = FunctionUploadData();
    previewData.functions = functionsUploadList;

    Debug.printLog("functionsUploadList===>> $functionsUploadList  ${previewData.toJson()}  ${jsonEncode(previewData)}");

  }
}


class OptionsClass{
  String? title;
  String? selectedValue;
  List<String>? strValue = [];

  OptionsClass(this.title,this.selectedValue,this.strValue);
}
