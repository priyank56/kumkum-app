import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/main.dart';
import 'package:spotify_flutter_code/main.dart';
import 'package:spotify_flutter_code/ui/category/views/category_screen.dart';
import 'package:spotify_flutter_code/ui/contact/views/contact_screen.dart';
import 'package:spotify_flutter_code/ui/home/views/home_screen.dart';
import 'package:spotify_flutter_code/ui/yourCard/views/your_card_screen.dart';
import 'package:spotify_flutter_code/utils/color.dart';
import 'package:spotify_flutter_code/utils/sizer_utils.dart';
import '../../../utils/debug.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/utils.dart';
import '../controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GetBuilder<MainController>(builder: (logic) {
          return Column(
            children: [
              _topBar(logic, context),
              _centerView(logic),
              _bottomBar(logic),
            ],
          );
        }),
      ),
    );
  }

  Widget _topBar(MainController logic, BuildContext context) {
    return Container(
      color: CColor.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(Sizes.height_3),
              height: Sizes.height_2,
              child: Image.asset("assets/kumkum_text.png"),
            ),
          ),
          GestureDetector(
            onTapDown: (TapDownDetails details) async {
              double left = details.globalPosition.dx;
              double top = details.globalPosition.dy;
              await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(left, top + 30, 0, 0),
                items: [
                  PopupMenuItem<String>(
                    value: 'Logout',
                    onTap: () async {
                      await Future.delayed(Duration.zero);
                      showAlertDialog(context,logic);
                    },
                    child: Text('txtLogoutTitle'.tr),
                  ),
                ],
                elevation: 8.0,
              );
            },
            child: Container(
              height: Sizes.height_4,
              width: Sizes.height_4,
              margin:
                  EdgeInsets.only(right: Sizes.width_5, left: Sizes.width_5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: (logic.auth.currentUser!.photoURL != null)?
                CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 10),
                  fadeOutDuration: const Duration(milliseconds: 10),
                  fit: BoxFit.cover,
                  imageUrl: logic.auth.currentUser!.photoURL.toString(),
                  // imageUrl: "https://acvstorageprod.blob.core.windows.net/tmp-img/744e88ca-6ccaea13022e-thumbnail.png",
                  placeholder: (context, url) => Utils.bgShimmer(context),
                  errorWidget: (context, url, error) {
                    return Container(
                      color: CColor.borderColor,
                    );
                  },
                ):Container(
                  color: CColor.blueDark,
                  padding: const EdgeInsets.all(7),
                  child: SvgPicture.asset("assets/svg/ic_profile.svg",color: CColor.white,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _centerView(MainController logic) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/main_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: logic.pageController,
          scrollDirection: Axis.horizontal,
          children: [
            HomeScreen(),
            const CategoryScreen(),
            YourCardsScreen(),
            ContactScreen()
          ],
          onPageChanged: (pos) {
            Debug.printLog("Position=>>> $pos");
            logic.changePageViewPos(pos);
          },
        ),
      ),
    );
  }

  Widget _bottomBar(MainController logic) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: Sizes.height_2),
      // color: CColor.themeDark,
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: CColor.transparent,
              child: InkWell(
                splashColor: CColor.black,
                onTap: () {
                  logic.changePageViewPos(0);
                },
                child: Container(
                  height: Sizes.height_3_5,
                  margin: EdgeInsets.all(Sizes.height_2),
                  child: SvgPicture.asset((logic.currentPageViewPos == 0)
                      ? "assets/svg/ic_home_selected.svg"
                      : "assets/svg/ic_home_un.svg"),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: CColor.transparent,
              child: InkWell(
                splashColor: CColor.black,
                onTap: () {
                  logic.changePageViewPos(1);
                },
                child: Container(
                  margin: EdgeInsets.all(Sizes.height_2),
                  height: Sizes.height_3_5,
                  child: SvgPicture.asset((logic.currentPageViewPos == 1)
                      ? "assets/svg/ic_category_selected.svg"
                      : "assets/svg/ic_category_un.svg"),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: CColor.transparent,
              child: InkWell(
                splashColor: CColor.black,
                onTap: () {
                  logic.changePageViewPos(2);
                },
                child: Container(
                  height: Sizes.height_3_5,
                  margin: EdgeInsets.all(Sizes.height_2),
                  child: SvgPicture.asset((logic.currentPageViewPos == 2)
                      ? "assets/svg/ic_folder_selected.svg"
                      : "assets/svg/ic_folder_un.svg"),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: CColor.transparent,
              child: InkWell(
                splashColor: CColor.black,
                onTap: () {
                  logic.changePageViewPos(3);
                },
                child: Container(
                  margin: EdgeInsets.all(Sizes.height_2),
                  height: Sizes.height_3_5,
                  child: SvgPicture.asset((logic.currentPageViewPos == 3)
                      ? "assets/svg/ic_contact_selected.svg"
                      : "assets/svg/ic_contact_un.svg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, MainController logic) {
    // Create button
    Widget okButton = TextButton(
      child: Text("txtOk".tr),
      onPressed: () {
        logic.logout();
      },
    );

    Widget cancelButton = TextButton(
      child: Text("txtCancel".tr),
      onPressed: () {
        Get.back();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("txtLogoutTitle".tr),
      content: Text("txtLogoutMessage".tr),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
