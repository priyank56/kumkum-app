import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rxdart/rxdart.dart';
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
import 'package:open_filex/open_filex.dart';



FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
BehaviorSubject<String?>();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting('gu_IN', null);
  await Preference().instance();
  await InternetConnectivity().instance();

  _configureLocalTimeZone();

  await Future.delayed(const Duration(seconds: 2));

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      Debug.printLog("onDidReceiveNotificationResponse==>>>   ${notificationResponse.payload}");
      OpenFilex.open(notificationResponse.payload);
    },
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

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
  var auth = FirebaseAuth.instance;


  User? getUserData(){
    return auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    if(auth.currentUser != null) {
      getUserData()!.getIdToken().then((value) =>
          Preference.shared.setString(Preference.accessToken, value));
    }
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
    initializeDateFormatting();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kumkum',
      color: CColor.white,
      translations: AppLanguages(),
      fallbackLocale: const Locale(Constant.languageEn, Constant.countryCodeEn),
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      locale: Get.deviceLocale,
      getPages: AppPages.list,
      transitionDuration: const Duration(milliseconds: 50),
      // initialRoute:AppRoutes.preview ,
      initialRoute: Utils.isLogin() ? AppRoutes.main : AppRoutes.login,
    );
  }
}
