import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spotify_flutter_code/main.dart';
import 'package:spotify_flutter_code/ui/addKankotri/controllers/add_kankotri_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_flutter_code/utils/utils.dart';
import '../../../custom/dialog/progressdialog.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../datamodel/getInfoData.dart';

class AddKankotriScreen extends StatelessWidget {
  const AddKankotriScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<AddKankotriController>(builder: (logic) {
              return Column(
                children: [
                  _topBar(logic),
                  _centerView(logic, context),
                ],
              );
            }),
            GetBuilder<AddKankotriController>(
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

  Widget _topBar(AddKankotriController logic) {
    return Container(
      color: CColor.white,
      child: Row(
        children: [
          Material(
            color: CColor.transparent,
            child: InkWell(
              onTap: () {
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
            child: Text(
              "txtAddKankotri".tr,
              style: TextStyle(
                color: CColor.black,
                fontSize: FontSize.size_14,
                fontWeight: FontWeight.w500,
                fontFamily: Constant.appFont,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _centerView(AddKankotriController logic, BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/main_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          // padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Sizes.width_5),
            child: Column(
              children: [
                _widgetImageView(logic, context),
                _varPaksh(logic, context),
                _kanyaPaksh(logic, context),
                _mrgTarikh(logic, context),
                _nimantrak(logic, context),
                _functionsAll(logic, context),
                _amantrakPart(logic, context),
                _guestAllNamesPart(context, logic),
                _tahukoPart(context, logic),
                _subhSathal(context, logic),
                _atakName(context, logic),
                _bhagavanNiMahiti(context, logic),
                _submitForm(context, logic),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _widgetImageView(AddKankotriController logic, BuildContext contex) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idSetMainImage,
        builder: (logic) {
          return InkWell(
            onTap: () async {
              if (await Permission.storage
                  .request()
                  .isGranted) {
                showOptionsDialog(contex, logic);
              } else if (await Permission.storage
                  .request()
                  .isPermanentlyDenied) {
                await openAppSettings();
              }
              if (await Permission.storage
                  .request()
                  .isDenied) {
                Get.back();
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: Sizes.height_3),
              child: (logic.imgFile == null)
                  ? Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: Sizes.height_15,
                    width: Sizes.height_15,
                    decoration: const BoxDecoration(
                      color: CColor.grayDark,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/svg/ic_image.svg',
                    color: CColor.gray,
                    width: Sizes.height_5,
                    height: Sizes.height_5,
                  ),
                ],
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.height_20),
                child: SizedBox(
                  height: Sizes.height_15,
                  width: Sizes.height_15,
                  child: Image.file(
                    logic.imgFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _varPaksh(AddKankotriController logic, BuildContext context) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idGroomPaksh,
        builder: (logic) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: Sizes.height_3),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 2,
                        color: CColor.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                      child: Text(
                        "txtVarPaksh".tr,
                        style: TextStyle(
                          color: CColor.grayDark,
                          fontSize: FontSize.size_14,
                          fontFamily: Constant.appFont,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 2,
                        color: CColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Sizes.height_3),
                child: Row(
                  children: [
                    Container(
                      height: Utils.getAddKankotriHeight(),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      color: CColor.white70,
                      // margin: EdgeInsets.only(left: Sizes.width_5),
                      child: TextField(
                        controller: logic.varRajaNuNameController,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: CColor.grayDark),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: 'txtVarRajaNuName'.tr,
                          labelStyle: const TextStyle(color: CColor.grayDark),
                          hintText: 'txtName'.tr,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Sizes.height_3),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      height: Utils.getAddKankotriHeight(),
                      color: CColor.white70,
                      // margin: EdgeInsets.only(left: Sizes.width_5),
                      child: TextField(
                        controller: logic.groomNameController,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: CColor.grayDark),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: 'txtGroomName'.tr,
                          labelStyle: const TextStyle(color: CColor.grayDark),
                          hintText: 'txtNameEn'.tr,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _kanyaPaksh(AddKankotriController logic, BuildContext context) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idBridePaksh,
        builder: (logic) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Sizes.height_3),
            child: Row(
              children: [
                const Expanded(
                  child: Divider(
                    thickness: 2,
                    color: CColor.black,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                  child: Text(
                    "txtKanyaPaksh".tr,
                    style: TextStyle(
                      color: CColor.grayDark,
                      fontSize: FontSize.size_14,
                      fontFamily: Constant.appFont,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Expanded(
                  child: Divider(
                    thickness: 2,
                    color: CColor.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Sizes.height_3),
            child: Row(
              children: [
                Container(
                  height: Utils.getAddKankotriHeight(),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  color: CColor.white70,
                  // margin: EdgeInsets.only(left: Sizes.width_5),
                  child: TextField(
                    controller: logic.kanyaNuNameController,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: CColor.grayDark),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'txtKanyaNuName'.tr,
                      labelStyle: const TextStyle(color: CColor.grayDark),
                      hintText: 'txtName'.tr,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Sizes.height_3),
            child: Row(
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  color: CColor.white70,
                  height: Utils.getAddKankotriHeight(),
                  child: TextField(
                    controller: logic.brideNameController,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: CColor.grayDark),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'txtBrideName'.tr,
                      labelStyle: const TextStyle(color: CColor.grayDark),
                      hintText: 'txtNameEn'.tr,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _mrgTarikh(AddKankotriController logic, BuildContext context) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idMrgDate,
        builder: (logic) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: Sizes.height_3),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 2,
                        color: CColor.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                      child: Text(
                        "txtLaganTarikh".tr,
                        style: TextStyle(
                          color: CColor.grayDark,
                          fontSize: FontSize.size_14,
                          fontFamily: Constant.appFont,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 2,
                        color: CColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Sizes.height_3),
                child: Row(
                  children: [
                    Container(
                      height: Utils.getAddKankotriHeight(),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      color: CColor.white70,
                      child: TextField(
                        // controller: logic.marriageDateController,
                        onTap: () {
                          logic.selectDate(context, index: -1);
                        },
                        cursorHeight: 0,
                        readOnly: true,
                        cursorWidth: 0,
                        decoration: InputDecoration(
                            suffixIcon: Container(
                              padding: EdgeInsets.all(Sizes.height_1),
                              child: SvgPicture.asset(
                                "assets/svg/ic_date.svg",
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(
                                minHeight: Sizes.height_3,
                                minWidth: Sizes.height_3),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 2, color: CColor.grayDark),
                            ),
                            // labelText: (logic.mrgDate != "")?logic.mrgDate:'txtTarikh'.tr,
                            border: const OutlineInputBorder(),
                            hintText: (logic.mrgDate != "")
                                ? logic.mrgDate
                                : 'txtTarikh'.tr),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _nimantrak(AddKankotriController logic, BuildContext context) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idAddNimantrakPart,
        builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(top: Sizes.height_3),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 2,
                        color: CColor.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                      child: Text(
                        "txtNimantrak".tr,
                        style: TextStyle(
                          color: CColor.grayDark,
                          fontSize: FontSize.size_14,
                          fontFamily: Constant.appFont,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 2,
                        color: CColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              _nimantrakNamePart(context, logic),
              _nimantrakAddressPart(context, logic),
              _nimantrakMobilePart(context, logic),
            ],
          );
        });
  }

  /*િમંત્રક નામ*/

  Widget _nimantrakNamePart(BuildContext context, AddKankotriController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(bottom: Sizes.height_0_5),
          child: AutoSizeText(
            maxLines: 1,
            "txtName".tr,
            style: TextStyle(
              color: CColor.grayDark,
              fontSize: FontSize.size_12,
              fontFamily: Constant.appFont,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return _listViewNimantrakName(context, index, logic);
          },
          shrinkWrap: true,
          itemCount: logic.listNimantrakName.length,
          physics: const NeverScrollableScrollPhysics(),
        ),
        Material(
          color: CColor.transparent,
          child: InkWell(
            splashColor: CColor.grayDark,
            onTap: () {
              logic.addNimantrakNameListData(true);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.22,
              margin: EdgeInsets.only(
                top: Sizes.height_1,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.width_4, vertical: Sizes.height_1),
              decoration: BoxDecoration(
                color: CColor.grayDark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "+ ${"txtAdd".tr}",
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
      ],
    );
  }

  Widget _listViewNimantrakName(BuildContext context, int index,
      AddKankotriController logic) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Container(
        height: Utils.getAddKankotriHeight(),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        color: CColor.white70,
        child: TextField(
          onChanged: (value) {
            logic.changeValueInListForNimantrak(
                index, Constant.typeNimantrakName, value);
          },
          controller: logic.nimantrakNameController[index],
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: CColor.grayDark),
            ),
            suffixIcon: (logic.listNimantrakName.length == 1)
                ? null
                : InkWell(
              onTap: () {
                logic.addNimantrakNameListData(false, index: index);
              },
              child: Container(
                padding: EdgeInsets.all(Sizes.height_1),
                child: SvgPicture.asset(
                  "assets/svg/ic_close.svg",
                ),
              ),
            ),
            suffixIconConstraints: BoxConstraints(
                minHeight: Sizes.height_3, minWidth: Sizes.height_3),
            border: const OutlineInputBorder(),
            labelText: 'txtNimantrakName'.tr,
            labelStyle: const TextStyle(color: CColor.grayDark),
            hintText: 'txtName'.tr,
          ),
        ),
      ),
    );
  }

  /*િમંત્રક સરનામું*/

  Widget _nimantrakAddressPart(BuildContext context,
      AddKankotriController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(bottom: Sizes.height_0_5),
          child: AutoSizeText(
            maxLines: 1,
            "txtSarnamu".tr,
            style: TextStyle(
              color: CColor.grayDark,
              fontSize: FontSize.size_12,
              fontFamily: Constant.appFont,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return _listViewNimantrakAddress(context, index, logic);
          },
          shrinkWrap: true,
          itemCount: logic.listNimantrakAddress.length,
          physics: const NeverScrollableScrollPhysics(),
        ),
        Material(
          color: CColor.transparent,
          child: InkWell(
            splashColor: CColor.grayDark,
            onTap: () {
              logic.addNimantrakAddressListData(true);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.22,
              margin: EdgeInsets.only(
                top: Sizes.height_1,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.width_4, vertical: Sizes.height_1),
              decoration: BoxDecoration(
                color: CColor.grayDark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "+ ${"txtAdd".tr}",
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
      ],
    );
  }

  Widget _listViewNimantrakAddress(BuildContext context, int index,
      AddKankotriController logic) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Container(
        color: CColor.white70,
        height: Utils.getAddKankotriHeight(),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        child: TextField(
          controller: logic.nimantrakAddressController[index],
          onChanged: (value) {
            logic.changeValueInListForNimantrak(
                index, Constant.typeNimantrakSarnamu, value);
          },
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: CColor.grayDark),
            ),
            suffixIcon: (logic.listNimantrakAddress.length == 1)
                ? null
                : InkWell(
              onTap: () {
                logic.addNimantrakAddressListData(false, index: index);
              },
              child: Container(
                padding: EdgeInsets.all(Sizes.height_1),
                child: SvgPicture.asset(
                  "assets/svg/ic_close.svg",
                ),
              ),
            ),
            suffixIconConstraints: BoxConstraints(
                minHeight: Sizes.height_3, minWidth: Sizes.height_3),
            border: const OutlineInputBorder(),
            labelText: 'txtNimantrakSarnamu'.tr,
            labelStyle: const TextStyle(color: CColor.grayDark),
            hintText: 'txtSarnamu'.tr,
          ),
        ),
      ),
    );
  }

  /*િમંત્રક મોબાઈલ*/

  Widget _nimantrakMobilePart(BuildContext context,
      AddKankotriController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(bottom: Sizes.height_0_5),
          child: AutoSizeText(
            maxLines: 1,
            "txtMobile".tr,
            style: TextStyle(
              color: CColor.grayDark,
              fontSize: FontSize.size_12,
              fontFamily: Constant.appFont,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return _listViewNimantrakMobile(context, index, logic);
          },
          shrinkWrap: true,
          itemCount: logic.listNimantrakMno.length,
          physics: const NeverScrollableScrollPhysics(),
        ),
        Material(
          color: CColor.transparent,
          child: InkWell(
            splashColor: CColor.grayDark,
            onTap: () {
              logic.addNimantrakMnoListData(true);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.22,
              margin: EdgeInsets.only(top: Sizes.height_1),
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.width_4, vertical: Sizes.height_1),
              decoration: BoxDecoration(
                color: CColor.grayDark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "+ ${"txtAdd".tr}",
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
      ],
    );
  }

  Widget _listViewNimantrakMobile(BuildContext context, int index,
      AddKankotriController logic) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Container(
        color: CColor.white70,
        height: Utils.getAddKankotriHeight(),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        child: TextField(
          controller: logic.nimantrakMnoController[index],
          onChanged: (value) {
            logic.changeValueInListForNimantrak(
                index, Constant.typeNimantrakMobile, value);
          },
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: CColor.grayDark),
            ),
            suffixIcon: (logic.listNimantrakMno.length == 1)
                ? null
                : InkWell(
              onTap: () {
                logic.addNimantrakMnoListData(false, index: index);
              },
              child: Container(
                padding: EdgeInsets.all(Sizes.height_1),
                child: SvgPicture.asset(
                  "assets/svg/ic_close.svg",
                ),
              ),
            ),
            suffixIconConstraints: BoxConstraints(
                minHeight: Sizes.height_3, minWidth: Sizes.height_3),
            border: const OutlineInputBorder(),
            labelText: 'txtNimantrakMobile'.tr,
            labelStyle: const TextStyle(color: CColor.grayDark),
            hintText: 'txtMobile'.tr,
          ),
        ),
      ),
    );
  }

  /*For Functions*/
  Widget _functionsAll(AddKankotriController logic, BuildContext context) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idFunctionsPart,
        builder: (logic) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return _listViewFunctions(
                  index, logic, context, logic.functionsList);
            },
            itemCount: logic.functionsList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          );
        });
  }

  Widget _listViewFunctions(int index, AddKankotriController logic,
      BuildContext context, List<FunctionsNimantrakName> functionsList) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: Sizes.height_3),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: CColor.black,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                child: Text(
                  functionsList[index].functionName.toString(),
                  style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_14,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: CColor.black,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: Sizes.height_3),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: CColor.white70,
                  margin: EdgeInsets.only(right: Sizes.width_2),
                  height: Utils.getAddKankotriHeight(),
                  child: TextField(
                    onChanged: (value) {
                      logic.changeValueInListForFunctions(
                          index, Constant.typeFunctionDate, value);
                    },
                    onTap: () {
                      logic.selectDate(context, index: index);
                    },
                    cursorHeight: 0,
                    readOnly: true,
                    cursorWidth: 0,
                    decoration: InputDecoration(
                      /*suffixIcon: Container(
                        margin: EdgeInsets.all(Sizes.height_1),
                        child: SvgPicture.asset(
                          "assets/svg/ic_date.svg",
                        ),
                      ),*/
                      suffixIcon: Container(
                        padding: EdgeInsets.all(Sizes.height_1),
                        child: SvgPicture.asset(
                          "assets/svg/ic_date.svg",
                        ),
                      ),
                      suffixIconConstraints: BoxConstraints(
                          minHeight: Sizes.height_3, minWidth: Sizes.height_3),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 2, color: CColor.grayDark),
                      ),
                      border: const OutlineInputBorder(),
                      hintText: (functionsList[index].functionDate != "")
                          ? functionsList[index].functionDate.toString()
                          : 'txtTarikh'.tr,
                      // hintText: 'txtTarikh'.tr,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: CColor.white70,
                  margin: EdgeInsets.only(left: Sizes.width_2),
                  height: Utils.getAddKankotriHeight(),
                  child: TextField(
                    onChanged: (value) {
                      logic.changeValueInListForFunctions(
                          index, Constant.typeFunctionTime, value);
                    },
                    onTap: () {
                      logic.selectTime(context, index);
                    },
                    cursorHeight: 0,
                    readOnly: true,
                    cursorWidth: 0,
                    decoration: InputDecoration(
                      /*suffixIcon: Container(
                        margin: EdgeInsets.all(Sizes.height_1),
                        child: SvgPicture.asset(
                          "assets/svg/ic_time.svg",
                        ),
                      ),*/
                      suffixIcon: Container(
                        padding: EdgeInsets.all(Sizes.height_1),
                        child: SvgPicture.asset(
                          "assets/svg/ic_time.svg",
                        ),
                      ),
                      suffixIconConstraints: BoxConstraints(
                          minHeight: Sizes.height_3, minWidth: Sizes.height_3),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 2, color: CColor.grayDark),
                      ),
                      border: const OutlineInputBorder(),
                      // labelText: 'txtKanyaNuName'.tr,
                      // labelStyle: const TextStyle(color: CColor.grayDark),
                      hintText: (functionsList[index].functionTime != "")
                          ? functionsList[index].functionTime.toString()
                          : 'txtSamay'.tr,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: CColor.white70,
          height: Utils.getAddKankotriHeight(),
          margin: EdgeInsets.only(top: Sizes.height_2),
          child: TextField(
            controller: logic.functionsPlaceListController[index],
            onChanged: (value) {
              logic.changeValueInListForFunctions(
                  index, Constant.typeFunctionPlace, value);
            },
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: CColor.grayDark),
              ),
              border: const OutlineInputBorder(),
              labelText: 'txtJagya'.tr,
              labelStyle: const TextStyle(color: CColor.grayDark),
              hintText: 'txtJagya'.tr,
            ),
          ),
        ),
        Container(
          color: CColor.white70,
          height: Utils.getAddKankotriHeight(),
          margin: EdgeInsets.only(top: Sizes.height_2),
          child: TextField(
            controller: logic.functionsMessageListController[index],
            onChanged: (value) {
              logic.changeValueInListForFunctions(
                  index, Constant.typeFunctionMessage, value);
            },
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: CColor.grayDark),
              ),
              border: const OutlineInputBorder(),
              labelText: 'txtSandesho'.tr,
              labelStyle: const TextStyle(color: CColor.grayDark),
              hintText: 'txtSandesho'.tr,
            ),
          ),
        ),
        _functionsNimantrakNamePart(context, index, logic),
      ],
    );
  }

  Widget _functionsNimantrakNamePart(BuildContext context, int mainIndex,
      AddKankotriController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin:
          EdgeInsets.only(bottom: Sizes.height_0_5, top: Sizes.height_2),
          child: AutoSizeText(
            maxLines: 1,
            "txtNimantrak".tr,
            style: TextStyle(
              color: CColor.grayDark,
              fontSize: FontSize.size_12,
              fontFamily: Constant.appFont,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return _listViewFunctionsNimantrakName(
                context, index, logic, mainIndex);
          },
          shrinkWrap: true,
          itemCount: logic.functionsList[mainIndex].listNames.length,
          physics: const NeverScrollableScrollPhysics(),
        ),
        Material(
          color: CColor.transparent,
          child: InkWell(
            splashColor: CColor.grayDark,
            onTap: () {
              logic.addRemoveFunctionsNimantrakName(true, mainIndex);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.22,
              margin: EdgeInsets.only(top: Sizes.height_1),
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.width_4, vertical: Sizes.height_1),
              decoration: BoxDecoration(
                color: CColor.grayDark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "+ ${"txtAdd".tr}",
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
      ],
    );
  }

  Widget _listViewFunctionsNimantrakName(BuildContext context, int index,
      AddKankotriController logic, int mainIndex) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Container(
        height: Utils.getAddKankotriHeight(),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        color: CColor.white70,
        child: TextField(
          controller: logic.functionsList[mainIndex].listEditTextNames[index],
          onChanged: (value) {
            logic.changeValueInListForFunctionsNimantrakName(
                index, mainIndex, value);
          },
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: CColor.grayDark),
            ),
            suffixIcon: (logic.functionsList[mainIndex].listNames.length == 1)
                ? null
                : InkWell(
              onTap: () {
                logic.addRemoveFunctionsNimantrakName(false, mainIndex,
                    index: index);
              },
              child: Container(
                padding: EdgeInsets.all(Sizes.height_1),
                child: SvgPicture.asset(
                  "assets/svg/ic_close.svg",
                ),
              ),
            ),
            suffixIconConstraints: BoxConstraints(
                minHeight: Sizes.height_3, minWidth: Sizes.height_3),
            border: const OutlineInputBorder(),
            labelText: 'txtNimantrakName'.tr,
            labelStyle: const TextStyle(color: CColor.grayDark),
            hintText: 'txtName'.tr,
          ),
        ),
      ),
    );
  }

  /*આમંત્રક*/
  Widget _amantrakPart(AddKankotriController logic, BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: Sizes.height_3),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: CColor.black,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                child: Text(
                  "txtAmantrak".tr,
                  style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_14,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: CColor.black,
                ),
              ),
            ],
          ),
        ),
        _fromGroomInfo(logic, context),
        _fromBrideInfo(logic, context),
      ],
    );
  }

  Widget _fromGroomInfo(AddKankotriController logic, BuildContext context) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idInviterPart,
        builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: Sizes.height_1),
                child: Text(
                  "1. ${"txtVarPakshTarafThi".tr}",
                  style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_14,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Sizes.height_2,
                    bottom: Sizes.height_1,
                    left: Sizes.width_1),
                child: Text(
                  "txtSandesho".tr,
                  style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_12,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                color: CColor.white70,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    items: logic.listOfMessagesFromGroom
                        .map((item) =>
                        DropdownMenuItem<String>(
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
                    value: logic.dropDownFromGroomMessage,
                    onChanged: (value) {
                      logic.changeDropDownValueForGroomBride(
                          value.toString(), Constant.typeGroom);
                    },
                    // buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: CColor.black,
                      ),
                      color: CColor.transparent,
                    ),
                    // buttonElevation: 2,
                    itemHeight: 50,
                    // itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    // dropdownMaxHeight: 200,
                    // dropdownWidth: 160,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CColor.white,
                    ),
                    // dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: Sizes.height_3,
                  left: Sizes.width_1,
                  bottom: Sizes.height_1,
                ),
                child: Text(
                  "txtMahiti".tr,
                  style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_12,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              (logic.listOfInvitersGroomMessage.isNotEmpty &&
                  logic.chirpingInfoGroom.values!.godName != null) ?
              Container(
                color: CColor.white70,
                height: Utils.getAddKankotriHeight(),
                child: TextField(
                  controller: logic.brideGodController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'txtBhagavaNuName'.tr,
                    labelStyle: const TextStyle(color: CColor.grayDark),
                    hintText: 'txtBhagavaNuName'.tr,
                  ),
                ),
              ) : Container(),

              (logic.listOfInvitersGroomMessage.isNotEmpty &&
                  logic.chirpingInfoGroom.values!.motherName != null) ?
              Container(
                color: CColor.white70,
                margin: EdgeInsets.only(
                  top: Sizes.height_2,
                ),
                height: Utils.getAddKankotriHeight(),
                child: TextField(
                  controller: logic.groomMotherNameController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'txtMataNuName'.tr,
                    labelStyle: const TextStyle(color: CColor.grayDark),
                    hintText: 'txtMataNuName'.tr,
                  ),
                ),
              ) : Container(),

              (logic.listOfInvitersGroomMessage.isNotEmpty &&
                  logic.chirpingInfoGroom.values!.fatherName != null) ?
              Container(
                color: CColor.white70,
                margin: EdgeInsets.only(
                  top: Sizes.height_2,
                ),
                height: Utils.getAddKankotriHeight(),
                child: TextField(
                  controller: logic.groomFatherNameController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'txtPitajiNuName'.tr,
                    labelStyle: const TextStyle(color: CColor.grayDark),
                    hintText: 'txtPitajiNuName'.tr,
                  ),
                ),
              ) : Container(),

              (logic.listOfInvitersGroomMessage.isNotEmpty &&
                  logic.chirpingInfoGroom.values!.hometownName != null) ?
              Container(
                color: CColor.white70,
                margin: EdgeInsets.only(
                  top: Sizes.height_2,
                ),
                height: Utils.getAddKankotriHeight(),
                child: TextField(
                  controller: logic.groomVillageNameController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'txtGamNuName'.tr,
                    labelStyle: const TextStyle(color: CColor.grayDark),
                    hintText: 'txtGamNuName'.tr,
                  ),
                ),
              ) : Container(),
            ],
          );
        });
  }

  Widget _fromBrideInfo(AddKankotriController logic, BuildContext context) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idInviterPart,
        builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: Sizes.height_3),
                child: Text(
                  "2. ${"txtKanyaPakshTarafThi".tr}",
                  style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_14,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Sizes.height_2,
                    bottom: Sizes.height_1,
                    left: Sizes.width_1),
                child: Text(
                  "txtSandesho".tr,
                  style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_12,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                color: CColor.white70,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    items: logic.listOfMessagesFromBride
                        .map((item) =>
                        DropdownMenuItem<String>(
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
                    value: logic.dropDownFromBrideMessage,
                    onChanged: (value) {
                      logic.changeDropDownValueForGroomBride(
                          value.toString(), Constant.typeBride);
                    },
                    // buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: CColor.black,
                      ),
                      color: CColor.transparent,
                    ),
                    // buttonElevation: 2,
                    itemHeight: 50,
                    // itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    // dropdownMaxHeight: 200,
                    // dropdownWidth: 160,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CColor.white,
                    ),
                    // dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: Sizes.height_3,
                  left: Sizes.width_1,
                  bottom: Sizes.height_1,
                ),
                child: Text(
                  "txtMahiti".tr,
                  style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_12,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              (logic.listOfInvitersBrideMessage.isNotEmpty &&
                  logic.chirpingInfoBride.values!.motherName != null) ?
              Container(
                color: CColor.white70,
                height: Utils.getAddKankotriHeight(),
                child: TextField(
                  controller: logic.brideMotherNameController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'txtMataNuName'.tr,
                    labelStyle: const TextStyle(color: CColor.grayDark),
                    hintText: 'txtMataNuName'.tr,
                  ),
                ),
              ) : Container(),

              (logic.listOfInvitersBrideMessage.isNotEmpty &&
                  logic.chirpingInfoBride.values!.fatherName != null) ?
              Container(
                color: CColor.white70,
                margin: EdgeInsets.only(
                  top: Sizes.height_2,
                ),
                height: Utils.getAddKankotriHeight(),
                child: TextField(
                  controller: logic.brideFatherNameController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'txtPitajiNuName'.tr,
                    labelStyle: const TextStyle(color: CColor.grayDark),
                    hintText: 'txtPitajiNuName'.tr,
                  ),
                ),
              ) : Container(),

              (logic.listOfInvitersBrideMessage.isNotEmpty &&
                  logic.chirpingInfoBride.values!.hometownName != null) ?
              Container(
                color: CColor.white70,
                margin: EdgeInsets.only(
                  top: Sizes.height_2,
                ),
                height: Utils.getAddKankotriHeight(),
                child: TextField(
                  controller: logic.brideVillageNameController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'txtGamNuName'.tr,
                    labelStyle: const TextStyle(color: CColor.grayDark),
                    hintText: 'txtGamNuName'.tr,
                  ),
                ),
              ) : Container(),

              (logic.listOfInvitersBrideMessage.isNotEmpty &&
                  logic.chirpingInfoBride.values!.godName != null) ?
              Container(
                margin: EdgeInsets.only(
                  top: Sizes.height_2,
                ),
                color: CColor.white70,
                height: Utils.getAddKankotriHeight(),
                child: TextField(
                  controller: logic.groomGodNameController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'txtBhagavaNuName'.tr,
                    labelStyle: const TextStyle(color: CColor.grayDark),
                    hintText: 'txtBhagavaNuName'.tr,
                  ),
                ),
              ) : Container(),

              /*Container(
                color: CColor.white70,
                margin: EdgeInsets.only(
                  top: Sizes.height_2,
                ),
                height: Utils.getAddKankotriHeight(),
                child: TextField(
                  onTap: () {
                    logic.selectDate(context, index: -1);
                  },
                  cursorHeight: 0,
                  readOnly: true,
                  cursorWidth: 0,
                  decoration: InputDecoration(
                    */
              /*suffixIcon: Container(
                margin: EdgeInsets.all(Sizes.height_1),
                child: SvgPicture.asset(
                  "assets/svg/ic_date.svg",
                ),
              ),*/
              /*
                    suffixIcon: Container(
                      padding: EdgeInsets.all(Sizes.height_1),
                      child: SvgPicture.asset(
                        "assets/svg/ic_date.svg",
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(
                        minHeight: Sizes.height_3, minWidth: Sizes.height_3),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
                    ),
                    border: const OutlineInputBorder(),
                    // hintText: 'txtLaganTarikh'.tr,
                    hintText: (logic.mrgDateGujarati != "")
                        ? logic.mrgDateGujarati.toString()
                        : 'txtLaganTarikh'.tr,
                  ),
                ),
              ),*/
            ],
          );
        });
  }

  /*આપને આવકારવા આતુર , લી. સ્નેહાધીન , મોસાળ પક્ષ , ભાણેજ પક્ષ*/
  Widget _guestAllNamesPart(BuildContext context, AddKankotriController logic) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idGuestNameAll,
        builder: (logic) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return _listViewGuestAllName(
                  context, index, logic, logic.guestNamesList);
            },
            shrinkWrap: true,
            itemCount: logic.guestNamesList.length,
            physics: const NeverScrollableScrollPhysics(),
          );
        });
  }

  Widget _listViewGuestAllName(BuildContext context, int mainIndex,
      AddKankotriController logic, List<GuestAllName> listOfGuestNameFirst) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(top: Sizes.height_3),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: CColor.black,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                child: Text(
                  listOfGuestNameFirst[mainIndex].titleName.toString(),
                  style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_14,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: CColor.black,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return _listViewGuestEdittextName(context, index, logic, mainIndex);
          },
          shrinkWrap: true,
          itemCount: logic.guestNamesList[mainIndex].listOfGuestNames.length,
          physics: const NeverScrollableScrollPhysics(),
        ),
        Material(
          color: CColor.transparent,
          child: InkWell(
            splashColor: CColor.grayDark,
            onTap: () {
              logic.addRemoveGuestNamesName(true, mainIndex);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.22,
              margin: EdgeInsets.only(
                top: Sizes.height_1,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.width_4, vertical: Sizes.height_1),
              decoration: BoxDecoration(
                color: CColor.grayDark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "+ ${"txtAdd".tr}",
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
      ],
    );
  }

  Widget _listViewGuestEdittextName(BuildContext context, int index,
      AddKankotriController logic, int mainIndex) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Container(
        height: Utils.getAddKankotriHeight(),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        color: CColor.white70,
        child: TextField(
          controller: logic.guestNamesList[mainIndex].listOfGuestNamesController![index],
          onChanged: (value) {
            logic.changeValueInListForGuestAllNames(index, mainIndex, value);
          },
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: CColor.grayDark),
            ),
            suffixIcon:
            (logic.guestNamesList[mainIndex].listOfGuestNames.length == 1)
                ? null
                : InkWell(
              onTap: () {
                logic.addRemoveGuestNamesName(false, mainIndex,
                    index: index);
              },
              child: Container(
                padding: EdgeInsets.all(Sizes.height_1),
                child: SvgPicture.asset(
                  "assets/svg/ic_close.svg",
                ),
              ),
            ),
            suffixIconConstraints: BoxConstraints(
                minHeight: Sizes.height_3, minWidth: Sizes.height_3),
            border: const OutlineInputBorder(),
            labelText: logic.guestNamesList[mainIndex].titleName.toString(),
            labelStyle: const TextStyle(color: CColor.grayDark),
            hintText: 'txtName'.tr,
          ),
        ),
      ),
    );
  }

  /*ટહુકો*/
  Widget _tahukoPart(BuildContext context, AddKankotriController logic) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idTahukoPart,
        builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(top: Sizes.height_3),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 2,
                        color: CColor.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                      child: Text(
                        "txtTahuko".tr,
                        style: TextStyle(
                          color: CColor.grayDark,
                          fontSize: FontSize.size_14,
                          fontFamily: Constant.appFont,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 2,
                        color: CColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Sizes.height_2),
                color: CColor.white70,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    items: logic.listOfAllStringChirping
                        .map((item) =>
                        DropdownMenuItem<String>(
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
                    value: logic.dropDownTahukoMessage,
                    onChanged: (value) {
                      logic.changeDropDownValueForTahuko(value.toString());
                    },
                    // buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: CColor.black,
                      ),
                      color: CColor.transparent,
                    ),
                    // buttonElevation: 2,
                    itemHeight: 50,
                    // itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    // dropdownMaxHeight: 200,
                    // dropdownWidth: 160,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CColor.white,
                    ),
                    // dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
              (logic.tahukoChildController.isNotEmpty)?
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        top: Sizes.height_3, left: Sizes.width_1),
                    child: Text(
                      "txtAmantrakName".tr,
                      style: TextStyle(
                        color: CColor.grayDark,
                        fontSize: FontSize.size_12,
                        fontFamily: Constant.appFont,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return _listViewTahukoChildNames(context, index, logic);
                    },
                    shrinkWrap: true,
                    itemCount: logic.listOfTahukoChildName.length,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  Material(
                    color: CColor.transparent,
                    child: InkWell(
                      splashColor: CColor.grayDark,
                      onTap: () {
                        logic.addRemoveTahukoChildName(true);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.22,
                        margin: EdgeInsets.only(
                          top: Sizes.height_1,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.width_4, vertical: Sizes.height_1),
                        decoration: BoxDecoration(
                          color: CColor.grayDark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "+ ${"txtAdd".tr}",
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
                ],
              ):Container(),

            ],
          );
        });
  }

  _listViewTahukoChildNames(BuildContext context, int index,
      AddKankotriController logic) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      height: Utils.getAddKankotriHeight(),
      width: MediaQuery
          .of(context)
          .size
          .width * 0.9,
      color: CColor.white70,
      child: TextField(
        controller: logic.tahukoChildController[index],
        onChanged: (value) {
          logic.changeValueInListForTahukoChildName(
              index, value);
        },
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: CColor.grayDark),
          ),
          suffixIcon: (logic.listOfTahukoChildName.length == 1)
              ? null
              : InkWell(
            onTap: () {
              logic.addRemoveTahukoChildName(false, index: index);
            },
            child: Container(
              padding: EdgeInsets.all(Sizes.height_1),
              child: SvgPicture.asset(
                "assets/svg/ic_close.svg",
              ),
            ),
          ),
          suffixIconConstraints: BoxConstraints(
              minHeight: Sizes.height_3, minWidth: Sizes.height_3),
          border: const OutlineInputBorder(),
          labelText: "txtName".tr,
          labelStyle: const TextStyle(color: CColor.grayDark),
          hintText: 'txtName'.tr,
        ),
      ),
    );
  }

  /*શુભ સ્થળ & શુભ લગ્ન સ્થળ*/
  Widget _subhSathal(BuildContext context, AddKankotriController logic) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idGoodPlaceAll,
        builder: (logic) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return _listViewGoodPlaceAllName(
                  context, index, logic, logic.goodPlaceNamesList);
            },
            shrinkWrap: true,
            itemCount: logic.goodPlaceNamesList.length,
            physics: const NeverScrollableScrollPhysics(),
          );
        });
  }

  Widget _listViewGoodPlaceAllName(BuildContext context, int mainIndex,
      AddKankotriController logic, List<GoodPlaceAllName> guestNamesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(top: Sizes.height_3),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: CColor.black,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                child: Text(
                  guestNamesList[mainIndex].titleName.toString(),
                  style: TextStyle(
                    color: CColor.grayDark,
                    fontSize: FontSize.size_14,
                    fontFamily: Constant.appFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Expanded(
                child: Divider(
                  thickness: 2,
                  color: CColor.black,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: Sizes.height_2, left: Sizes.width_1),
          child: Text(
            "txtAmantrakName".tr,
            style: TextStyle(
              color: CColor.grayDark,
              fontSize: FontSize.size_12,
              fontFamily: Constant.appFont,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          height: Utils.getAddKankotriHeight(),
          width: MediaQuery
              .of(context)
              .size
              .width * 0.9,
          color: CColor.white70,
          child: TextField(
            controller: logic.goodPlaceNamesList[mainIndex].inviterController,
            onChanged: (value) {
              logic.changeValueInListForGoodPlaceAmantrakName(mainIndex, value);
            },
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: CColor.grayDark),
              ),
              border: const OutlineInputBorder(),
              labelText: "txtName".tr,
              labelStyle: const TextStyle(color: CColor.grayDark),
              hintText: 'txtName'.tr,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: Sizes.height_3, left: Sizes.width_1),
          child: Text(
            "txtSarnamu".tr,
            style: TextStyle(
              color: CColor.grayDark,
              fontSize: FontSize.size_12,
              fontFamily: Constant.appFont,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return _listViewGoodAddress(
                context,
                index,
                logic,
                logic.goodPlaceNamesList[mainIndex].listOfAddressName,
                mainIndex);
          },
          shrinkWrap: true,
          itemCount:
          logic.goodPlaceNamesList[mainIndex].listOfAddressName.length,
          physics: const NeverScrollableScrollPhysics(),
        ),
        Material(
          color: CColor.transparent,
          child: InkWell(
            splashColor: CColor.grayDark,
            onTap: () {
              logic.addRemoveGoodPlaceNamesName(true, mainIndex, true);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.22,
              margin: EdgeInsets.only(
                top: Sizes.height_1,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.width_4, vertical: Sizes.height_1),
              decoration: BoxDecoration(
                color: CColor.grayDark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "+ ${"txtAdd".tr}",
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
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: Sizes.height_2, left: Sizes.width_1),
          child: Text(
            "txtMobile".tr,
            style: TextStyle(
              color: CColor.grayDark,
              fontSize: FontSize.size_12,
              fontFamily: Constant.appFont,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return _listViewGoodMno(context, index, logic,
                logic.goodPlaceNamesList[mainIndex].listOfMobile, mainIndex);
          },
          shrinkWrap: true,
          itemCount: logic.goodPlaceNamesList[mainIndex].listOfMobile.length,
          physics: const NeverScrollableScrollPhysics(),
        ),
        Material(
          color: CColor.transparent,
          child: InkWell(
            splashColor: CColor.grayDark,
            onTap: () {
              logic.addRemoveGoodPlaceNamesName(true, mainIndex, false);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.22,
              margin: EdgeInsets.only(
                top: Sizes.height_1,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.width_4, vertical: Sizes.height_1),
              decoration: BoxDecoration(
                color: CColor.grayDark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "+ ${"txtAdd".tr}",
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
      ],
    );
  }

  Widget _listViewGoodAddress(BuildContext context,
      int index,
      AddKankotriController logic,
      List<String> listOfAddressName,
      int mainIndex) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Column(
        children: [
          Container(
            height: Utils.getAddKankotriHeight(),
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            color: CColor.white70,
            child: TextField(
              controller: logic.goodPlaceNamesList[mainIndex].listEditTextAddress[index],
              onChanged: (value) {
                logic.changeValueInListForGoodPlace(
                    index, mainIndex, Constant.typeGoodPlaceAddress, value);
              },
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: CColor.grayDark),
                ),
                suffixIcon: (listOfAddressName.length == 1)
                    ? null
                    : InkWell(
                  onTap: () {
                    logic.addRemoveGoodPlaceNamesName(
                        false, mainIndex, true,
                        index: index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(Sizes.height_1),
                    child: SvgPicture.asset(
                      "assets/svg/ic_close.svg",
                    ),
                  ),
                ),
                suffixIconConstraints: BoxConstraints(
                    minHeight: Sizes.height_3, minWidth: Sizes.height_3),
                border: const OutlineInputBorder(),
                labelText: "txtAmantrakAddress".tr,
                labelStyle: const TextStyle(color: CColor.grayDark),
                hintText: 'txtAmantrakAddress'.tr,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listViewGoodMno(BuildContext context, int index,
      AddKankotriController logic, List<String> listOfMno, int mainIndex) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Container(
        height: Utils.getAddKankotriHeight(),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        color: CColor.white70,
        child: TextField(
          controller: logic.goodPlaceNamesList[mainIndex].listEditTextMobile[index],
          onChanged: (value) {
            logic.changeValueInListForGoodPlace(
                index, mainIndex, Constant.typeGoodPlaceMno, value);
          },
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: CColor.grayDark),
            ),
            suffixIcon: (listOfMno.length == 1)
                ? null
                : InkWell(
              onTap: () {
                logic.addRemoveGoodPlaceNamesName(false, mainIndex, false,
                    index: index);
              },
              child: Container(
                padding: EdgeInsets.all(Sizes.height_1),
                child: SvgPicture.asset(
                  "assets/svg/ic_close.svg",
                ),
              ),
            ),
            suffixIconConstraints: BoxConstraints(
                minHeight: Sizes.height_3, minWidth: Sizes.height_3),
            border: const OutlineInputBorder(),
            labelText: "txtAmantrakMno".tr,
            labelStyle: const TextStyle(color: CColor.grayDark),
            hintText: 'txtAmantrakMno'.tr,
          ),
        ),
      ),
    );
  }

  /*અટક*/
  Widget _atakName(BuildContext context, AddKankotriController logic) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Sizes.height_3),
            child: Row(
              children: [
                const Expanded(
                  child: Divider(
                    thickness: 2,
                    color: CColor.black,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                  child: Text(
                    "txtAṭak".tr,
                    style: TextStyle(
                      color: CColor.grayDark,
                      fontSize: FontSize.size_14,
                      fontFamily: Constant.appFont,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Expanded(
                  child: Divider(
                    thickness: 2,
                    color: CColor.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Sizes.height_3),
            child: Container(
              height: Utils.getAddKankotriHeight(),
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9,
              color: CColor.white70,
              child: TextField(
                controller: logic.atakController,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: CColor.grayDark),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: "txtAṭak".tr,
                  labelStyle: const TextStyle(color: CColor.grayDark),
                  hintText: 'txtAṭak'.tr,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /*ભગવાન ની માહિતી*/
  Widget _bhagavanNiMahiti(BuildContext context, AddKankotriController logic) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idGodNames,
        builder: (logic) {
          return Container(
            margin: EdgeInsets.only(bottom: Sizes.height_5),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: Sizes.height_3),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          color: CColor.black,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                        child: Text(
                          "txtBhagavanNiMahiti".tr,
                          style: TextStyle(
                            color: CColor.grayDark,
                            fontSize: FontSize.size_14,
                            fontFamily: Constant.appFont,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          color: CColor.black,
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return _listViewGodInfo(
                        context, logic, logic.listOfAllGods, index);
                  },
                  shrinkWrap: true,
                  itemCount: logic.listOfAllGods.length,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                Material(
                  color: CColor.transparent,
                  child: InkWell(
                    splashColor: CColor.grayDark,
                    onTap: () {
                      showCustomizeDialogForAddName(context, logic);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      margin: EdgeInsets.only(
                        top: Sizes.height_3,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.width_4, vertical: Sizes.height_1),
                      decoration: BoxDecoration(
                        color: CColor.grayDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "+ ${"txtAdd".tr}",
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
              ],
            ),
          );
        });
  }

  Widget _listViewGodInfo(BuildContext context, AddKankotriController logic,
      List<GodDetailInfo> godInformationList, int index) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.grayDark,
        onTap: () {
          logic.godSelectOnTap(index);
        },
        child: Container(
          margin: EdgeInsets.only(top: Sizes.height_2),
          child: Row(
            children: [
              (godInformationList[index].image != "")
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  height: Sizes.height_10,
                  width: Sizes.height_10,
                  child: CachedNetworkImage(
                    fadeInDuration: const Duration(milliseconds: 10),
                    fadeOutDuration: const Duration(milliseconds: 10),
                    fit: BoxFit.cover,
                    imageUrl: godInformationList[index].image.toString(),
                    placeholder: (context, url) =>
                    const Center(
                      child: SizedBox(
                        width: 60.0,
                        height: 60.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              )
                  : SizedBox(
                height: Sizes.height_10,
                width: Sizes.height_10,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: Sizes.height_10,
                      width: Sizes.height_10,
                      decoration: const BoxDecoration(
                        color: CColor.grayDark,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg/ic_image.svg',
                      color: CColor.gray,
                      width: Sizes.height_5,
                      height: Sizes.height_5,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
                  child: Text(
                    godInformationList[index].name.toString(),
                    style: TextStyle(
                      color: CColor.grayDark,
                      fontSize: FontSize.size_14,
                      fontFamily: Constant.appFont,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              (godInformationList[index].isSelected)
                  ? SizedBox(
                height: Sizes.height_3,
                width: Sizes.height_3,
                child: SvgPicture.asset("assets/svg/ic_selected.svg"),
              )
                  : SizedBox(
                height: Sizes.height_3,
                width: Sizes.height_3,
              )
            ],
          ),
        ),
      ),
    );
  }

  showCustomizeDialogForAddName(BuildContext context,
      AddKankotriController logic) {
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
        }).whenComplete(() =>
    {
      logic.addRemoveGodNamesName(
          true, logic.listOfAllGods.length + 1, logic.newGodName),
    });
  }

  contentBox(BuildContext context) {
    return GetBuilder<AddKankotriController>(
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
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: CColor.grayDark),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: "txtBhagavaNuName".tr,
                        labelStyle: const TextStyle(color: CColor.grayDark),
                        hintText: 'txtBhagavaNuName'.tr,
                      ),
                      controller: logic.godNameController,
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
                              logic.changeGodName(logic.godNameController.text);
                              logic.godNameController.clear();
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
                                "+ ${"txtAdd".tr}",
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

  /*End Of Form*/
  Widget _submitForm(BuildContext context, AddKankotriController logic) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizes.height_5, top: Sizes.height_3),
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
                      horizontal: Sizes.width_4, vertical: Sizes.height_1),
                  decoration: BoxDecoration(
                    // color: CColor.grayDark,
                    border: Border.all(color: CColor.grayDark, width: 1),
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
                  logic.getAllValue();
                  // Get.back();
                  logic.callCreateCardAPI(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    right: Sizes.width_2,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.width_4, vertical: Sizes.height_1),
                  decoration: BoxDecoration(
                    color: CColor.grayDark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "txtSubmit".tr,
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
    );
  }

  /*Image Picker Dialog*/
  Future<void> showOptionsDialog(BuildContext context,
      AddKankotriController logic) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("txtOptions".tr),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("txtCamera".tr),
                    onTap: () {
                      logic.selectImage(Constant.typeCamera);
                      Get.back();
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("txtGallery".tr),
                    onTap: () {
                      logic.selectImage(Constant.typeGallery);
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
