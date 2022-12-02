import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/ui/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/utils/color.dart';
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
            child: Column(
              children: [
                _widgetNewKankotri(logic, context),
                _widgetSelectPreBuilt(logic, context),
              ],
            ),
          );
        }),
      ),
    );
  }

  _widgetNewKankotri(HomeController logic, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Sizes.height_3, left: Sizes.width_5, right: Sizes.width_5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: CColor.grayDark,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(Sizes.height_2_5),
      child: Text(
        "txtNewKankotri".tr,
        style: TextStyle(color: CColor.white, fontSize: FontSize.size_14),
        textAlign: TextAlign.center,
      ),
    );
  }

  _widgetSelectPreBuilt(HomeController logic, BuildContext context) {
    return Container(
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
        style: TextStyle(color: CColor.white, fontSize: FontSize.size_14),
        textAlign: TextAlign.center,
      ),
    );
  }
}
