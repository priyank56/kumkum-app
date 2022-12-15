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
  static const developingURL = "https://acv-wb-api.azurewebsites.net";

  // LIVE URL
  static const mainURL = "https://acv-wb-api.azurewebsites.net";

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
  static const godDemoImageURl = "https://images.unsplash.com/photo-1567878673942-be055fed5d30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80";

  static getMainURL() {
    if (Debug.sandboxApiUrl) {
      return developingURL;
    } else {
      return mainURL;
    }
  }


  /*Types Of EditText*/

  /*Nimantrak*/
  static const typeNimantrakName = "typeNimantrakName";
  static const typeNimantrakSarnamu = "typeNimantrakSarnamu";
  static const typeNimantrakMobile = "typeNimantrakMobile";

  /*Functions*/
  static const typeFunctionMandapMuhrat = "typeFunctionMandapMuhrat";
  static const typeFunctionBhojan = "typeFunctionBhojan";
  static const typeFunctionGitSandhya = "typeFunctionGitSandhya";
  static const typeFunctionRasGarba = "typeFunctionRasGarba";
  static const typeFunctionJanPrsathan = "typeFunctionJanPrsathan";
  static const typeFunctionHastMelap = "typeFunctionHastMelap";

  static const typeFunctionDate = "typeFunctionDate";
  static const typeFunctionTime = "typeFunctionTime";
  static const typeFunctionPlace = "typeFunctionPlace";
  static const typeFunctionMessage = "typeFunctionMessage";

  static const typeTahuko = "typeTahuko";

  static const typeGoodPlaceAddress = "typeGoodPlaceAddress";
  static const typeGoodPlaceMno = "typeGoodPlaceMno";

  static const typeGroom = "typeGroom";
  static const typeBride = "typeBride";

  /*All Names*/
  static const typeAllNamesAapneAavkarvaAAatur   = "typeAllNamesAapneAavkarvaAAatur";
  static const typeAllNamesSanehaDhin = "typeAllNamesSanehaDhin";
  static const typeAllNamesMosalPaksh = "typeAllNamesMosalPaksh";
  static const typeAllNamesBhanejPaksh = "typeAllNamesBhanejPaksh";

  static const typeCamera = "typeCamera";
  static const typeGallery = "typeGallery";

  static const typeGroomAPI = "groom";
  static const typeBrideAPI = "bride";

  /*Ids*/
  static const isShowProgressUpload = "isShowProgressUpload";
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
  static const idTahukoPart = "idTahukoPart";
  static const idGuestNameAll = "idGuestNameAll";
  static const idGoodPlaceAll = "idGoodPlaceAll";
  static const idGodNames = "idGodNames";
  static const idMrgDate = "idMrgDate";
  static const idSetMainImage = "idSetMainImage";
  static const idGetAllYourCards = "idGetAllYourCards";
  static const idGroomPaksh = "idGroomPaksh";
  static const idBridePaksh = "idBridePaksh";


}
