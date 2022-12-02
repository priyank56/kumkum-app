import 'dart:async';
import 'package:get_storage/get_storage.dart';
/* global class for handle all the preference activity into application */

class Preference {
  // Preference key
  static const String authorization = "AUTHORIZATION";
  static const String fcmToken = "FCM_TOKEN";
  static const String userData = "USER_DATA";
  static const String userId = "USER_ID";
  static const String userEmail = "USER_EMAIL";
  static const String selectedLanguage = "LANGUAGE";
  static const String selectedCountryCode = "SELECTED_COUNTRY_CODE";
  static const String count = "COUNT";
  static const String isServiceStart = "IS_SERVICE_START";
  static const String isSoundEnable = "IS_SOUND_ENABLE";
  static const String isFirstTimeActivate = "IS_FIRST_TIME_ACTIVATE";
  static const String accessToken = "ACCESS_TOKEN";
  static const String tokenType = "TOKEN_TYPE";
  static const String expiresIn = "EXPIRES_IN";
  static const String loginCurrentTime = "LOGIN_CURRENT_TIME";
  static const String isFirstTime = "IS_FIRST_TIME";
  static const String selectedLanguageIndex = "SELECTED_LANGUAGE_INDEX";
  static const String storageImagesList = "STORAGE_IMAGES_LIST";
  static const String isFirstTimeStoreData = "isFirstTimeStoreData";
  static const String loginType = "LOGIN_TYPE";
  static const String activatedCarousel = "ACTIVATED_CAROUSEL";
  static const String adImage = "AD_IMAGE";
  static const String adLogo = "AD_LOGO";

  // ------------------ SINGLETON -----------------------
  static final Preference _preference = Preference._internal();

  factory Preference() {
    return _preference;
  }

  Preference._internal();

  static Preference get shared => _preference;

  static GetStorage? _pref;

  /* make connection with preference only once in application */
  Future<GetStorage?> instance() async {
    if (_pref != null) return _pref;
    await GetStorage.init().then((value) {
      if (value) {
        _pref = GetStorage();
      }
    }).catchError((onError) {
      _pref = null;
    });
    return _pref;
  }

  String? getString(String key) {
    return _pref!.read(key);
  }

  Future<void> setString(String key, String value) {
    return _pref!.write(key, value);
  }

  int? getInt(String key) {
    return _pref!.read(key);
  }

  Future<void> setInt(String key, int value) {
    return _pref!.write(key, value);
  }

  bool? getBool(String key) {
    return _pref!.read(key);
  }

  Future<void> setBool(String key, bool value) {
    return _pref!.write(key, value);
  }

  // Double get & set
  double? getDouble(String key) {
    return _pref!.read(key);
  }

  Future<void> setDouble(String key, double value) {
    return _pref!.write(key, value);
  }

  // Array get & set
  List<String>? getStringList(String key) {
    return _pref!.read(key);
  }

  Future<void> setStringList(String key, List<String> value) {
    return _pref!.write(key, value);
  }
  /* remove element from preferences */
  Future<void> remove(key, [multi = false]) async {
    GetStorage? pref = await instance();
    if (multi) {
      key.forEach((f) async {
        return await pref!.remove(f);
      });
    } else {
      return await pref!.remove(key);
    }
  }

  /* remove all elements from preferences */
  static Future<bool> clear() async {
    // return await _pref.clear();
    _pref!.getKeys().forEach((key) async {
      await _pref!.remove(key);
    });

    return Future.value(true);
  }

  static Future<bool> clearLogout() async {
    /*_pref!.getKeys().forEach((key) async {
      if (key == accessToken ||
          key == tokenType ||
          key == expiresIn ||
          key == userEmail ||
          key == userData) {
        await _pref!.remove(key);
      }
    });*/
    await _pref!.remove(accessToken);
    await _pref!.remove(tokenType);
    await _pref!.remove(expiresIn);
    await _pref!.remove(userEmail);
    await _pref!.remove(userData);
    return Future.value(true);
  }
}
