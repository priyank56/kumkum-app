import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/contact/controllers/contact_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import '../../../custom/dialog/progressdialog.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<ContactController>(
                id: Constant.idMainPage,
                builder: (logic) {
                  return Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/main_bg.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _widgetPreBuilt(logic, context),
                            (logic.allYourCardList.isNotEmpty)?_widgetDesc(logic, context):Container(),
                            (logic.allYourCardList.isNotEmpty)?_widgetNextPrevious(context):Container(),
                            (logic.allYourCardList.isNotEmpty)?_widgetText(context):Container(),
                            (logic.currentPos == 1 && logic.allYourCardList.isNotEmpty && !logic.isShowProgress)
                                ? _widgetFirstBottomView(context)
                                : (logic.currentPos == 3 && logic.allYourCardList.isNotEmpty)
                                ? _widgetThirdBottomView(context)
                                : Expanded(child: Container(
                              height: 500,
                              alignment: Alignment.center,
                              child: Text(
                                "txtNoDataFound".tr,
                                style: TextStyle(
                                    color: (logic.isShowProgress)?CColor.transparent:CColor.black,
                                    fontSize: FontSize.size_14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: Constant.appFont
                                ),
                              ),
                            ),
                            )
                          ],
                        ),
                        (logic.currentPos == 2 && logic.allYourCardList.isNotEmpty)
                            ? _widgetSecondBottomView(context, logic)
                            : Container()
                      ],
                    ),
                  );
                }),
            GetBuilder<ContactController>(
                id: Constant.isShowProgressUpload,
                builder: (logic) {
                  return ProgressDialog(
                      inAsyncCall: logic.isShowProgress,
                      child: Container());
                }),
          ],
        ),
      ),
    );
  }

  _widgetPreBuilt(ContactController logic, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Sizes.height_1, left: Sizes.width_1, right: Sizes.width_5),
      padding: EdgeInsets.all(Sizes.height_2_5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            (logic.currentPos == 1)
                ? "txtKonkotriCreation".tr
                : (logic.currentPos == 2)
                ? "txtYourGuests".tr
                : "txtSendInvitation".tr,
            style: TextStyle(
                color: CColor.black,
                fontSize: FontSize.size_18,
                fontFamily: Constant.appFont,
                fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _widgetDesc(ContactController logic, BuildContext context) {
    return GetBuilder<ContactController>(
        id: Constant.idBottomText,
        builder: (logic) {
          return Container(
            // color: CColor.black,
            height: Sizes.height_9,
            margin: EdgeInsets.only(left: Sizes.width_1, right: Sizes.width_1),
            padding: EdgeInsets.only(left: Sizes.width_5, right: Sizes.width_5),
            child: AutoSizeText(
              (logic.currentPos == 1)
                  ? "txtKonkotriCreationDesc1".tr
                  : (logic.currentPos == 2)
                  ? "txtKonkotriCreationDesc2".tr
                  : "txtKonkotriCreationDesc3".tr,
              style: TextStyle(
                  color: CColor.black,
                  fontSize: FontSize.size_14,
                  fontFamily: Constant.appFont,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
              maxLines: 3,
              // maxLines: 5,
            ),
          );
        });
  }

  _widgetNextPrevious(BuildContext context) {
    return GetBuilder<ContactController>(
        id: Constant.idNextPrevious,
        builder: (logic) {
          return Container(
            margin: EdgeInsets.only(top: Sizes.height_3),
            child: Row(
              children: [
                /*For Previous*/
                if (logic.currentPos > 1)
                  Expanded(
                    child: Material(
                      color: CColor.transparent,
                      child: InkWell(
                        splashColor: CColor.black,
                        onTap: () {
                          if(logic.contactList.isNotEmpty) {
                            logic.changeBottomViewPos(logic.currentPos - 1);
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/ic_ring.png",
                              height: Sizes.height_6,
                              width: Sizes.height_6,
                            ),
                            SvgPicture.asset(
                              "assets/svg/ic_previous.svg",
                              height: Sizes.height_4,
                              width: Sizes.height_4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(child: Container()),

                /*For Center Text*/
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        "assets/ic_ring.png",
                        height: Sizes.height_6,
                        width: Sizes.height_6,
                      ),
                      Text(
                        logic.currentPos.toString(),
                        style: TextStyle(
                            color: CColor.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: Constant.appFont,
                            fontSize: FontSize.size_18),
                      ),
                    ],
                  ),
                ),

                /*For Next */
                if (logic.currentPos <= 1 || logic.currentPos < 3)
                  Expanded(
                    child: Material(
                      color: CColor.transparent,
                      child: InkWell(
                        splashColor: CColor.black,
                        onTap: () {
                          if(logic.selectedCardId != "" && logic.contactList.isNotEmpty) {
                            logic.changeBottomViewPos(logic.currentPos + 1);
                          }else{
                            if(logic.selectedCardId == "") {
                              Utils.showToast(context, "txtSelectCard".tr);
                            }
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/ic_ring.png",
                              height: Sizes.height_6,
                              width: Sizes.height_6,
                            ),
                            SvgPicture.asset(
                              "assets/svg/ic_next.svg",
                              height: Sizes.height_4,
                              width: Sizes.height_4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(child: Container()),
              ],
            ),
          );
        });
  }

  _widgetText(BuildContext context) {
    return GetBuilder<ContactController>(
        id: Constant.idBottomText,
        builder: (logic) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                top: Sizes.height_1, left: Sizes.width_1, right: Sizes.width_5),
            padding: EdgeInsets.all(Sizes.height_2_5),
            child: Text(
              (logic.currentPos == 1)
                  ? "txtChooseKankotri".tr
                  : (logic.currentPos == 2)
                  ? "txtSelectYourGuests".tr
                  : "txtSendViaWhatsapp".tr,
              style: TextStyle(
                  color: CColor.black,
                  fontSize: FontSize.size_18,
                  fontFamily: Constant.appFont,
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  _widgetFirstBottomView(BuildContext context) {
    return GetBuilder<ContactController>(
        id: Constant.idBottomViewPos,
        builder: (logic) {
          return Container(
            padding: EdgeInsets.only(top: Sizes.height_3, left: Sizes.width_5),
            height: Sizes.height_37,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _itemCardView(index, context,logic);
              },
              shrinkWrap: true,
              itemCount: logic.allYourCardList.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        });
  }

  _itemCardView(int index, BuildContext context, ContactController logic) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        onTap: () {
          logic.changeSelectedId(logic.allYourCardList[index].marriageInvitationCardId.toString(),index);
          logic.changeBottomViewPos(logic.currentPos + 1);
        },
        splashColor: CColor.black,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.55,
          padding: EdgeInsets.only(right: Sizes.width_5),
          // height: double.infinity,
          // height: Sizes.height_15,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Container(
                // height: Sizes.height_15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.height_3),
                  child: CachedNetworkImage(
                    fadeInDuration: const Duration(milliseconds: 10),
                    fadeOutDuration: const Duration(milliseconds: 10),
                    fit: BoxFit.fill,
                    imageUrl: logic.allYourCardList[index].thumbnail.toString(),
                    placeholder: (context, url) =>
                    /*const Center(
                      child: SizedBox(
                        width: 60.0,
                        height: 60.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),*/
                    Utils.bgShimmer(context),
                  ),
                ),
              ),
              if (logic.allYourCardList[index].isSelect!)
                Stack(
                   // fit: StackFit.expand,
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Sizes.height_3),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          // height: double.infinity,
                          height: Sizes.height_31,
                          color: CColor.black50,
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(
                        top: Sizes.height_2,
                        right: Sizes.width_2,
                      ),
                      child: SvgPicture.asset(
                        "assets/svg/ic_tick.svg",
                        color: CColor.white,
                        width: Sizes.width_10,
                        height: Sizes.width_10,
                      ),
                    ),
                  ],
                )
              else
                Container()
            ],
          ),
        ),
      ),
    );
  }

  _widgetSecondBottomView(BuildContext context, ContactController logic) {
    return GetBuilder<ContactController>(
        id: Constant.idBottomViewPos,
        builder: (logic) {
          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: SlidingUpPanel(
                  renderPanelSheet: false,
                  maxHeight: MediaQuery
                      .of(context)
                      .size
                      .height * 1,
                  minHeight: MediaQuery
                      .of(context)
                      .size
                      .height * 0.401,

                  /*When Slide Panel Open*/
                  panel: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0)),
                    ),
                    child: _listViewContact(context, logic, needFullScreen: true),
                    // child: Container(),
                  ),
                  onPanelOpened: () {
                    Debug.printLog("onPanelOpened==>> ${logic.contactList.length}  ${logic.contactListSarvo.length}");
                  },
                  onPanelClosed: () {
                    Debug.printLog("onPanelClosed==>> ${logic.contactList.length}  ${logic.contactListSarvo.length}");
                  },
                  /*When Slide Panel Not Open*/
                  collapsed: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0)),
                    ),
                    child: _listViewContact(context, logic),
                    // child: Container(),
                  ),
                ),
              ),
              Material(
                color: CColor.transparent,
                child: InkWell(
                  splashColor: CColor.grayDark,
                  onTap: () {
                    showCustomizeDialogForAddContact(context, logic);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: Sizes.width_5),
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: CColor.grayDark,
                    ),
                    child: const Icon(Icons.add,color: CColor.white,),
                  ),
                ),
              )
            ],
          );
        });
  }

  _listViewContact(BuildContext context, ContactController logic, {bool needFullScreen = false}) {
    return Column(
      children: [
        Container(
          width: Sizes.width_10,
          margin: EdgeInsets.only(top: Sizes.height_2_5),
          decoration: BoxDecoration(
              border: Border.all(color: CColor.grayDark, width: 2),
              borderRadius: BorderRadius.circular(10)
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: Sizes.height_2),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  color: CColor.transparent,
                  child: InkWell(
                    splashColor: CColor.black,
                    onTap: () {
                      logic.changeSendOption(Constant.selectedSendWpSarvo);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: Sizes.width_5, right: Sizes.width_1),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: (logic.selectedSendWp ==
                              Constant.selectedSendWpSarvo)
                              ? CColor.themeDark
                              : CColor.gray,
                          borderRadius: BorderRadius.circular(5)),
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
                child: Material(
                  color: CColor.transparent,
                  child: InkWell(
                    splashColor: CColor.black,
                    onTap: () {
                      logic.changeSendOption(Constant.selectedSendWpSajode);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          right: Sizes.width_2, left: Sizes.width_1),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: (logic.selectedSendWp ==
                              Constant.selectedSendWpSajode)
                              ? CColor.themeDark
                              : CColor.gray,
                          borderRadius: BorderRadius.circular(5)),
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
                child: Material(
                  color: CColor.transparent,
                  child: InkWell(
                    splashColor: CColor.black,
                    onTap: () {
                      logic.changeSendOption(Constant.selectedSendWp1Person);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        right: Sizes.width_5,),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: (logic.selectedSendWp ==
                              Constant.selectedSendWp1Person)
                              ? CColor.themeDark
                              : CColor.gray,
                          borderRadius: BorderRadius.circular(5)),
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
        GetBuilder<ContactController>(
            id: Constant.idContactList,
            builder: (logic) {
          return Expanded(
            child: (logic.contactList.isNotEmpty) ?
            Container(
              height: (needFullScreen) ? MediaQuery
                  .of(context)
                  .size
                  .height * 1 : MediaQuery
                  .of(context)
                  .size
                  .height * 0.3,
              // padding: EdgeInsets.only(top: Sizes.height_3, left: Sizes.width_5,right:  Sizes.width_5),
              padding: EdgeInsets.only(
                  top: Sizes.height_2, bottom: Sizes.height_2_5),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _itemContactView(index, context, logic,
                      (logic.selectedSendWp == Constant.selectedSendWpSarvo)
                          ? logic.contactListSarvo
                          : (logic.selectedSendWp ==
                          Constant.selectedSendWpSajode)
                          ? logic.contactListSajode
                          : logic.contactList1Person);
                },
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                (logic.selectedSendWp == Constant.selectedSendWpSarvo)
                    ? logic.contactListSarvo.length
                    : (logic.selectedSendWp ==
                    Constant.selectedSendWpSajode)
                    ? logic.contactListSajode.length
                    : logic.contactList1Person.length,
                scrollDirection: Axis.vertical,
              ),
            ) : const Center(
              child: SizedBox(
                width: 60.0,
                height: 60.0,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }),
      ],
    );
  }

  _itemContactView(int index, BuildContext context, ContactController logic,
      List<AllContact> list) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        onTap: () {
          logic.changeCheckValue(
              list[index].isSelected, index, logic.selectedSendWp);
        },
        child: Column(
          children: [
            const Divider(
              height: 1,
              thickness: 2,
              color: CColor.gray,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Sizes.width_5),
              margin:
              EdgeInsets.only(top: Sizes.height_1_4, bottom: Sizes.height_1_4),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color:
                              (list[index].isSelected) ? CColor.black : CColor
                                  .grayEF,
                              width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: Sizes.width_2_5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            list[index].contactName.toString(),
                            style: TextStyle(
                                color: CColor.black,
                                fontSize: FontSize.size_12,
                                fontFamily: Constant.appFont,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            // maxLines: 5,
                          ),
                          AutoSizeText(
                            list[index].contactNumber.toString(),
                            style: TextStyle(
                                color: CColor.black,
                                fontSize: FontSize.size_10,
                                fontFamily: Constant.appFont,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            // maxLines: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showCustomizeDialogForEditName(context,logic,index);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Sizes.width_1),
                      child: const Icon(
                        Icons.edit,
                        color: CColor.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  showCustomizeDialogForEditName(BuildContext context,
      ContactController logic, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            runAlignment: WrapAlignment.center,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: contentBox(context,index),
              ),
            ],
          );
        });
  }

  contentBox(BuildContext context, int index) {
    return GetBuilder<ContactController>(
        id: Constant.idGodNames,
        builder: (logic) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: Sizes.height_3),
                  child: Container(
                    height: Utils.getAddKankotriHeight(),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    color: CColor.white,
                    child: TextField(
                      controller: (logic.selectedSendWp == Constant.selectedSendWpSarvo)
                        ? logic.contactListSarvo[index].controller
                        : (logic.selectedSendWp ==
                        Constant.selectedSendWpSajode)
                        ? logic.contactListSajode[index].controller
                        : logic.contactList1Person[index].controller,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: CColor.grayDark),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: "txtPersonName".tr,
                        labelStyle: const TextStyle(color: CColor.grayDark),
                        hintText: "txtPersonName".tr,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: Sizes.height_3,
                      top: Sizes.height_3,
                      right: Sizes.width_3,
                      left: Sizes.width_5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          color: CColor.transparent,
                          child: InkWell(
                            splashColor: CColor.grayDark,
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                right: Sizes.width_2,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.width_4,
                                  vertical: Sizes.height_1),
                              decoration: BoxDecoration(
                                // color: CColor.grayDark,
                                border: Border.all(
                                    color: CColor.grayDark, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "txtCancel".tr,
                                style: TextStyle(
                                  color: CColor.grayDark,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: Constant.appFont,
                                  fontSize: FontSize.size_12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: CColor.transparent,
                          child: InkWell(
                            splashColor: CColor.grayDark,
                            onTap: () {
                              logic.updateContactName(index,logic.selectedSendWp,context);
                              Utils.showToast(context, "txtUpdatedName".tr);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                right: Sizes.width_2,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.width_4,
                                  vertical: Sizes.height_1),
                              decoration: BoxDecoration(
                                color: CColor.grayDark,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "txtUpdate".tr,
                                style: TextStyle(
                                  color: CColor.white,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: Constant.appFont,
                                  fontSize: FontSize.size_12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }


  showCustomizeDialogForAddContact(BuildContext context, ContactController logic) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            runAlignment: WrapAlignment.center,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: contentBoxAddContact(context),
              ),
            ],
          );
        });
  }

  contentBoxAddContact(BuildContext context) {
    return GetBuilder<ContactController>(
        id: Constant.idGodNames,
        builder: (logic) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: Sizes.height_3),
                  child: Container(
                    height: Utils.getAddKankotriHeight(),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    color: CColor.white,
                    child: TextField(
                      keyboardType:TextInputType.text,
                      controller: logic.nameContactController,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: CColor.grayDark),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: "txtPersonName".tr,
                        labelStyle: const TextStyle(color: CColor.grayDark),
                        hintText: "txtPersonName".tr,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Sizes.height_3),
                  child: Container(
                    height: Utils.getAddKankotriHeight(),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    color: CColor.white,
                    child: TextField(
                      controller: logic.numberContactController,
                      keyboardType:TextInputType.number ,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: CColor.grayDark),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: "txtPersonContact".tr,
                        labelStyle: const TextStyle(color: CColor.grayDark),
                        hintText: "txtPersonContact".tr,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: Sizes.height_3,
                      top: Sizes.height_3,
                      right: Sizes.width_3,
                      left: Sizes.width_5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          color: CColor.transparent,
                          child: InkWell(
                            splashColor: CColor.grayDark,
                            onTap: () {
                              logic.nameContactController.clear();
                              logic.numberContactController.clear();
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                right: Sizes.width_2,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.width_4,
                                  vertical: Sizes.height_1),
                              decoration: BoxDecoration(
                                // color: CColor.grayDark,
                                border: Border.all(
                                    color: CColor.grayDark, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "txtCancel".tr,
                                style: TextStyle(
                                  color: CColor.grayDark,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: Constant.appFont,
                                  fontSize: FontSize.size_12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: CColor.transparent,
                          child: InkWell(
                            splashColor: CColor.grayDark,
                            onTap: () {
                              logic.addContact(logic.nameContactController.text,logic.numberContactController.text);
                              logic.nameContactController.clear();
                              logic.numberContactController.clear();
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                right: Sizes.width_2,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.width_4,
                                  vertical: Sizes.height_1),
                              decoration: BoxDecoration(
                                color: CColor.grayDark,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "txtAdd".tr,
                                style: TextStyle(
                                  color: CColor.white,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: Constant.appFont,
                                  fontSize: FontSize.size_12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }


  _widgetThirdBottomView(BuildContext context) {
    return GetBuilder<ContactController>(
        id: Constant.idBottomViewPos,
        builder: (logic) {
          return Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Sizes.width_7),
                      topRight: Radius.circular(Sizes.width_7),
                    ),
                    color: CColor.white),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: Sizes.height_9,
                        margin: EdgeInsets.only(
                          left: Sizes.width_1,
                          right: Sizes.width_1,
                        ),
                        padding: EdgeInsets.only(
                            left: Sizes.width_5, right: Sizes.width_5),
                        child: Container(
                          alignment: Alignment.center,
                          // color: CColor.grayDark,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (logic.getCountForSarvo() > 0)?
                              Text(
                                "તમે ${logic.getCountForSarvo()} મહેમાનને સર્વો, ${logic.getCountForSajode()} મહેમાનને સજોડે અને ${logic.getCountForPerson()} આપ શ્રી સાથે આવવા માટે પસંદ કર્યા છે.",
                                style: TextStyle(
                                    color: CColor.black,
                                    fontSize: FontSize.size_12,
                                    fontFamily: Constant.appFont,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                                // maxLines: 5,
                              ):Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: CColor.transparent,
                      child: InkWell(
                        splashColor: CColor.blueDark,
                        onTap: () {
                          // logic.changeSendOption(Constant.selectedSendWpSajode);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              right: Sizes.width_5,
                              left: Sizes.width_5,
                              // top: Sizes.height_5,
                              bottom: Sizes.height_5),
                          padding: EdgeInsets.symmetric(
                              vertical: Sizes.height_1_5),
                          decoration: BoxDecoration(
                              color: CColor.blueDark,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "txtSendInvitations".tr,
                            style: TextStyle(
                                color: CColor.white,
                                fontSize: FontSize.size_12,
                                fontFamily: Constant.appFont,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
