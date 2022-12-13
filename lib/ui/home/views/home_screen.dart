import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/ui/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/main/controllers/main_controller.dart';
import 'package:spotify_flutter_code/utils/color.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/sizer_utils.dart';

import '../../../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  MainController mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomeController>(builder: (logic) {
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
                  _widgetNewKankotri(logic, context),
                  _widgetSelectPreBuilt(logic, context),
                  _widgetDivider(),
                  _widgetCardListView(logic, context),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  showCustomizeDialogForChooseOptions(
      BuildContext context, HomeController logic) {
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
        });
  }

  contentBox(BuildContext context) {
    return GetBuilder<HomeController>(
        id: Constant.idGodNames,
        builder: (logic) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: Sizes.height_3,right: Sizes.width_5,
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
                /*Container(
                  margin: EdgeInsets.only(top: Sizes.height_2),
                  child: Text(
                    "txtPasandKaro".tr,
                    style: TextStyle(
                      color: CColor.black,
                      fontSize: FontSize.size_14,
                      fontFamily: Constant.appFont,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),*/
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
                            Get.toNamed(AppRoutes.addKankotri,arguments: [true])!.then((value) => Get.back());
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
                            Get.toNamed(AppRoutes.addKankotri,arguments: [false])!.then((value) => Get.back());
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
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.grayDark,
        onTap: () {
          showCustomizeDialogForChooseOptions(context,logic);
          // Get.toNamed(AppRoutes.addKankotri);
        },
        child: Container(
          margin: EdgeInsets.only(
              top: Sizes.height_3, left: Sizes.width_5, right: Sizes.width_5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: CColor.grayDark,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(Sizes.height_2_5),
          child: Text(
            "+ ${"txtNewKankotri".tr}",
            style: TextStyle(color: CColor.white, fontSize: FontSize.size_14,
                fontFamily: Constant.appFont,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  _widgetSelectPreBuilt(HomeController logic, BuildContext context) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.theme,
        onTap: () {
          mainController.changePosFromMain(1);
        },
        child: Container(
          margin: EdgeInsets.only(
              top: Sizes.height_3, left: Sizes.width_5, right: Sizes.width_5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: CColor.theme,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(Sizes.height_2_5),
          child: Text(
            "txtSelectPreBuiltSample".tr,
            style: TextStyle(color: CColor.white, fontSize: FontSize.size_14,
                fontFamily: Constant.appFont,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: Sizes.width_6,top: Sizes.height_4),
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
        Container(
          padding: EdgeInsets.only(top: Sizes.height_4,left:  Sizes.width_5),
          height: Sizes.height_37,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _itemCardView(index, context);
            },
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }

  _itemCardView(int index, BuildContext context) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.black,
        onTap: () {

        },
        child: Container(
          padding: EdgeInsets.only(right:Sizes.width_4),
          height: Sizes.height_15,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Image.asset(
            "assets/ic_card_demo.png",
          ),
        ),
      ),
    );
  }
}
