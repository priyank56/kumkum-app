import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/connectivitymanager/connectivitymanager.dart';
import 'package:spotify_flutter_code/localization/locale_constant.dart';
import 'package:spotify_flutter_code/routes/app_pages.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/themes/app_theme.dart';
import 'package:spotify_flutter_code/utils/color.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import 'package:spotify_flutter_code/utils/preference.dart';
import 'package:spotify_flutter_code/utils/utils.dart';
import 'localization/localizations_delegate.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preference().instance();
  await InternetConnectivity().instance();

  _configureLocalTimeZone();
  await Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        Debug.printLog(
            "didChangeDependencies Preference Revoked===>>> ${locale.languageCode}");
        Get.updateLocale(locale);
        Debug.printLog(
            " didChangeDependencies GET LOCALE Revoked====>> ${Get.locale!.languageCode}");
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/login_flow/ic_enter_otp.webp"),context);
    precacheImage(const AssetImage("assets/login_flow/ic_forgot_pass.webp"),context);
    precacheImage(const AssetImage("assets/login_flow/ic_login.webp"),context);
    precacheImage(const AssetImage("assets/login_flow/ic_reset_pass.webp"),context);
    precacheImage(const AssetImage("assets/login_flow/ic_sign_up.webp"),context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      color: CColor.white,
      translations: AppLanguages(),
      fallbackLocale: const Locale(Constant.languageEn, Constant.countryCodeEn),
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      locale: Get.deviceLocale,
      getPages: AppPages.list,
      transitionDuration: const Duration(milliseconds: 50),
      // initialRoute:AppRoutes.login ,
      initialRoute: Utils.isLogin() ? AppRoutes.main : AppRoutes.login,
    );
  }
}

