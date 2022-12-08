import 'package:spotify_flutter_code/utils/sizer_utils.dart';

import 'debug.dart';

class Constant {
  static const failureCode = false;
  static const successCode = true;
  static const responseFailureCode = 400;
  static const responseSuccessCode = 200;
  static const responseCreatedCode = 201;
  static const responseUnauthorizedCode = 401;
  static const responsePaymentRequired = 402;
  static const responseRequired = 422;
  static const responseInCorrectString = "404";
  static const responseNotFound = 404;

  static const showAdsWallPaperAfterEvery10 = 2;

  // DEVELOPING URL
  static const developingURL = "https://devapi.patchipatchi.com/";

  // LIVE URL
  static const mainURL = "https://api.patchipatchi.com/";

  static const languageEn = "en";
  static const countryCodeEn = "US";
  static const languageCh = "zh";
  static const countryCodeCh = "CN";

  static const initialCountryCodeHongKong = "+852";

  static const datNotFound = "Data not found";
  static const verifyYouEmail = "Please, verify your email";

  static const exceptionPhotoAccessDenied = "photo_access_denied";

  static const wallPaperNormal = "wallPaperNormal";
  static const wallPaperGiftWithAd = "wallPaperGiftWithAd";
  static const wallPaperWithAd = "wallPaperWithAd";

  static const loginTypeGoogle = "google";
  static const loginTypeApple = "apple";
  static const loginTypeNormal = "normal";

  static const strRobotoFamily = "Roboto";
  static const strGothamProFamily = "GothamPro";
  static const strMarydaleProFamily = "Marydale";

  static const screenCreateQrCode = "screenCreateQrCode";
  static const screenExclusive = "screenExclusive";
  static const screenMyAccount = "screenMyAccount";
  static const screenPhotoLibrary = "screenPhotoLibrary";
  static const screenPattenGallery = "screenPattenGallery";
  static const screenFavourite = "screenFavourite";
  static const screeScanCamera = "screeScanCamera";

  static const catPatternGallery = "PATTERN GALLERY FROM COLLECTION STOCK";
  static const catBrandedLockScreen = "BRANDED LOCKSCREEN";
  static const catBrandedLockScreenWithGift = "BRANDED LOCKSCREEN WITH GIFT";
  static const catExclusiveLockscreen = "EXCLUSIVE LOCKSCREEN";

  static const healthFirstName = "healthFirstName";
  static const healthLastName = "healthLastName";
  static const healthIdCardNo = "healthIdCardNo";
  static const healthDateOfBirth = "healthDateOfBirth";
  static const healthImpMedicalNotes = "healthImpMedicalNotes";
  static const healthAllergies = "healthAllergies";
  static const healthEmergencyName = "healthEmergencyName";
  static const healthEmergencyContact = "healthEmergencyContact";
  static const healthInsuranceCompany = "healthInsuranceCompany";
  static const healthInsuranceNumber = "healthInsuranceNumber";
  static const healthStrDropDownBlood = "healthStrDropDownBlood";
  static const healthStrDropDownOrgan = "healthStrDropDownOrgan";
  static const healthStrDropDownWeight = "healthStrDropDownWeight";
  static const healthStrDropDownHeight = "healthStrDropDownHeight";

  static const refreshQrCodeLogo = "refreshQrCodeLogo";
  static const refreshHideDropDownBtn = "refreshHideDropDownBtn";

  static const strAboutSlugs = "about";
  static const strAdvertisingSlugs = "advertising";
  static const strBoardingSlugs = "boarding";
  static const mediaUrl = "https://devapi.patchipatchi.com/media/";

  static const campaignFileTypeImage = "image";
  static const campaignFileTypeGiftQrLogo = "gift_qr_logo";
  static const campaignFileTypeLogo = "logo";
  static const appFont = "Popins";
  static const selectedSendWp1Person = "1person";
  static const selectedSendWpSarvo = "sarvo";
  static const selectedSendWpSajode = "sajode";

  static getMainURL() {
    if (Debug.sandboxApiUrl) {
      return developingURL;
    } else {
      return mainURL;
    }
  }

  /*Ids*/
  static const idMainPage = "idMainPage";
  static const idBottomViewPos = "idBottomViewPos";
  static const idBottomText = "idBottomText";
  static const idNextPrevious = "idNextPrevious";
  static const idPassWord = "idPassWord";
  static const idEmailEdit = "idEmailEdit";
  static const idFullNameEdit = "idFullNameEdit";
  static const idAllButton = "idAllButton";
  static const idAddNimantrakPart = "idAddNimantrakPart";
  static const idFunctionsPart = "idFunctionsPart";
  static const idInviterPart = "idInviterPart";
  static const idGuestNameFirst = "idGuestNameFirst";
}
