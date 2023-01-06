import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_flutter_code/ui/category/controllers/category_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/utils/debug.dart';

import '../../../custom/dialog/progressdialog.dart';
import '../../../datamodel/createData.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';
import '../../../utils/utils.dart';
import '../../addKankotri/controllers/add_kankotri_controller.dart';
import '../../addKankotri/datamodel/newKankotriData.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<CategoryController>(builder: (logic) {
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
                      _widgetPreBuilt(logic, context),
                      _widgetCardView(logic, context),
                    ],
                  ),
                ),
              );
            }),
            GetBuilder<CategoryController>(
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

  _widgetPreBuilt(CategoryController logic, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Sizes.height_1, left: Sizes.width_1, right: Sizes.width_5),
      padding: EdgeInsets.all(Sizes.height_2_5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "txtPreBuiltDesigns".tr,
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

  _widgetCardView(CategoryController logic, BuildContext context) {
    return GetBuilder<CategoryController>(
        id: Constant.idGetAllYourCards,
        builder: (logic) {
          return (logic.allYourCardList.isNotEmpty)?
          Container(
              margin: EdgeInsets.only(
                  left: Sizes.width_5, right: Sizes.width_5, bottom: Sizes.height_3),
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

  _itemCardView(int index, BuildContext context,CategoryController logic) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 10),
              fadeOutDuration: const Duration(milliseconds: 10),
              fit: BoxFit.cover,
              imageUrl: logic.allYourCardList[index].thumbnail.toString(),
              placeholder: (context, url) =>
                  Utils.bgShimmer(context),
              errorWidget: (context, url, error) {
                return Container(
                  color: CColor.borderColor,
                );
              },
            ),
          ),
          Container(
            color: CColor.black50,
          ),
          Center(
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Get.toNamed(AppRoutes.addKankotri,arguments: [true,logic.allYourCardList[index],Constant.isFromCreate,Constant.isFromCategoryScreen])!.then((value) => logic.getAllPreBuiltCardsAPI(context));
                      Get.toNamed(AppRoutes.addKankotri, arguments: [
                        logic.allYourCardList[index].isGroom,
                        logic.allYourCardList[index],
                        Constant.isFromCreate,
                        Constant.isFromCategoryScreen
                      ])!
                          .then((value) =>
                              logic.getAllPreBuiltCardsAPI(context));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: Sizes.height_2),
                      child: SvgPicture.asset(
                        "assets/svg/ic_edit.svg",
                        color: CColor.white,
                        height: Sizes.height_3,
                        width: Sizes.height_3,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      List<PreviewFunctions> functionStringTitleList = [];
                      List<FunctionsRes> list = logic.allYourCardList[index].marriageInvitationCard!.functions!;
                      for(int i =0;i<list.length;i++){
                        functionStringTitleList.add(PreviewFunctions(list[i].functionId, list[i].functionName ?? "",'txtSarvo'.tr));
                      }
                      Debug.printLog("Prebuilt URL==>>> ${logic.allYourCardList[index].previewUrl}");
                      var data = logic.allYourCardList[index];
                      CreateData createData = CreateData();
                      createData.marriageInvitationCard = MarriageInvitationCard();
                      createData.marriageInvitationCardId=data.marriageInvitationCardId;
                      createData.marriageInvitationCardName=data.marriageInvitationCardName;
                      // createData.marriageInvitationCard = data.marriageInvitationCard;
                      createData.marriageInvitationCardType=data.marriageInvitationCardType;
                      createData.layoutDesignId=data.layoutDesignId;

                      var mrgData = data.marriageInvitationCard;

                      createData.marriageInvitationCard!.functions = [];
                      List<Functions> functionsList = [];

                      var funcSendData = Functions();
                      var functionsListGet =  mrgData!.functions!;
                      for(var i = 0 ; i < functionsListGet.length ; i ++){
                        var functions = functionsListGet[i];
                        funcSendData.functionId = functions.functionId;
                        funcSendData.functionName = functions.functionName;
                        funcSendData.functionDate = functions.functionDate;
                        funcSendData.functionTime = functions.functionTime;
                        funcSendData.message = functions.message;
                        funcSendData.inviter = functions.inviter;
                        funcSendData.banquetPerson = functions.banquetPerson;
                        funcSendData.functionPlace = functions.functionPlace;
                        functionsList.add(funcSendData);
                      }
                      createData.marriageInvitationCard!.functions = functionsList;

                      Get.toNamed(AppRoutes.preview, arguments: [
                        createData,
                        functionStringTitleList,
                        logic.allYourCardList[index].previewUrl ??
                            Constant.dummyPreviewURL,
                        Constant.isFromCategoryScreen,
                        Constant.isFromCategoryPreview,
                        true
                      ]);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: Sizes.height_2),
                      child: SvgPicture.asset(
                        "assets/svg/ic_show.svg",
                        color: CColor.white,
                        height: Sizes.height_3,
                        width: Sizes.height_3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
