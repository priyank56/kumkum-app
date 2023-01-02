import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/ui/preview/datamodel/downloadPdfData.dart';
import 'package:spotify_flutter_code/ui/preview/datamodel/downloadPdfDatamodel.dart';
import 'package:spotify_flutter_code/ui/preview/datamodel/functionUploadData.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';

import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../main.dart';
import '../../../utils/color.dart';
import '../../../utils/sizer_utils.dart';
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
  var isFromPreviewScreen = "";
  bool changeEndPointForDownload = false;

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
      if(argument[4] != null){
        isFromPreviewScreen = argument[4];
      }
      if(argument[5] != null){
        changeEndPointForDownload = argument[5];
      }
    }
    selectedSendWp = Constant.selectedSendWpSarvo;
    displayDefaultVal = "txtSarvo".tr;
    addDropDownMenuData();
    // downloadPDFFile();
    // loadWebView();
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
    }else{

    }
    for(int i = 0 ;i< functionStringTitleList.length;i++){
      functionsUploadList!.add(FunctionPreview(
          functionId: functionStringTitleList[i].fId,
          banquetPerson: functionStringTitleList[i].fPerson));
    }
    var previewData = FunctionUploadData();
    previewData.functions = functionsUploadList;
    sendAllFunctions(Get.context!,previewData,createData.marriageInvitationCardId!);

    Debug.printLog("functionsUploadList===>> $functionsUploadList  ${previewData.toJson()}  ${jsonEncode(previewData)}");

  }


  var downloadData = DownloadPdfDataModel();
  sendAllFunctions(BuildContext context, FunctionUploadData uploadData,String cardId) async {
    if (await InternetConnectivity.isInternetConnect()) {
      Debug.printLog("uploadData==>> ${jsonEncode(uploadData)}  ==>>>  $cardId");
      isShowProgress = true;
      update([Constant.isShowProgressUpload]);
      await downloadData.getDownloadPdf(context,uploadData,cardId,isFromScreen,changeEndPointForDownload).then((value) {
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
          var timeStamp  = DateTime.now().millisecondsSinceEpoch;
          final File file = File('${'/storage/emulated/0/Download/'}${createData.marriageInvitationCardName ?? "invitationCard"}_${timeStamp.toString()}.pdf');
          await file.writeAsBytes(newKankotriData.result!.data ?? []);
          var filePath = file.absolute.path.toString();
          Debug.printLog("filePath==>>>  $filePath");
          try {
            showNotification(filePath);
          } catch (e) {
            print(e);
          }
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

  showNotification(String filePath)async{
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(
        "12345",
        "kumkum_app",
        importance: Importance.defaultImportance,
        priority: Priority.max);

    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        12345,
        "KumKum App",
        "PDF Download successfully",
        platformChannelSpecifics,
        payload:filePath );
  }


  showCustomizeDialog(BuildContext context, PreviewController logic) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            runAlignment: WrapAlignment.center,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: contentBox(context),
              ),
            ],
          );
        }).whenComplete(() => {
      logic.clearAddData(),
    });
  }

  contentBox(BuildContext context) {
    return GetBuilder<PreviewController>(
        id: Constant.idAllButton,
        builder: (logic) {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Sizes.height_2, bottom: Sizes.height_1),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: Sizes.width_4, right: Sizes.width_1),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      // backgroundColor: CColor.theme,
                                      elevation: 0,
                                      backgroundColor: (logic.selectedSendWp ==
                                          Constant.selectedSendWpSarvo)
                                          ? CColor.themeDark
                                          : CColor.gray,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5), // <-- Radius
                                      ),
                                      textStyle: TextStyle(
                                          color: CColor.white,
                                          fontSize: FontSize.size_12,
                                          fontFamily: Constant.appFont,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () {
                                      logic.changeDefaultOption(Constant.selectedSendWpSarvo);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "txtSarvo".tr,
                                        style: TextStyle(
                                            color: (logic.selectedSendWp ==
                                                Constant.selectedSendWpSarvo)
                                                ? CColor.white
                                                : CColor.black,
                                            fontSize: FontSize.size_12,
                                            fontFamily: Constant.appFont),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: Sizes.width_2, left: Sizes.width_1),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      // backgroundColor: CColor.theme,
                                      elevation: 0,
                                      backgroundColor: (logic.selectedSendWp ==
                                          Constant.selectedSendWpSajode)
                                          ? CColor.themeDark
                                          : CColor.gray,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5), // <-- Radius
                                      ),
                                      textStyle: TextStyle(
                                          color: CColor.white,
                                          fontSize: FontSize.size_12,
                                          fontFamily: Constant.appFont,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () {
                                      logic.changeDefaultOption(Constant.selectedSendWpSajode);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "txtSajode".tr,
                                        style: TextStyle(
                                            color: (logic.selectedSendWp ==
                                                Constant.selectedSendWpSajode)
                                                ? CColor.white
                                                : CColor.black,
                                            fontSize: FontSize.size_12,
                                            fontFamily: Constant.appFont),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: Sizes.width_4,),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      // backgroundColor: CColor.theme,
                                      elevation: 0,
                                      backgroundColor: (logic.selectedSendWp ==
                                          Constant.selectedSendWp1Person)
                                          ? CColor.themeDark
                                          : CColor.gray,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5), // <-- Radius
                                      ),
                                      textStyle: TextStyle(
                                          color: CColor.white,
                                          fontSize: FontSize.size_12,
                                          fontFamily: Constant.appFont,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () {
                                      logic.changeDefaultOption(Constant.selectedSendWp1Person);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "txt1".tr,
                                        style: TextStyle(
                                            color: (logic.selectedSendWp ==
                                                Constant.selectedSendWp1Person)
                                                ? CColor.white
                                                : CColor.black,
                                            fontSize: FontSize.size_12,
                                            fontFamily: Constant.appFont),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: Sizes.height_3),
                    alignment: Alignment.center,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return _itemWidgetJan(index, context, logic);
                      },
                      shrinkWrap: true,
                      itemCount:
                      (logic.isAdvanceEnabled) ? logic.functionStringTitleList.length : (logic.functionStringTitleList.length > 3)?3:logic.functionStringTitleList.length,
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                  Column(
                    // alignment: Alignment.centerRight,
                    children: [
                      if (logic.functionStringTitleList.length > 3)
                        Container(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              logic.changeAdvanced();
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: Sizes.height_2),
                              child: Text(
                                (!logic.isAdvanceEnabled)
                                    ? "txtVadhare".tr
                                    : "txtOchu".tr,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: CColor.blue,
                                    fontFamily: Constant.appFont,
                                    fontWeight: FontWeight.w700,
                                    fontSize: FontSize.size_12),
                              ),
                            ),
                          ),
                        )
                      else Container(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            left: Sizes.width_5, right: Sizes.width_5,bottom: Sizes.height_1_5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CColor.blueDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // <-- Radius
                            ),
                            textStyle: TextStyle(
                                color: CColor.white,
                                fontSize: FontSize.size_12,
                                fontFamily: Constant.appFont,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () async {
                            if (await Permission.storage
                                .request()
                            .isGranted) {
                            logic.generateUploadFunctionsData();
                            Get.back();
                            } else if (await Permission.storage
                                .request()
                                .isPermanentlyDenied) {
                            showAlertDialogPermission(context,logic);
                            } else if (await Permission.storage
                                .request()
                                .isDenied) {
                            Get.back();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(Sizes.height_1_5),
                            child: Text("txtDownloadBtn".tr,),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  showAlertDialogPermission(BuildContext context,PreviewController logic) {
    // Create button
    Widget okButton = TextButton(
      child: Text("txtOk".tr),
      onPressed: () async {
        await openAppSettings();
      },
    );

    Widget cancelButton = TextButton(
      child: Text("txtCancel".tr),
      onPressed: () {
        Get.back();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("txtPermission".tr),
      content: Text("txtPermissionDesc".tr),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _itemWidgetJan(int index, BuildContext context, PreviewController logic) {
    return Container(
      margin: EdgeInsets.only(
          left: Sizes.width_5, right: Sizes.width_5, top: Sizes.height_2),
      // alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text(
            logic.functionStringTitleList[index].fName.toString(),
            style: TextStyle(
                color: CColor.black,
                fontSize: FontSize.size_14,
                fontWeight: FontWeight.w500,
                fontFamily: Constant.appFont),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              items: logic.listPersons[index].strValue!
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: CColor.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
                  .toList(),
              value: logic.listPersons[index].selectedValue,
              onChanged: (value) {
                logic.changeDropDownValue(value.toString(),index);
              },
              buttonWidth: 160,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: CColor.white,
              ),
              buttonElevation: 2,
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: 160,
              dropdownPadding: null,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: CColor.white,
              ),
              dropdownElevation: 8,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              offset: const Offset(0, 0),
            ),
          ),
        ],
      ),
    );
  }

}


class OptionsClass{
  String? title;
  String? selectedValue;
  List<String>? strValue = [];

  OptionsClass(this.title,this.selectedValue,this.strValue);
}
