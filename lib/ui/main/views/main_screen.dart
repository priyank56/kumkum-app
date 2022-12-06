import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/ui/category/views/category_screen.dart';
import 'package:spotify_flutter_code/ui/contact/views/contact_screen.dart';
import 'package:spotify_flutter_code/ui/favourite/views/favourite_screen.dart';
import 'package:spotify_flutter_code/ui/home/views/home_screen.dart';
import 'package:spotify_flutter_code/utils/color.dart';
import 'package:spotify_flutter_code/utils/sizer_utils.dart';
import '../../../utils/debug.dart';
import '../controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<MainController>(builder: (logic) {
          return Column(
            children: [
              _topBar(logic),
              _centerView(logic),
              _bottomBar(logic),
            ],
          );
        }),
      ),
    );
  }

  Widget _topBar(MainController logic) {
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
          Material(
            color: CColor.transparent,
            child: InkWell(
              splashColor: CColor.black,
              onTap: () {
                Get.toNamed(AppRoutes.login);
              },
              child: Container(
                margin: EdgeInsets.only(right: Sizes.width_5,left: Sizes.width_5),
                height: Sizes.height_5,
                child: Image.asset("assets/ic_profile.png"),
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
          children: const [
            HomeScreen(),
            CategoryScreen(),
            FavouriteScreen(),
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
                  child: Image.asset((logic.currentPageViewPos == 0)
                      ? "assets/bottomBar/ic_home_selected.png"
                      : "assets/bottomBar/ic_home_un.png"),
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
                  // child: Image.asset("assets/ic_category_un.png"),
                  child: Image.asset((logic.currentPageViewPos == 1)
                      ? "assets/bottomBar/ic_category_selected.png"
                      : "assets/bottomBar/ic_category_un.png"),
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
                  // child: Image.asset("assets/ic_contact_un.png"),
                  child: Image.asset((logic.currentPageViewPos == 2)
                      ? "assets/bottomBar/ic_folder_selected.png"
                      : "assets/bottomBar/ic_folder_un.png"),
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
                  // child: Image.asset("assets/ic_home_un.png"),
                  child: Image.asset((logic.currentPageViewPos == 3)
                      ? "assets/bottomBar/ic_contact_selected.png"
                      : "assets/bottomBar/ic_contact_un.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
