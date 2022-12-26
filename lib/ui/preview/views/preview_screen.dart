import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../custom/dialog/progressdialog.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/params.dart';
import '../../../utils/sizer_utils.dart';
import '../controllers/preview_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewController>(builder: (logic) {
      return ProgressDialog(
        child: _webView(context,logic),
        inAsyncCall: logic.isShowProgress,
      );
    });
  }

  _webView(BuildContext context, PreviewController logic) {
    return WillPopScope(
      onWillPop:  () async {
        if(logic.isFromPreviewScreen == Constant.isFromSubmit) {
          Get.back();
          Get.back();
        } else if(logic.isFromPreviewScreen == Constant.isFromPreview) {
          var map = <String,String>{};
          map.putIfAbsent(Params.createdCardId, () => logic.createData.marriageInvitationCardId.toString());
          Get.back(result: map);
        } else if(logic.isFromPreviewScreen == Constant.isFromCategoryPreview) {
          Get.back();
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              GetBuilder<PreviewController>(builder: (logic) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Material(
                          color: CColor.transparent,
                          child: InkWell(
                            onTap: () {
                              // Get.offAllNamed(AppRoutes.main);
                              // Get.back();
                              Get.back();
                            },
                            splashColor: CColor.black,
                            child: Container(
                              margin: EdgeInsets.all(Sizes.height_2),
                              child: SvgPicture.asset(
                                "assets/svg/login_flow/ic_back.svg",
                                height: Sizes.height_4,
                                width: Sizes.height_4,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              "txtPreview".tr,
                              style: TextStyle(
                                  color: CColor.black,
                                  fontSize: FontSize.size_14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: Constant.appFont),
                            ),
                          ),
                        ),
                        Material(
                          color: CColor.transparent,
                          child: InkWell(
                            splashColor: CColor.black,
                            onTap: () {
                              showCustomizeDialog(context, logic);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: Sizes.width_5),
                              child: SvgPicture.asset("assets/svg/ic_download.svg",
                                  height: Sizes.height_3, width: Sizes.height_3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: (logic.previewURL != "")
                          ? WebView(
                              initialUrl: logic.previewURL,
                              javascriptMode: JavascriptMode.unrestricted,
                              onPageFinished: (url) {
                                logic.changeProgressValue(false);
                              },
                            )
                          : Container(),
                    ),
                  ],
                );
              }),
              GetBuilder<PreviewController>(
                  id: Constant.isShowProgressUpload,
                  builder: (logic) {
                    return ProgressDialog(
                        inAsyncCall: logic.isShowProgress,
                        child: Container());
                  }),
            ],
          ),
        ),
      ),
    );
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
                              top: Sizes.height_4, bottom: Sizes.height_1),
                          child: Row(
                            children: [
                              Expanded(
                                child: Material(
                                  color: CColor.transparent,
                                  child: InkWell(
                                    splashColor: CColor.black,
                                    onTap: () {
                                      logic.changeDefaultOption(
                                          Constant.selectedSendWpSarvo);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          left: Sizes.width_5,
                                          right: Sizes.width_1),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: (logic.selectedSendWp ==
                                                  Constant.selectedSendWpSarvo)
                                              ? CColor.themeDark
                                              : CColor.gray,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "txtSarvo".tr,
                                        style: TextStyle(
                                            color: (logic.selectedSendWp ==
                                                    Constant
                                                        .selectedSendWpSarvo)
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
                                child: Material(
                                  color: CColor.transparent,
                                  child: InkWell(
                                    splashColor: CColor.black,
                                    onTap: () {
                                      logic.changeDefaultOption(
                                          Constant.selectedSendWpSajode);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          right: Sizes.width_2,
                                          left: Sizes.width_1),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: (logic.selectedSendWp ==
                                                  Constant.selectedSendWpSajode)
                                              ? CColor.themeDark
                                              : CColor.gray,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "txtSajode".tr,
                                        style: TextStyle(
                                            color: (logic.selectedSendWp ==
                                                    Constant
                                                        .selectedSendWpSajode)
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
                                child: Material(
                                  color: CColor.transparent,
                                  child: InkWell(
                                    splashColor: CColor.black,
                                    onTap: () {
                                      logic.changeDefaultOption(
                                          Constant.selectedSendWp1Person);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          right: Sizes.width_5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: (logic.selectedSendWp ==
                                                  Constant
                                                      .selectedSendWp1Person)
                                              ? CColor.themeDark
                                              : CColor.gray,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "txt1".tr,
                                        style: TextStyle(
                                            color: (logic.selectedSendWp ==
                                                    Constant
                                                        .selectedSendWp1Person)
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
                    margin: EdgeInsets.only(bottom: Sizes.height_5),
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
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      if (logic.functionStringTitleList.length > 3)
                        Container(
                        alignment: Alignment.center,
                        child: Material(
                          color: CColor.transparent,
                          child: InkWell(
                            splashColor: CColor.black,
                            onTap: () {
                              logic.changeAdvanced();
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: Sizes.height_3),
                              child: Text(
                                (!logic.isAdvanceEnabled)
                                    ? "txtVadhare".tr
                                    : "txtOchu".tr,
                                style: TextStyle(
                                    color: CColor.black,
                                    fontFamily: Constant.appFont,
                                    fontWeight: FontWeight.w700,
                                    fontSize: FontSize.size_12),
                              ),
                            ),
                          ),
                        ),
                      )
                      else Container(),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: Sizes.height_10,
                          minHeight: Sizes.height_10,
                          maxWidth: Sizes.height_10,
                          minWidth: Sizes.height_10
                        ),
                        child: Material(
                          color: CColor.transparent,
                          child: InkWell(
                            splashColor: CColor.black,
                            onTap: () async {
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
                              margin: EdgeInsets.only(right: Sizes.width_3,bottom: Sizes.height_3),
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(
                                  "assets/svg/ic_done.svg",
                                  height: Sizes.height_5,
                                  width: Sizes.height_5
                              ),
                            ),
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
              /*hint: Row(
                children: [
                  Expanded(
                    child: Text(
                      logic.displayDefaultVal,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CColor.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),*/
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
