import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/ui/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/main/controllers/main_controller.dart';
import 'package:spotify_flutter_code/utils/color.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/sizer_utils.dart';

import '../../../custom/dialog/progressdialog.dart';
import '../../../utils/utils.dart';
import '../../addKankotri/datamodel/newKankotriData.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<HomeController>(builder: (logic) {
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
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _widgetNewKankotri(logic, context),
                      _widgetSelectPreBuilt(logic, context),
                      _widgetDivider(),
                      _widgetCardListView(logic, context),
                    ],
                  ),
                ),
              );
            }),
            GetBuilder<HomeController>(
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

  showCustomizeDialogForChooseOptions(BuildContext context, HomeController logic, bool isFromAddCard,{int? index = -1}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            runAlignment: WrapAlignment.center,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: contentBox(context,isFromAddCard,index:index),
              ),
            ],
          );
        });
  }

  contentBox(BuildContext context, bool isFromAddCard,{int? index = -1}) {
    return GetBuilder<HomeController>(
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
                            if(index != -1){
                              ResultGet? getAllInvitationCard = logic.allYourCardList[index!];
                              getAllInvitationCard.isGroom = true;
                              Get.toNamed(AppRoutes.addKankotri, arguments: [
                                true,
                                getAllInvitationCard,
                                Constant.isFromCreate,
                                Constant.isFromHomeScreen
                              ])!.then((value) => Get.back());
                            }else{
                              Get.toNamed(AppRoutes.addKankotri, arguments: [
                                true,
                                null,
                                Constant.isFromCreate,
                                Constant.isFromHomeScreen
                              ])!.then((value) => Get.back());
                            }

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
                            if(index != -1){
                              ResultGet? getAllInvitationCard = logic.allYourCardList[index!];
                              Get.toNamed(AppRoutes.addKankotri, arguments: [
                                false,
                                getAllInvitationCard,
                                Constant.isFromCreate,
                                Constant.isFromHomeScreen
                              ])!.then((value) => Get.back());
                            }else{
                              Get.toNamed(AppRoutes.addKankotri, arguments: [
                                false,
                                null,
                                Constant.isFromCreate,
                                Constant.isFromHomeScreen
                              ])!.then((value) => Get.back());
                            }
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

  _widgetNewKankotri(HomeController logic, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
          top: Sizes.height_3,  left: Sizes.width_5, right: Sizes.width_5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CColor.grayDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // <-- Radius
          ),
          textStyle: TextStyle(color: CColor.white, fontSize: FontSize.size_14,
              fontFamily: Constant.appFont,
              fontWeight: FontWeight.w700),
        ),
        onPressed: () {
          Get.toNamed(AppRoutes.selectTemplate);
        },
        child: Container(
          padding: EdgeInsets.all(Sizes.height_2_5),
          child: Text("+ ${"txtNewKankotri".tr}",),
        ),
      ),
    );
  }

  _widgetSelectPreBuilt(HomeController logic, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
          top: Sizes.height_3,  left: Sizes.width_5, right: Sizes.width_5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CColor.theme,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // <-- Radius
          ),
          textStyle: TextStyle(color: CColor.white, fontSize: FontSize.size_14,
              fontFamily: Constant.appFont,
              fontWeight: FontWeight.w700),
        ),
        onPressed: () {
          mainController.changePosFromMain(1);
        },
        child: Container(
          padding: EdgeInsets.all(Sizes.height_2_5),
          child: Text("txtSelectPreBuiltSample".tr),
        ),
      ),
    );
  }

  _widgetDivider() {
    return Container(
      margin: EdgeInsets.only(top: Sizes.height_5),
      child: const Divider(
        height: 1,
        thickness: 1,
        color: CColor.grayDark,
      ),
    );
  }

  _widgetCardListView(HomeController logic, BuildContext context) {
    return GetBuilder<HomeController>(
        id: Constant.idMainPage,
        builder: (logic) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: Sizes.width_6, top: Sizes.height_4),
            child: Text(
              "txtElegentDesigns".tr,
              style: TextStyle(
                  color: CColor.black,
                  fontSize: FontSize.size_18,
                  fontFamily: Constant.appFont,
                  fontWeight: FontWeight.w700
              ),
              textAlign: TextAlign.start,
            ),
          ),
          (logic.allYourCardList.isNotEmpty) ?
          Container(
            padding: EdgeInsets.only(top: Sizes.height_4, left: Sizes.width_5),
            height: Sizes.height_37,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _itemCardView(index, context, logic);
              },
              shrinkWrap: true,
              itemCount: logic.allYourCardList.length,
              scrollDirection: Axis.horizontal,
            ),
          ) : Container(
            height: 400,
            alignment: Alignment.center,
            child: Text(
              "txtNoDataFoundDesign".tr,
              style: TextStyle(
                  color: (logic.isShowProgress) ? CColor.transparent : CColor
                      .black,
                  fontSize: FontSize.size_14,
                  fontWeight: FontWeight.w500,
                  fontFamily: Constant.appFont
              ),
            ),
          )
        ],
      );
    });
  }

  _itemCardView(int index, BuildContext context, HomeController logic) {
    return InkWell(
      onTap: () {
        showCustomizeDialogForChooseOptions(context, logic,false,index: index);
        // Get.toNamed(AppRoutes.addKankotri,arguments: [true,logic.allYourCardList[index],Constant.isFromCreate,Constant.isFromCategoryScreen])!.then((value) => logic.getAllPreBuiltCardsAPI(context));
      },
      child: Container(
        height: Sizes.height_15,
        width: MediaQuery.of(context).size.width * 0.55,
        padding: EdgeInsets.only(right: Sizes.width_5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.height_2),
          child: Container(
            // margin: EdgeInsets.only(right:Sizes.width_4),

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 10),
              fadeOutDuration: const Duration(milliseconds: 10),
              fit: BoxFit.cover,
              imageUrl: logic.allYourCardList[index].thumbnail.toString(),
              placeholder: (context, url) =>
             /* const Center(
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
      ),
    );
  }

}
