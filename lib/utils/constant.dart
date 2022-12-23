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
  static const developingURL = "http://ec2-54-173-19-21.compute-1.amazonaws.com:3000";

  // LIVE URL
  static const mainURL = "http://ec2-54-173-19-21.compute-1.amazonaws.com:3000";

  static const languageEn = "en";
  static const countryCodeEn = "US";
  static const languageCh = "zh";
  static const countryCodeCh = "CN";



  static const appFont = "Popins";
  static const selectedSendWp1Person = "1person";
  static const selectedSendWpSarvo = "sarvo";
  static const selectedSendWpSajode = "sajode";
  static const godDemoImageURl = "https://images.unsplash.com/photo-1567878673942-be055fed5d30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80";
  static const dummyPreviewURL = "https://kumkum-blond.vercel.app/invitation-card/654216a3";

  static getMainURL() {
    if (Debug.sandboxApiUrl) {
      return developingURL;
    } else {
      return mainURL;
    }
  }

  /*Screens Names*/
  static const isFromHomeScreen = "isFromHomeScreen";
  static const isFromCategoryScreen = "isFromCategoryScreen";
  static const isFromMyCardsScreen = "isFromMyCardsScreen";

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

  static const isFromUpdate = "isFromUpdate";
  static const isFromCreate = "isFromCreate";

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
  static const idGetAllPreBuiltCards = "idGetAllPreBuiltCards";
  static const idGroomPaksh = "idGroomPaksh";
  static const idBridePaksh = "idBridePaksh";
  static const idContactList = "idContactList";


  static const bufferData = "";
}
