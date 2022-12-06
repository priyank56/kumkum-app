import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/contact/controllers/contact_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ContactController>(
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
                    /*SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _widgetPreBuilt(logic, context),
                          _widgetDesc(logic, context),
                          _widgetNextPrevious(),
                          _widgetText(context),
                          (logic.currentPos == 1)
                              ? _widgetFirstBottomView(context)
                              : _widgetThirdBottomView(context),
                        ],
                      ),
                    ),*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _widgetPreBuilt(logic, context),
                        _widgetDesc(logic, context),
                        _widgetNextPrevious(),
                        _widgetText(context),
                        (logic.currentPos == 1)
                            ? _widgetFirstBottomView(context)
                            : (logic.currentPos == 3)
                            ? _widgetThirdBottomView(context)
                            : Expanded(child: Container()),
                      ],
                    ),
                    (logic.currentPos == 2)
                        ? _widgetSecondBottomView(context, logic)
                        : Container()
                  ],
                ),
              );
            }),
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

  _widgetNextPrevious() {
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
                          logic.changeBottomViewPos(logic.currentPos - 1);
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
                          logic.changeBottomViewPos(logic.currentPos + 1);
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
                return _itemCardView(index, context);
              },
              shrinkWrap: true,
              itemCount: 5,
              scrollDirection: Axis.horizontal,
            ),
          );
        });
  }

  _itemCardView(int index, BuildContext context) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        onTap: () {},
        splashColor: CColor.black,
        child: Container(
          padding: EdgeInsets.only(right: Sizes.width_5),
          height: Sizes.height_15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            "assets/ic_card_demo.png",
          ),
        ),
      ),
    );
  }

  _widgetSecondBottomView(BuildContext context, ContactController logic) {
    return GetBuilder<ContactController>(
        id: Constant.idBottomViewPos,
        builder: (logic) {
      return Container(
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
      );
    });
  }

  _listViewContact(BuildContext context, ContactController logic,
      {bool needFullScreen = false}) {
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
                          right: Sizes.width_5, left: Sizes.width_1),
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
            ],
          ),
        ),
        Expanded(
          child: Container(
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
                return _itemContactView(index, context, logic);
              },
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
              scrollDirection: Axis.vertical,
            ),
          ),
        ),
      ],
    );
  }

  _itemContactView(int index, BuildContext context, ContactController logic) {
    return Column(
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
                onTap: () {
                  logic.changeCheckValue(logic.isCheck);
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color:
                          (logic.isCheck) ? CColor.black : CColor.grayEF,
                          width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: Sizes.width_2_5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Mansukhbhai Mandaviya",
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
                      "8000563265",
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
              )
            ],
          ),
        ),
      ],
    );
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
                    Container(
                      margin: EdgeInsets.only(top: Sizes.height_4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Material(
                              color: CColor.transparent,
                              child: InkWell(
                                splashColor: CColor.black,
                                onTap: () {
                                  logic.changeSendOption(
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
                                  logic.changeSendOption(
                                      Constant.selectedSendWpSajode);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: Sizes.width_5,
                                      left: Sizes.width_1),
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
                        ],
                      ),
                    ),
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
                        child: Text(
                          "You have choosen 68 guests to come up with their family.",
                          style: TextStyle(
                              color: CColor.black,
                              fontSize: FontSize.size_14,
                              fontFamily: Constant.appFont,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                          // maxLines: 5,
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
                              top: Sizes.height_5,
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
