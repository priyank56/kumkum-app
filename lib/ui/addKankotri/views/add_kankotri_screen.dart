import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/ui/addKankotri/controllers/add_kankotri_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_flutter_code/utils/utils.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddKankotriScreen extends StatelessWidget {
  const AddKankotriScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AddKankotriController>(builder: (logic) {
          return Column(
            children: [
              _topBar(logic),
              _centerView(logic, context),
            ],
          );
        }),
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
                _widgetImageView(logic),
                _varPaksh(logic, context),
                _kanyaPaksh(logic, context),
                _mrgTarikh(logic, context),
                _nimantrak(logic, context),
                _functionsAll(logic, context),
                _amantrakPart(logic, context),
                _aapneAavkarvaAaturPart(context, logic),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _widgetImageView(AddKankotriController logic) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_3),
      child: Stack(
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
      ),
    );
  }

  Widget _varPaksh(AddKankotriController logic, BuildContext context) {
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
                width: MediaQuery.of(context).size.width * 0.9,
                color: CColor.white70,
                // margin: EdgeInsets.only(left: Sizes.width_5),
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
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
                width: MediaQuery.of(context).size.width * 0.9,
                height: Utils.getAddKankotriHeight(),
                color: CColor.white70,
                // margin: EdgeInsets.only(left: Sizes.width_5),
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
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
  }

  Widget _kanyaPaksh(AddKankotriController logic, BuildContext context) {
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
                width: MediaQuery.of(context).size.width * 0.9,
                color: CColor.white70,
                // margin: EdgeInsets.only(left: Sizes.width_5),
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
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
                width: MediaQuery.of(context).size.width * 0.9,
                color: CColor.white70,
                height: Utils.getAddKankotriHeight(),
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
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
  }

  Widget _mrgTarikh(AddKankotriController logic, BuildContext context) {
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
                width: MediaQuery.of(context).size.width * 0.9,
                color: CColor.white70,
                child: TextField(
                  onTap: () {
                    logic.selectDate(context);
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
                        minHeight: Sizes.height_3, minWidth: Sizes.height_3),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: CColor.grayDark),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'txtTarikh'.tr,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
              width: MediaQuery.of(context).size.width * 0.22,
              margin: EdgeInsets.only(
                  top: Sizes.height_1,),
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

  Widget _listViewNimantrakName(
      BuildContext context, int index, AddKankotriController logic) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Container(
        height: Utils.getAddKankotriHeight(),
        width: MediaQuery.of(context).size.width * 0.9,
        color: CColor.white70,
        child: TextField(
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

  Widget _nimantrakAddressPart(
      BuildContext context, AddKankotriController logic) {
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
              width: MediaQuery.of(context).size.width * 0.22,
              margin: EdgeInsets.only(
                  top: Sizes.height_1,),
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

  Widget _listViewNimantrakAddress(
      BuildContext context, int index, AddKankotriController logic) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Container(
        color: CColor.white70,
        height: Utils.getAddKankotriHeight(),
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
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

  Widget _nimantrakMobilePart(
      BuildContext context, AddKankotriController logic) {
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
              width: MediaQuery.of(context).size.width * 0.22,
              margin: EdgeInsets.only(
                  top: Sizes.height_1),
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

  Widget _listViewNimantrakMobile(
      BuildContext context, int index, AddKankotriController logic) {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Container(
        color: CColor.white70,
        height: Utils.getAddKankotriHeight(),
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
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
                    onTap: () {
                      logic.selectDate(context);
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
                      hintText: 'txtTarikh'.tr,
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
                    onTap: () {
                      logic.selectTime(context);
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
                      hintText: 'txtSamay'.tr,
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

  Widget _functionsNimantrakNamePart(
      BuildContext context, int mainIndex, AddKankotriController logic) {
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
              width: MediaQuery.of(context).size.width * 0.22,
              margin: EdgeInsets.only(
                  top: Sizes.height_1),
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
    /*return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Row(
        children: [
          Container(
            color: CColor.white70,
            height: Utils.getAddKankotriHeight(),
            width: (logic.functionsList[mainIndex].listNames.length == 1)
                ? MediaQuery.of(context).size.width * 0.9
                : MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: CColor.grayDark),
                ),
                border: const OutlineInputBorder(),
                labelText: 'txtNimantrakName'.tr,
                labelStyle: const TextStyle(color: CColor.grayDark),
                hintText: 'txtName'.tr,
              ),
            ),
          ),
          (logic.functionsList[mainIndex].listNames.length != 1)
              ? Material(
                  color: CColor.transparent,
                  child: InkWell(
                    splashColor: CColor.black,
                    onTap: () {
                      logic.addRemoveFunctionsNimantrakName(false, mainIndex,
                          index: index);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      // color: Colors.cyan,
                      child: SvgPicture.asset("assets/svg/ic_close.svg"),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );*/
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Container(
        height: Utils.getAddKankotriHeight(),
        width: MediaQuery.of(context).size.width * 0.9,
        color: CColor.white70,
        child: TextField(
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: CColor.grayDark),
            ),
            suffixIcon: (logic.functionsList[mainIndex].listNames.length != 1)
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
              top: Sizes.height_2, bottom: Sizes.height_1, left: Sizes.width_1),
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
              hint: Row(
                children: const [
                  Expanded(
                    child: Text(
                      "logic.displayDefaultVal",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CColor.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: logic.listOfChirping
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
              value: "1",
              onChanged: (value) {
                // logic.changeDropDownValue(value.toString());
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
        Container(
          color: CColor.white70,
          height: Utils.getAddKankotriHeight(),
          child: TextField(
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
        ),
        Container(
          color: CColor.white70,
          margin: EdgeInsets.only(
            top: Sizes.height_2,
          ),
          height: Utils.getAddKankotriHeight(),
          child: TextField(
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
        ),
        Container(
          color: CColor.white70,
          margin: EdgeInsets.only(
            top: Sizes.height_2,
          ),
          height: Utils.getAddKankotriHeight(),
          child: TextField(
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
        ),
        Container(
          color: CColor.white70,
          margin: EdgeInsets.only(
            top: Sizes.height_2,
          ),
          height: Utils.getAddKankotriHeight(),
          child: TextField(
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
        ),
      ],
    );
  }

  Widget _fromBrideInfo(AddKankotriController logic, BuildContext context) {
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
              top: Sizes.height_2, bottom: Sizes.height_1, left: Sizes.width_1),
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
              hint: Row(
                children: const [
                  Expanded(
                    child: Text(
                      "logic.displayDefaultVal",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: CColor.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: logic.listOfChirping
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
              value: "1",
              onChanged: (value) {
                // logic.changeDropDownValue(value.toString());
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
        Container(
          color: CColor.white70,
          height: Utils.getAddKankotriHeight(),
          child: TextField(
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
        ),
        Container(
          color: CColor.white70,
          margin: EdgeInsets.only(
            top: Sizes.height_2,
          ),
          height: Utils.getAddKankotriHeight(),
          child: TextField(
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
        ),
        Container(
          color: CColor.white70,
          margin: EdgeInsets.only(
            top: Sizes.height_2,
          ),
          height: Utils.getAddKankotriHeight(),
          child: TextField(
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
        ),
        Container(
          color: CColor.white70,
          margin: EdgeInsets.only(
            top: Sizes.height_2,
          ),
          height: Utils.getAddKankotriHeight(),
          child: TextField(
            onTap: () {
              logic.selectDate(context);
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
                borderSide: BorderSide(width: 2, color: CColor.grayDark),
              ),
              border: const OutlineInputBorder(),
              hintText: 'txtLaganTarikh'.tr,
            ),
          ),
        ),
      ],
    );
  }

  /*આપને આવકારવા આતુર*/
  Widget _aapneAavkarvaAaturPart(
      BuildContext context, AddKankotriController logic) {
    return GetBuilder<AddKankotriController>(
        id: Constant.idGuestNameFirst,
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
                        "txtAapneAavkarvaAatur".tr,
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
                margin: EdgeInsets.only(bottom: Sizes.height_0_5),
                child: AutoSizeText(
                  maxLines: 1,
                  "txtMehmanName".tr,
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
                  return _listViewAapneAavkarvaAatur(context, index, logic);
                },
                shrinkWrap: true,
                itemCount: logic.listOfGuestNameFirst.length,
                physics: const NeverScrollableScrollPhysics(),
              ),
              Material(
                color: CColor.transparent,
                child: InkWell(
                  splashColor: CColor.grayDark,
                  onTap: () {
                    logic.addGuestNameFirsListData(true);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.22,
                    margin: EdgeInsets.only(
                        top: Sizes.height_1,),
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
        });
  }

  Widget _listViewAapneAavkarvaAatur(
      BuildContext context, int index, AddKankotriController logic) {
    /*return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Row(
        children: [
          SizedBox(
            height: Utils.getAddKankotriHeight(),
            width: (logic.listOfGuestNameFirst.length == 1)
                ? MediaQuery.of(context).size.width * 0.9
                : MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: CColor.grayDark),
                ),
                border: const OutlineInputBorder(),
                labelText: 'txtMehmanName'.tr,
                labelStyle: const TextStyle(color: CColor.grayDark),
                hintText: 'txtName'.tr,
              ),
            ),
          ),
          (logic.listOfGuestNameFirst.length != 1)
              ? Material(
                  color: CColor.transparent,
                  child: InkWell(
                    splashColor: CColor.black,
                    onTap: () {
                      logic.addGuestNameFirsListData(false, index: index);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      // color: Colors.cyan,
                      child: SvgPicture.asset("assets/svg/ic_close.svg"),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );*/
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_1),
      child: Container(
        height: Utils.getAddKankotriHeight(),
        width: MediaQuery.of(context).size.width * 0.9,
        color: CColor.white70,
        child: TextField(
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: CColor.grayDark),
            ),
            suffixIcon: (logic.listOfGuestNameFirst.length == 1)
                ? null
                : InkWell(
              onTap: () {
                logic.addGuestNameFirsListData(false, index: index);
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
            labelText: 'txtMehmanName'.tr,
            labelStyle: const TextStyle(color: CColor.grayDark),
            hintText: 'txtName'.tr,
          ),
        ),
      ),
    );
  }
}
