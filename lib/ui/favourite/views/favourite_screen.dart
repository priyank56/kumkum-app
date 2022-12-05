import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/favourite/controllers/favourite_controller.dart';

import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<FavouriteController>(builder: (logic) {
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
      ),
    );
  }

  _widgetPreBuilt(FavouriteController logic, BuildContext context) {
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

  _widgetCardView(FavouriteController logic, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Sizes.width_5,right: Sizes.width_5,bottom: Sizes.height_3),
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
        itemCount: 10,
        // padding: EdgeInsets.only(left: Sizes.width_2, right: Sizes.width_2, bottom: Sizes.height_1_5),
        itemBuilder: (context, index) {
          return _itemCardView(index, context);
        },
      ),
    );
  }

  _itemCardView(int index, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          "assets/ic_card_demo.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
