import 'dart:ui';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import 'package:spotify_flutter_code/utils/preference.dart';

setLocale(String languageCode, String countryCode) async {
  Preference.shared.setString(Preference.selectedLanguage, languageCode);
  Preference.shared.setString(Preference.selectedCountryCode, countryCode);
  Debug.printLog(
      "setLocale Updated ${Preference.shared.getString(Preference.selectedLanguage)} "
      "  ${Preference.shared.getString(Preference.selectedCountryCode)}");
}

Future<Locale> getLocale() async {
  String languageCode =
      Preference.shared.getString(Preference.selectedLanguage) ??
          Constant.languageEn;
  String countryCode =
      Preference.shared.getString(Preference.selectedCountryCode) ??
          Constant.countryCodeEn;
  Debug.printLog("getLocale Updated $languageCode   $countryCode");
  return _locale(languageCode, countryCode);
}

Locale _locale(String languageCode, String countryCode) {
  return languageCode.isNotEmpty
      ? Locale(languageCode, countryCode)
      : const Locale(Constant.languageEn, Constant.countryCodeEn);
}
