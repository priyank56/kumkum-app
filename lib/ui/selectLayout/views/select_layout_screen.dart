import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/selectLayout/controllers/select_layout_controller.dart';

import '../../../custom/dialog/progressdialog.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/sizer_utils.dart';

class SelectLayoutScreen extends StatelessWidget {
  const SelectLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: "");
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              GetBuilder<SelectLayoutController>(builder: (logic) {
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
              GetBuilder<SelectLayoutController>(
                  id: Constant.isShowProgressUpload,
                  builder: (logic) {
                    return ProgressDialog(
                        inAsyncCall: logic.isShowProgress, child: Container());
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _widgetTopBar(SelectLayoutController logic, BuildContext context) {
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
                Get.back(result: "");
              },
              splashColor: CColor.black,
              child: SvgPicture.asset(
                "assets/svg/login_flow/ic_back.svg",
                height: Sizes.height_4,
                width: Sizes.height_4,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: Sizes.width_3),
            child: Text(
              "txtSelectLayout".tr,
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

  _widgetCardView(SelectLayoutController logic, BuildContext context) {
    return GetBuilder<SelectLayoutController>(
        id: Constant.idGetAllYourCards,
        builder: (logic) {
          return (logic.allYourCardList.isNotEmpty)
              ? Container(
                  margin: EdgeInsets.only(
                      left: Sizes.width_5,
                      right: Sizes.width_5,
                      bottom: Sizes.height_3,
                      top: Sizes.height_3),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.8),
                    itemCount: logic.allYourCardList.length,
                    itemBuilder: (context, index) {
                      return _itemCardView(index, context, logic);
                    },
                  ))
              : Container(
                  height: 500,
                  alignment: Alignment.center,
                  child: Text(
                    "txtNoDataFound".tr,
                    style: TextStyle(
                        color: (logic.isShowProgress)
                            ? CColor.transparent
                            : CColor.black,
                        fontSize: FontSize.size_14,
                        fontWeight: FontWeight.w500,
                        fontFamily: Constant.appFont),
                  ),
                );
        });
  }

  _itemCardView(int index, BuildContext context, SelectLayoutController logic) {
    return Material(
      color: CColor.transparent,
      child: InkWell(
        splashColor: CColor.black,
        onTap: () {
          var map = <String,String>{};
          map.putIfAbsent(Constant.layoutId, () => "idVal");
          map.putIfAbsent(Constant.layoutType, () => "typeVal");
          Get.back(result: map,canPop: true);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
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
