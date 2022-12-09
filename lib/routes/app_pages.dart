import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:spotify_flutter_code/ui/addKankotri/bindings/add_kankotri_binding.dart';
import 'package:spotify_flutter_code/ui/addKankotri/views/add_kankotri_screen.dart';
import 'package:spotify_flutter_code/ui/category/bindings/category_binding.dart';
import 'package:spotify_flutter_code/ui/contact/views/contact_screen.dart';
import 'package:spotify_flutter_code/ui/favourite/bindings/favourite_binding.dart';
import 'package:spotify_flutter_code/ui/favourite/views/favourite_screen.dart';
import 'package:spotify_flutter_code/ui/forgotpass/bindings/forgot_binding.dart';
import 'package:spotify_flutter_code/ui/login/bindings/login_binding.dart';
import 'package:spotify_flutter_code/ui/main/bindings/main_binding.dart';
import 'package:spotify_flutter_code/ui/main/views/main_screen.dart';
import 'package:spotify_flutter_code/ui/otp/bindings/otp_binding.dart';
import 'package:spotify_flutter_code/ui/otp/views/otp_screen.dart';
import 'package:spotify_flutter_code/ui/preview/bindings/preview_binding.dart';
import 'package:spotify_flutter_code/ui/preview/views/preview_screen.dart';
import 'package:spotify_flutter_code/ui/signup/bindings/signup_binding.dart';
import 'package:spotify_flutter_code/ui/signup/views/signup_screen.dart';
import '../ui/category/views/category_screen.dart';
import '../ui/contact/bindings/contact_binding.dart';
import '../ui/forgotpass/views/forgot_screen.dart';
import '../ui/home/bindings/home_binding.dart';
import '../ui/home/views/home_screen.dart';
import '../ui/login/views/login_screen.dart';
import '../utils/color.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.addKankotri,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: AddKankotriScreen(),
          );
        },
      ),
      binding: AddKankotriBinding(),
      transition: Transition.fade,
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: LoginScreen(),
          );
        },
      ),
      binding: LoginBinding(),
      transition: Transition.fade,
    ),

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

    /*GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
      transition: Transition.fade,
    ),*/

    GetPage(
      name: AppRoutes.preview,
      page: () => const PreviewScreen(),
      binding: PreviewBinding(),
      transition: Transition.fade,
    ),


    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignupScreen(),
      binding: SignupBinding(),
      transition: Transition.fade,
    ),


    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      binding: OtpBinding(),
      transition: Transition.fade,
    ),

    GetPage(
      name: AppRoutes.forgotPass,
      page: () => const ForgotScreen(),
      binding: ForgotBinding(),
      transition: Transition.fade,
    ),




    /*Bottom Bar Nav*/
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
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
