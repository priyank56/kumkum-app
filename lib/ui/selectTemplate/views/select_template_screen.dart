import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_flutter_code/ui/category/controllers/category_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/selectTemplate/controllers/select_template_controller.dart';
import 'package:spotify_flutter_code/ui/selectTemplate/controllers/select_template_controller.dart';
import 'package:spotify_flutter_code/ui/selectTemplate/controllers/select_template_controller.dart';
import 'package:spotify_flutter_code/ui/selectTemplate/controllers/select_template_controller.dart';
import 'package:spotify_flutter_code/ui/selectTemplate/controllers/select_template_controller.dart';
import 'package:spotify_flutter_code/ui/selectTemplate/controllers/select_template_controller.dart';

import '../../../custom/dialog/progressdialog.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import '../../addKankotri/datamodel/newKankotriData.dart';

class SelectTemplateScreen extends StatelessWidget {
  const SelectTemplateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<SelectTemplateController>(builder: (logic) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/main_bg.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _widgetTopBar(logic, context),
                      _widgetCardView(logic, context),
                    ],
                  ),
                ),
              );
            }),
            GetBuilder<SelectTemplateController>(
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

  _widgetTopBar(SelectTemplateController logic, BuildContext context) {
    return Container(
      color: CColor.white,
      padding: EdgeInsets.all(Sizes.height_2_5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Material(
            color: CColor.transparent,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              splashColor: CColor.black,
              child: Container(
                // margin: EdgeInsets.all(Sizes.height_2),
                child: SvgPicture.asset(
                  "assets/svg/login_flow/ic_back.svg",
                  height: Sizes.height_4,
                  width: Sizes.height_4,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: Sizes.width_3),
            child: Text(
              "txtSelectTemplate".tr,
              style: TextStyle(
                  color: CColor.black,
                  fontSize: FontSize.size_18,
                  fontFamily: Constant.appFont,
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  _widgetCardView(SelectTemplateController logic, BuildContext context) {
    return GetBuilder<SelectTemplateController>(
        id: Constant.idGetAllYourCards,
        builder: (logic) {
          return (logic.allYourCardList.isNotEmpty)?
          Container(
              margin: EdgeInsets.only(
                  left: Sizes.width_5, right: Sizes.width_5, bottom: Sizes.height_3,top: Sizes.height_3),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.8
                ),
                itemCount: logic.allYourCardList.length,
                itemBuilder: (context, index) {
                  return _itemCardView(index, context,logic);
                },
              )
          ):Container(
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
          );
        });
  }


  showCustomizeDialogForChooseOptions(BuildContext context, int index) {
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
    return GetBuilder<SelectTemplateController>(
        id: Constant.idGodNames,
        builder: (logic) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: Sizes.height_3, right: Sizes.width_5,
                      left: Sizes.width_5),
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
                          "txtPasandKaro".tr,
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
                  margin: EdgeInsets.only(
                      bottom: Sizes.height_3,
                      top: Sizes.height_3,
                      right: Sizes.width_5,
                      left: Sizes.width_5),
                  child: Column(
                    children: [
                      Material(
                        color: CColor.transparent,
                        child: InkWell(
                          splashColor: CColor.grayDark,
                          onTap: () {
                            ResultGet? getAllInvitationCard = logic.allYourCardList[index];
                            getAllInvitationCard.isGroom = true;
                            Get.toNamed(AppRoutes.addKankotri, arguments: [
                              true,
                              getAllInvitationCard,
                              Constant.isFromCreate,
                              Constant.isFromHomeScreen
                            ])!.then((value) => Get.back());
                          },
                          child: Container(
                            alignment: Alignment.center,

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
                              "txtVarPaksh".tr,
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
                      Material(
                        color: CColor.transparent,
                        child: InkWell(
                          splashColor: CColor.grayDark50,
                          onTap: () {
                            ResultGet? getAllInvitationCard = logic.allYourCardList[index];
                            getAllInvitationCard.isGroom = false;
                            Get.toNamed(AppRoutes.addKankotri, arguments: [
                              false,
                              getAllInvitationCard,
                              Constant.isFromCreate,
                              Constant.isFromHomeScreen
                            ])!.then((value) => Get.back());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: Sizes.height_2
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: Sizes.width_4,
                                vertical: Sizes.height_1),
                            decoration: BoxDecoration(
                              color: CColor.grayDark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "txtKanyaPaksh".tr,
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
                )
              ],
            ),
          );
        });
  }



  _itemCardView(int index, BuildContext context,SelectTemplateController logic) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.black,
        onTap: () {
          showCustomizeDialogForChooseOptions(context,index);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child : CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 10),
              fadeOutDuration: const Duration(milliseconds: 10),
              fit: BoxFit.cover,
              imageUrl: logic.allYourCardList[index].thumbnail.toString(),
              placeholder: (context, url) =>
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60.0,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
