import 'package:get/get.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'languages/language_en.dart';
import 'languages/language_zh.dart';

class AppLanguages extends Translations {
  /*static Map<String, Map<String, String>> languagesKeys = {
    "en_US": enUS,
    "zh": zh,
  };*/

  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": enUS,
        "zh_CN": zh,
      };
}

final List<LanguageModel> languages = [
  LanguageModel("English", Constant.languageEn),
  LanguageModel("Chinese", Constant.languageCh),
];

class LanguageModel {
  LanguageModel(
    this.language,
    this.symbol,
  );

  String language;
  String symbol;
}
