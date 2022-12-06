import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify_flutter_code/ui/category/bindings/category_binding.dart';
import 'package:spotify_flutter_code/ui/contact/views/contact_screen.dart';
import 'package:spotify_flutter_code/ui/favourite/bindings/favourite_binding.dart';
import 'package:spotify_flutter_code/ui/favourite/views/favourite_screen.dart';
import 'package:spotify_flutter_code/ui/login/bindings/login_binding.dart';
import 'package:spotify_flutter_code/ui/main/bindings/main_binding.dart';
import 'package:spotify_flutter_code/ui/main/views/main_screen.dart';

import '../ui/category/views/category_screen.dart';
import '../ui/contact/bindings/contact_binding.dart';
import '../ui/home/bindings/home_binding.dart';
import '../ui/home/views/home_screen.dart';
import '../ui/login/views/login_screen.dart';
import '../utils/color.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.main,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: MainScreen(),
          );
        },
      ),
      binding: MainBinding(),
      transition: Transition.fade,
    ),


    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.fade,
    ),

    /*Bottom Bar Nav*/
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.category,
      page: () => const CategoryScreen(),
      binding: CategoryBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.favourite,
      page: () => const FavouriteScreen(),
      binding: FavouriteBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.contact,
      page: () => const ContactScreen(),
      binding: ContactBinding(),
      transition: Transition.fade,
    ),



  ];
}
