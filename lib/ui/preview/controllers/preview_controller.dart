import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/ui/preview/datamodel/downloadPdfData.dart';
import 'package:spotify_flutter_code/ui/preview/datamodel/downloadPdfDatamodel.dart';
import 'package:spotify_flutter_code/ui/preview/datamodel/functionUploadData.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';

import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../utils/utils.dart';
import '../../addKankotri/controllers/add_kankotri_controller.dart';

class PreviewController extends GetxController {

  bool isShowProgress = false;
  String selectedSendWp = "";
  String displayDefaultVal = "";
  bool isAdvanceEnabled = false;

  final List<OptionsClass> listPersons = [];
  List<FunctionPreview>? functionsUploadList = [];

  String? selectedValue;
  String? previewURL= "";

  // List<String> listTitle = [];
  List<PreviewFunctions> functionStringTitleList = [];

  CreateData createData = CreateData();
  dynamic argument = Get.arguments;
  var isFromScreen = "";

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
        // Debug.printLog("createData==>> Preview==>> ${jsonEncode(createData)}");
      }
      if(argument[1] != null){
        functionStringTitleList = argument[1];
        Debug.printLog("listTitle==>> Preview==>> $functionStringTitleList");
      }

      if(argument[2] != null){
        previewURL = argument[2];
      }
      if(argument[3] != null){
        isFromScreen = argument[3];
      }
    }
    selectedSendWp = Constant.selectedSendWpSarvo;
    displayDefaultVal = "txtSarvo".tr;
    addDropDownMenuData();
    // downloadPDFFile();
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
          functionId: functionStringTitleList[i].fId,
          banquetPerson: functionStringTitleList[i].fPerson));
    }
    var previewData = FunctionUploadData();
    previewData.functions = functionsUploadList;
    sendAllFunctions(Get.context!,previewData,createData.marriageInvitationCardId! ?? "");

    Debug.printLog("functionsUploadList===>> $functionsUploadList  ${previewData.toJson()}  ${jsonEncode(previewData)}");

  }


  var downloadData = DownloadPdfDataModel();
  sendAllFunctions(BuildContext context, FunctionUploadData uploadData,String cardId) async {
    if (await InternetConnectivity.isInternetConnect()) {
      Debug.printLog("uploadData==>> ${jsonEncode(uploadData)}  ==>>>  $cardId");
      isShowProgress = true;
      update([Constant.isShowProgressUpload]);
      await downloadData.getDownloadPdf(context,uploadData,cardId,isFromScreen).then((value) {
        handleGetPdfDataResponse(value,context);
      });
    } else {
      Utils.showToast(context, "txtNoInternet".tr);
    }
  }

  handleGetPdfDataResponse(DownloadPdfData newKankotriData, BuildContext context) async {

    if (newKankotriData.status == Constant.responseSuccessCode) {
      if (newKankotriData.message != null) {
        if (newKankotriData.result!.data!.isNotEmpty) {
          Debug.printLog("DownloadPdfData Buffer==>> ${newKankotriData.toJson()}");
          // final Directory? directory = await getDownloadsDirectory();
          final File file = File('${'/storage/emulated/0/Download/'}${createData.marriageInvitationCardName ?? "invitationCard"}_${createData.marriageInvitationCardId ?? ""}.pdf');
          await file.writeAsBytes(newKankotriData.result!.data ?? []);
          Utils.showToast(context, "txtDownload".tr);
        } else {
          Debug.printLog(
              "handleGetPdfDataResponse Res Fail ===>> ${newKankotriData.toJson().toString()}");
        }

      } else {
        Debug.printLog(
            "handleGetPdfDataResponse Res Fail ===>> ${newKankotriData.toJson().toString()}");

        if (newKankotriData.message != null && newKankotriData.message!.isNotEmpty) {
          Utils.showToast(context,newKankotriData.message!);
        } else {
          Utils.showToast(context,"txtSomethingWentWrong".tr);
        }
      }
    } else {
      if (newKankotriData.message != null && newKankotriData.message!.isNotEmpty) {
        Utils.showToast(context,newKankotriData.message!);
      } else {
        Utils.showToast(context,"txtSomethingWentWrong".tr);
      }
    }


    isShowProgress = false;
    update([Constant.isShowProgressUpload]);
  }


}


class OptionsClass{
  String? title;
  String? selectedValue;
  List<String>? strValue = [];

  OptionsClass(this.title,this.selectedValue,this.strValue);
}
