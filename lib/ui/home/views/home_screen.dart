import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/ui/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/utils/color.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/sizer_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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

  _widgetNewKankotri(HomeController logic, BuildContext context) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.grayDark,
        onTap: () {

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
