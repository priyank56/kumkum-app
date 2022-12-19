import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/ui/addKankotri/controllers/add_kankotri_controller.dart';
import 'package:spotify_flutter_code/ui/yourCard/controllers/your_card_controller.dart';

import '../../../custom/dialog/progressdialog.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';

class YourCardsScreen extends StatelessWidget {
  YourCardsScreen({Key? key}) : super(key: key);

  // YourCardsController yourCardsController = Get.find<YourCardsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<YourCardsController>(builder: (logic) {
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
                      _widgetPreBuilt(logic, context),
                      _widgetCardView(logic, context),
                    ],
                  ),
                ),
              );
            }),
            GetBuilder<YourCardsController>(
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

  _widgetPreBuilt(YourCardsController logic, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Sizes.height_1, left: Sizes.width_1, right: Sizes.width_5),
      padding: EdgeInsets.all(Sizes.height_2_5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "txtYourKonkotries".tr,
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

  _widgetCardView(YourCardsController logic, BuildContext context) {
    return GetBuilder<YourCardsController>(
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

  _itemCardView(int index, BuildContext context,YourCardsController logic) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.black,
        onTap: () {
          Get.toNamed(AppRoutes.addKankotri,arguments: [true,logic.allYourCardList[index],Constant.isFromUpdate])!.then((value) => logic.getAllYourCardsAPI(context));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Image.asset(
              "assets/ic_card_demo.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
