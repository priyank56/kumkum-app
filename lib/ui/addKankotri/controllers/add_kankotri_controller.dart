import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/getInfoData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/newkankotridatamodel.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/uploadImageData.dart';
import 'package:spotify_flutter_code/utils/debug.dart';

import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../datamodel/createKankotriData.dart';
import '../datamodel/newKankotriData.dart';
import '../../addKankotri/datamodel/newKankotriData.dart';
import '../../addKankotri/datamodel/newkankotridatamodel.dart';

class AddKankotriController extends GetxController {

  var arguments = Get.arguments;
  bool isGroomCard = true;
  String isFromAddUpdate = "";
  User userData = FirebaseAuth.instance.currentUser!;
  bool isShowProgress = false;
  NewKankotriDataModel newKankotriDataModel = NewKankotriDataModel();
  File? imgFile;
  String? imgCoverURL = "";

  List<ChirpingInfo> listOfAllChirping = [];
  List<String> listOfAllStringChirping = [];

  List<GodDetailInfo> listOfAllGods = [];


  List<InvitationMessage> listOfInvitersMessage = [];
  List<InvitationMessage> listOfInvitersGroomMessage = [];
  List<InvitationMessage> listOfInvitersBrideMessage = [];
  InvitationMessage chirpingInfoGroom = InvitationMessage();
  InvitationMessage chirpingInfoBride = InvitationMessage();

  List<String> listOfMessagesFromBride = [];
  List<String> listOfMessagesFromGroom = [];

  CreateData createData = CreateData();
  ResultGet getAllInvitationCard = ResultGet();

  List<String> listNimantrakName = [];
  List<String> listNimantrakAddress = [];
  List<String> listNimantrakMno = [];
  List<TextEditingController> nimantrakNameController = [];
  List<TextEditingController> nimantrakMnoController = [];
  List<TextEditingController> nimantrakAddressController = [];


  List<String> listOfGuestNameFirst = [];

  List<FunctionsNimantrakName> functionsList = [];
  List<TextEditingController> functionsPlaceListController = [];
  List<TextEditingController> functionsMessageListController = [];
  List<TextEditingController> functionsNimantrakNameListController = [];

  List<TextEditingController> listOfGuestNameController = [];

  List<GuestAllName> guestNamesList = [];

  List<String> listOfTahukoChildName = [];
  List<TextEditingController> tahukoChildController = [];

  List<GoodPlaceAllName> goodPlaceNamesList = [];

  TextEditingController functionDate = TextEditingController();
  TextEditingController functionTime = TextEditingController();
  TextEditingController functionPlace = TextEditingController();
  TextEditingController functionMessage = TextEditingController();
  List<TextEditingController> inviterList = [];

  String mrgDate = "";
  String mrgDateGujarati = "";
  String mrgDateDay = "";
  String newGodName = "";

  
  /*varPaksh*/
  TextEditingController varRajaNuNameController = TextEditingController();
  TextEditingController groomNameController = TextEditingController();  
  
  /*kanyaPaksh*/
  TextEditingController kanyaNuNameController = TextEditingController();
  TextEditingController brideNameController = TextEditingController();

  /*marriage date*/
  TextEditingController marriageDateController = TextEditingController();

  /*_amantrakPart*/
  /*Groom*/
  TextEditingController groomGodNameController = TextEditingController();
  TextEditingController groomMotherNameController = TextEditingController();
  TextEditingController groomFatherNameController = TextEditingController();
  TextEditingController groomVillageNameController = TextEditingController();
  String dropDownFromGroomMessage = "";


  /*Bride*/
  TextEditingController brideMotherNameController = TextEditingController();
  TextEditingController brideFatherNameController = TextEditingController();
  TextEditingController brideVillageNameController = TextEditingController();
  TextEditingController brideGodController = TextEditingController();
  String dropDownFromBrideMessage = "";

  /*Drop Down Messages*/
  String dropDownTahukoMessage = "";

  /*Atak*/
  TextEditingController atakController = TextEditingController();

  /*Edittext Controller*/
  TextEditingController godNameController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    if(arguments[0] != null){
      isGroomCard = arguments[0];
      Debug.printLog("Card arguments 0==>> $isGroomCard");
    }
    getAllInfo(Get.context!);

    if(arguments[1] != null){
      getAllInvitationCard = arguments[1];
      // setAllData();
    }else {
      addNimantrakNameListData(true);
      addNimantrakAddressListData(true);
      addNimantrakMnoListData(true);
      addAllFunctionsList();
      addAllGuestNames();
      addRemoveTahukoChildName(true);
      addGoodPlaceNames();
    }

    if(arguments[2] != null){
      isFromAddUpdate = arguments[2];
      Debug.printLog("Card arguments 2==>> $isFromAddUpdate");

    }
  }

  Future<String?> getUserTokeId()async{
    var token = "";
    await FirebaseAuth.instance.currentUser!.getIdToken().then((value) => (){ token = value;});
    return token;
  }

  Future<void> selectDate(BuildContext context,{int index = -1}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      String convertedDateTime =
          "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      if(index != -1){
        var date = DateFormat("yyyy-MM-dd","gu").format(picked);
        functionsList[functionsList.indexOf(functionsList[index])].functionDate = date.toString();
      }else{
        mrgDate = convertedDateTime.toString();
        mrgDateGujarati = DateFormat("yyyy-MM-dd EEEE","gu_IN").format(picked);
        mrgDateDay = DateFormat("EEEE","gu_IN").format(picked);
      }
      Debug.printLog("convertedDateTime==>> $mrgDateDay $mrgDateGujarati ");

      update([Constant.idMrgDate,Constant.idFunctionsPart,Constant.idInviterPart]);

    }

  }

  Future<void> selectTime(BuildContext context,int index) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked != null){
      var time = "${picked.hour}:${picked.minute}";
      functionsList[functionsList.indexOf(functionsList[index])].functionTime = time.toString();
      var date = DateFormat('hh:mm', 'gu').format(DateTime.now());
    }
    update([Constant.idFunctionsPart]);
  }

  addNimantrakNameListData(bool isAdd, {int? index = 0}) {
    if (isAdd) {
      listNimantrakName.add("");
      nimantrakNameController.add(TextEditingController());
    } else {
      nimantrakNameController.removeAt(index!);
      listNimantrakName.removeAt(index);
    }
    update([Constant.idAddNimantrakPart]);
  }

  addNimantrakAddressListData(bool isAdd, {int? index = 0}) {
    if (isAdd) {
      listNimantrakAddress.add("");
      nimantrakAddressController.add(TextEditingController());
    } else {
      nimantrakAddressController.removeAt(index!);
      listNimantrakAddress.removeAt(index);
    }
    update([Constant.idAddNimantrakPart]);
  }

  addNimantrakMnoListData(bool isAdd, {int? index = 0}) {
    if (isAdd) {
      listNimantrakMno.add("");
      nimantrakMnoController.add(TextEditingController());
    } else {
      nimantrakMnoController.removeAt(index!);
      listNimantrakMno.removeAt(index);
    }
    update([Constant.idAddNimantrakPart]);
  }

  addRemoveFunctionsNimantrakName(bool isAdd,int mainIndex,{int? index = 0}){
    if (isAdd) {
      functionsList[mainIndex].listEditTextNames.add(TextEditingController());
      functionsList[mainIndex].listNames.add("");
    } else {
      functionsList[mainIndex].listEditTextNames.removeAt(index!);
      functionsList[mainIndex].listNames.removeAt(index);
    }
    update([Constant.idFunctionsPart]);
  }

  addAllFunctionsList() {
    functionsList.add(FunctionsNimantrakName("f1","txtMadapMuhrat".tr,[""],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    functionsList.add(FunctionsNimantrakName("f2","txtGitSandhya".tr,[""],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    functionsList.add(FunctionsNimantrakName("f3","txtRasGarba".tr,[""],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    functionsList.add(FunctionsNimantrakName("f4",(isGroomCard)?"txtJan".tr:"txtJanAagman".tr,[""],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    functionsList.add(FunctionsNimantrakName("f5","txtBhojan".tr,[""],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    functionsList.add(FunctionsNimantrakName("f6","txtHastMelap".tr,[""],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    update([Constant.idFunctionsPart]);
  }


  addAllGuestNames() {
    guestNamesList.add(GuestAllName("txtAapneAavkarvaAatur".tr,[""],[TextEditingController()]));
    guestNamesList.add(GuestAllName("txtSanehaDhin".tr,[""],[TextEditingController()]));
    guestNamesList.add(GuestAllName("txtMosalPaksh".tr,[""],[TextEditingController()]));
    guestNamesList.add(GuestAllName("txtBhanejPaksh".tr,[""],[TextEditingController()]));
    update([Constant.idGuestNameAll]);
  }

  addRemoveTahukoChildName(bool isAdd,{int? index = 0}){
    if (isAdd) {
      tahukoChildController.add(TextEditingController());
      listOfTahukoChildName.add("");
    } else {
      tahukoChildController.removeAt(index!);
      listOfTahukoChildName.removeAt(index);
    }
    update([Constant.idTahukoPart]);
  }

  changeValueInListForTahukoChildName(int index,String value) {
    // tahukoChildController.add(TextEditingController(text: value));
    // listOfTahukoChildName[index] = value;



    listOfTahukoChildName[listOfTahukoChildName.indexOf(listOfTahukoChildName[index])] = value;
    if(listOfTahukoChildName.length > tahukoChildController.length) {
      tahukoChildController.add(TextEditingController(text: value));
    }
    tahukoChildController[index].text = value;
    tahukoChildController[index].selection = TextSelection.fromPosition(TextPosition(offset: value.length));

    update([Constant.idTahukoPart]);
  }

  addRemoveGuestNamesName(bool isAdd,int mainIndex,{int? index = 0}){
    if (isAdd) {
      guestNamesList[mainIndex].listOfGuestNamesController!.add(TextEditingController());
      guestNamesList[mainIndex].listOfGuestNames.add("");
    } else {
      guestNamesList[mainIndex].listOfGuestNamesController!.removeAt(index!);
      guestNamesList[mainIndex].listOfGuestNames.removeAt(index);
    }
    update([Constant.idGuestNameAll]);
  }


  addGoodPlaceNames() {
    goodPlaceNamesList.add(GoodPlaceAllName("txtSubhSathal".tr,[""],[""],"",[TextEditingController()],[TextEditingController()],TextEditingController()));
    goodPlaceNamesList.add(GoodPlaceAllName("txtSubhLaganSathal".tr,[""],[""],"",[TextEditingController()],[TextEditingController()],TextEditingController()));
    update([Constant.idGoodPlaceAll]);
  }

  addRemoveGoodPlaceNamesName(bool isAdd,int mainIndex,bool isAddress,{int? index = 0}){
    if(isAddress) {
      if (isAdd) {
        goodPlaceNamesList[mainIndex].listEditTextAddress.add(TextEditingController());
        goodPlaceNamesList[mainIndex].listOfAddressName.add("");
      } else {
        goodPlaceNamesList[mainIndex].listEditTextAddress.removeAt(index!);
        goodPlaceNamesList[mainIndex].listOfAddressName.removeAt(index);
      }
    }else {
      if (isAdd) {
        goodPlaceNamesList[mainIndex].listEditTextMobile.add(TextEditingController());
        goodPlaceNamesList[mainIndex].listOfMobile.add("");
      } else {
        goodPlaceNamesList[mainIndex].listEditTextMobile.removeAt(index!);
        goodPlaceNamesList[mainIndex].listOfMobile.removeAt(index);
      }
    }
    update([Constant.idGoodPlaceAll]);
  }


  addRemoveGodNamesName(bool isAdd, int index,String name){
    if(name == ""){
      return;
    }
    if (isAdd) {
      var god = GodDetailInfo();
      god.name = name;
      god.image = "";
      god.isSelected = false;
      god.id = "";
      listOfAllGods.add(god);
    } else {
      listOfAllGods.removeAt(index);
    }
    update([Constant.idGodNames]);
  }

  godSelectOnTap(int index){
    listOfAllGods[index].isSelected = !listOfAllGods[index].isSelected!;
    update([Constant.idGodNames]);
  }

   changeGodName(String name){
     newGodName = name;
     update([Constant.idGodNames]);
   }

   /* Replace Value In List */


  changeValueInListForNimantrak(int index,String type,String value) {
    if(type == Constant.typeNimantrakName){
      listNimantrakName[listNimantrakName.indexOf(listNimantrakName[index])] = value;
      if(listNimantrakName.length > nimantrakNameController.length) {
        nimantrakNameController.add(TextEditingController(text: value));
      }
      nimantrakNameController[index].text = value;
      nimantrakNameController[index].selection = TextSelection.fromPosition(TextPosition(offset: value.length));
    }else if(type == Constant.typeNimantrakSarnamu){
      listNimantrakAddress[listNimantrakAddress.indexOf(listNimantrakAddress[index])] = value;
      if(listNimantrakAddress.length > nimantrakAddressController.length) {
        nimantrakAddressController.add(TextEditingController(text: value));
      }
      nimantrakAddressController[index].text = value;
      nimantrakAddressController[index].selection = TextSelection.fromPosition(TextPosition(offset: value.length));
    }else if(type == Constant.typeNimantrakMobile){
      listNimantrakMno[listNimantrakMno.indexOf(listNimantrakMno[index])] = value;
      if(listNimantrakMno.length > nimantrakMnoController.length) {
        nimantrakMnoController.add(TextEditingController(text: value));
      }
      nimantrakMnoController[index].text = value;
      nimantrakMnoController[index].selection = TextSelection.fromPosition(TextPosition(offset: value.length));
    }
    update([Constant.idAddNimantrakPart]);
  }

  changeValueInListForFunctions(int index,String type,String value) {
    if(type == Constant.typeFunctionDate){
      functionsList[index].functionDate = value;
    }else if(type == Constant.typeFunctionTime){
      functionsList[index].functionTime = value;
    }else if(type == Constant.typeFunctionPlace){
      functionsList[index].functionPlace = value;
    }else if(type == Constant.typeFunctionMessage){
      functionsList[index].functionMessage = value;
    }
    update([Constant.idFunctionsPart]);
  }

  changeValueInListForFunctionsNimantrakName(int index,int mainIndex,String value) {
    functionsList[mainIndex].listEditTextNames.add(TextEditingController());
    functionsList[mainIndex].listNames[functionsList[mainIndex].listNames.indexOf(functionsList[mainIndex].listNames[index])] = value;
    update([Constant.idFunctionsPart]);
  }

  changeValueInListForGuestAllNames(int index,int mainIndex,String value) {
    Debug.printLog("changeValueInListForGuestAllNames==>>  $value");
    /*guestNamesList[mainIndex].listOfGuestNames[guestNamesList[mainIndex]
        .listOfGuestNames.indexOf(
        guestNamesList[mainIndex].listOfGuestNames[index])] = value;
*/

    guestNamesList[mainIndex].listOfGuestNames[index] = value;
    if(guestNamesList[mainIndex].listOfGuestNames.length > guestNamesList[mainIndex].listOfGuestNamesController!.length) {
      guestNamesList[mainIndex].listOfGuestNamesController!.add(TextEditingController(text: value));
    }
    guestNamesList[mainIndex].listOfGuestNamesController![index].text = value;
    guestNamesList[mainIndex].listOfGuestNamesController![index].selection = TextSelection.fromPosition(TextPosition(offset: value.length));

    update([Constant.idGuestNameAll]);
  }

  changeValueInListForGoodPlaceAmantrakName(int mainIndex,String value) {
    goodPlaceNamesList[mainIndex].inviterName = value;
    update([Constant.idGoodPlaceAll]);
  }

  changeDropDownValueForGroomBride(String value,String type){

    if(type == Constant.typeGroom){
      var selectedGroomList = listOfInvitersGroomMessage.where((element) => element.previewText == value).toList();
      chirpingInfoGroom = selectedGroomList[0];

      dropDownFromGroomMessage = value;
    }else{
      var selectedBrideList = listOfInvitersBrideMessage.where((element) => element.previewText == value).toList();
      chirpingInfoBride = selectedBrideList[0];

      dropDownFromBrideMessage = value;
    }
    Debug.printLog("changeDropDownValueForGroomBride==>> $value  $type");
    update([Constant.idInviterPart]);
  }

  changeDropDownValueForTahuko(String value){
    dropDownTahukoMessage = value;
    Debug.printLog("changeDropDownValueForTahuko===>> $value");
    update([Constant.idTahukoPart]);
  }

  changeValueInListForGoodPlace(int index,int mainIndex,String type,String value) {
    if(type == Constant.typeGoodPlaceAddress) {
      goodPlaceNamesList[mainIndex].listOfAddressName[goodPlaceNamesList[mainIndex]
          .listOfAddressName.indexOf(
          goodPlaceNamesList[mainIndex].listOfAddressName[index])] = value;
    }else if(type == Constant.typeGoodPlaceMno) {
      goodPlaceNamesList[mainIndex].listOfMobile[goodPlaceNamesList[mainIndex]
          .listOfMobile.indexOf(
          goodPlaceNamesList[mainIndex].listOfMobile[index])] = value;
    }
    update([Constant.idGoodPlaceAll]);
  }

  bool validation(BuildContext context){

    /*Cover Image Detail*/
    if(imgCoverURL == ""){
      Utils.showToast(context, "txtUploadImage".tr);
      return false;
    }

    /*Groom Detail*/
    if(varRajaNuNameController.text.isEmpty || groomNameController.text.isEmpty){
      Utils.showToast(context, "txtEnterGroomName".tr);
      return false;
    }

    /*Bride Detail*/
    if(kanyaNuNameController.text.isEmpty || brideNameController.text.isEmpty){
      Utils.showToast(context, "txtEnterBrideName".tr);
      return false;
    }

    /*Mrg Date Detail*/
    if(mrgDate == ""){
      Utils.showToast(context, "txtMrgDate".tr);
      return false;
    }

    /*Inviter Detail*/
    var n1 = listNimantrakName.where((element) => element != "").toList();
    // if(n1.isEmpty){
    if(n1.length != listNimantrakName.length){
      Utils.showToast(context, "txtInviterName".tr);
      return false;
    }

    var n2 = listNimantrakAddress.where((element) => element != "").toList();
    // if(n2.isEmpty){
    if(n2.length != listNimantrakAddress.length){
      Utils.showToast(context, "txtInviterAddress".tr);
      return false;
    }

    var n3 = listNimantrakMno.where((element) => element != "").toList();
    // if(n3.isEmpty){
    if(n3.length != listNimantrakMno.length){
      Utils.showToast(context, "txtInviterMobile".tr);
      return false;
    }



    /*All Functions name*/
    var functionsListF1 = functionsList.where((element) => element.functionId == "f1").toList();
    if(functionsListF1.isNotEmpty) {
      if (functionsListF1[0].functionTime != "" ||
          functionsListF1[0].functionDate != "") {
        if (functionsListF1[0].functionDate == "" ||
            functionsListF1[0].functionTime == "") {
          if (functionsListF1[0].functionDate == "") {
            Utils.showToast(context, "txtFunMandapMuhratDate".tr);
          } else if (functionsListF1[0].functionTime == "") {
            Utils.showToast(context, "txtFunMandapMuhratTime".tr);
          }
          return false;
        }
      }
    }

    var functionsListF2 = functionsList.where((element) => element.functionId == "f2").toList();
    /*if(functionsListF2[0].functionDate == "" || functionsListF2[0].functionTime == "" || functionsListF2[0].functionMessage == "" || functionsListF2[0].listNames.isEmpty){
      Utils.showToast(context, "txtFunBhojan".tr);
      return false;
    }*/
    if(functionsListF2.isNotEmpty) {
      if (functionsListF2[0].functionTime != "" ||
          functionsListF2[0].functionDate != "") {
        if (functionsListF2[0].functionDate == "" ||
            functionsListF2[0].functionTime == "") {
          if (functionsListF2[0].functionDate == "") {
            Utils.showToast(context, "txtFunGitSandhyaDate".tr);
          } else if (functionsListF2[0].functionTime == "") {
            Utils.showToast(context, "txtFunGitSandhyaTime".tr);
          }
          return false;
        }
      }
    }

    var functionsListF3 = functionsList.where((element) => element.functionId == "f3").toList();
    /*if(functionsListF3[0].functionDate == "" || functionsListF3[0].functionTime == "" || functionsListF3[0].functionMessage == "" || functionsListF3[0].listNames.isEmpty){
      Utils.showToast(context, "txtFunGitSandhya".tr);
      return false;
    }*/
    if(functionsListF3.isNotEmpty) {
      if (functionsListF3[0].functionTime != "" ||
          functionsListF3[0].functionDate != "") {
        if (functionsListF3[0].functionDate == "" ||
            functionsListF3[0].functionTime == "") {
          if (functionsListF3[0].functionDate == "") {
            Utils.showToast(context, "txtFunRasGarbaDate".tr);
          } else if (functionsListF3[0].functionTime == "") {
            Utils.showToast(context, "txtFunRasGarbaTime".tr);
          }
          return false;
        }
      }
    }

    var functionsListF4 = functionsList.where((element) => element.functionId == "f4").toList();
    /*if(functionsListF4[0].functionDate == "" || functionsListF4[0].functionTime == "" || functionsListF4[0].functionMessage == "" || functionsListF4[0].listNames.isEmpty){
      Utils.showToast(context, "txtFunRasGarba".tr);
      return false;
    }*/
    if(functionsListF4.isNotEmpty) {
      if (functionsListF4[0].functionTime != "" ||
          functionsListF4[0].functionDate != "") {
        if (functionsListF4[0].functionDate == "" ||
            functionsListF4[0].functionTime == "") {
          if (functionsListF4[0].functionDate == "") {
            Utils.showToast(context, "txtFunJanPrsathanDate".tr);
          } else if (functionsListF4[0].functionTime == "") {
            Utils.showToast(context, "txtFunJanPrsathanTime".tr);
          }
          return false;
        }
      }
    }


    var functionsListF5 = functionsList.where((element) => element.functionId == "f5").toList();
    /*if(functionsListF5[0].functionDate == "" || functionsListF5[0].functionTime == "" || functionsListF5[0].functionMessage == "" || functionsListF5[0].listNames.isEmpty){
      Utils.showToast(context, "txtFunJanPrsathan".tr);
      return false;
    }*/
    if(functionsListF5.isNotEmpty) {
      if (functionsListF5[0].functionTime != "" ||
          functionsListF5[0].functionDate != "") {
        if (functionsListF5[0].functionDate == "" ||
            functionsListF5[0].functionTime == "") {
          if (functionsListF5[0].functionDate == "") {
            Utils.showToast(context, "txtFunBhojanDate".tr);
          } else if (functionsListF5[0].functionTime == "") {
            Utils.showToast(context, "txtFunBhojanTime".tr);
          }
          return false;
        }
      }
    }

    var functionsListF6 = functionsList.where((element) => element.functionId == "f6").toList();
    /*if(functionsListF6[0].functionDate == "" || functionsListF6[0].functionTime == "" || functionsListF6[0].functionMessage == "" || functionsListF6[0].listNames.isEmpty){
      Utils.showToast(context, "txtFunHastMelap".tr);
      return false;
    }*/
    if(functionsListF6.isNotEmpty) {
      if (functionsListF6[0].functionTime != "" ||
          functionsListF6[0].functionDate != "") {
        if (functionsListF6[0].functionDate == "" ||
            functionsListF6[0].functionTime == "") {
          if (functionsListF6[0].functionDate == "") {
            Utils.showToast(context, "txtFunHastMelapDate".tr);
          } else if (functionsListF6[0].functionTime == "") {
            Utils.showToast(context, "txtFunHastMelapTime".tr);
          }
          return false;
        }
      }
    }


    /*Inviter Detail For Both*/
    /*1.Groom*/
    if(groomGodNameController.text.isEmpty && listOfInvitersGroomMessage.isNotEmpty &&
        chirpingInfoBride.values!.godName != null){
      Utils.showToast(context, "txtGroomGod".tr);
      return false;
    }
    if(groomMotherNameController.text.isEmpty){
      Utils.showToast(context, "txtGroomMother".tr);
      return false;
    }
    if(groomFatherNameController.text.isEmpty){
      Utils.showToast(context, "txtGroomFather".tr);
      return false;
    }
    if(groomVillageNameController.text.isEmpty){
      Utils.showToast(context, "txtGroomVillage".tr);
      return false;
    }

    /*2.Bride*/
    if(brideMotherNameController.text.isEmpty){
      Utils.showToast(context, "txtBrideMother".tr);
      return false;
    }
    if(brideFatherNameController.text.isEmpty){
      Utils.showToast(context, "txtBrideFather".tr);
      return false;
    }
    if(brideVillageNameController.text.isEmpty){
      Utils.showToast(context, "txtBrideVillage".tr);
      return false;
    }
    if (brideGodController.text.isEmpty &&
        listOfInvitersBrideMessage.isNotEmpty &&
        chirpingInfoBride.values!.godName != null) {
      Utils.showToast(context, "txtBrideGod".tr);
      return false;
    }
    if(mrgDate == ""){
      Utils.showToast(context, "txtMrgDate".tr);
      return false;
    }


    /*Guest All Names Detail*/
    var g1 = guestNamesList.where((element) => element.titleName == "txtAapneAavkarvaAatur".tr).toList();
    var g11 = g1[0].listOfGuestNames.where((element) => element != "").toList();
    // if(g1[0].listOfGuestNames.where((element) => element != "").toList().isEmpty){
    if(g1[0].listOfGuestNames.length != g11.length){
      Utils.showToast(context, "txtAavkarvaAatur".tr);
      return false;
    }
    var g2 = guestNamesList.where((element) => element.titleName == "txtSanehaDhin".tr).toList();
    var g22 = g2[0].listOfGuestNames.where((element) => element != "").toList();
    // if(g2[0].listOfGuestNames.where((element) => element != "").toList().isEmpty){
    if(g2[0].listOfGuestNames.length != g22.length){
      Utils.showToast(context, "txtSaneha".tr);
      return false;
    }
    var g3 = guestNamesList.where((element) => element.titleName == "txtMosalPaksh".tr).toList();
    var g33 = g3[0].listOfGuestNames.where((element) => element != "").toList();
    // if(g3[0].listOfGuestNames.where((element) => element != "").toList().isEmpty){
    if(g3[0].listOfGuestNames.length != g33.length){
      Utils.showToast(context, "txtMosal".tr);
      return false;
    }
    var g4 = guestNamesList.where((element) => element.titleName == "txtBhanejPaksh".tr).toList();
    var g44 = g4[0].listOfGuestNames.where((element) => element != "").toList();
    // if(g4[0].listOfGuestNames.where((element) => element != "").toList().isEmpty){
    if(g4[0].listOfGuestNames.length != g44.length){
      Utils.showToast(context, "txtBhanej".tr);
      return false;
    }


    /*Tahuko Names Detail*/
    /*if(listOfTahukoChildName.where((element) => element != "").toList().isEmpty){
      Utils.showToast(context, "txtTahukoChildNames".tr);
      return false;
    }*/

    var tahukoChild = listOfTahukoChildName.where((element) => element != "").toList();
    if(tahukoChild.length != listOfTahukoChildName.length){
      Utils.showToast(context, "txtTahukoChildNames".tr);
      return false;
    }

    /*Good Places Mrg Detail*/
    /*1.Good Place*/
    var good1 = goodPlaceNamesList.where((element) => element.titleName == "txtSubhSathal".tr).toList();
    if(good1[0].inviterName == ""){
      Utils.showToast(context, "txtInviterName".tr);
      return false;
    }

    var good1Address = good1[0].listOfAddressName.where((element) => element != "").toList();
    if(good1[0].listOfAddressName.length != good1Address.length){
      Utils.showToast(context, "txtInviterAddress".tr);
      return false;
    }

    /*if(good1[0].listOfAddressName.where((element) => element != "").toList().isEmpty){
      Utils.showToast(context, "txtInviterAddress".tr);
      return false;
    }*/
    var good1Mno = good1[0].listOfMobile.where((element) => element != "").toList();
    if(good1[0].listOfMobile.length != good1Mno.length){
      Utils.showToast(context, "txtInviterMobile".tr);
      return false;
    }

    /*if(good1[0].listOfMobile.where((element) => element != "").toList().isEmpty){
      Utils.showToast(context, "txtInviterMobile".tr);
      return false;
    }*/
    /*2.Good Place Mrg*/
    var good2 = goodPlaceNamesList.where((element) => element.titleName == "txtSubhLaganSathal".tr).toList();
    if(good2[0].inviterName == ""){
      Utils.showToast(context, "txtInviterName".tr);
      return false;
    }
   /* if(good2[0].listOfAddressName.where((element) => element != "").toList().isEmpty){
      Utils.showToast(context, "txtInviterAddress".tr);
      return false;
    }
    if(good2[0].listOfMobile.where((element) => element != "").toList().isEmpty){
      Utils.showToast(context, "txtInviterMobile".tr);
      return false;
    }*/

    var good2Address = good2[0].listOfAddressName.where((element) => element != "").toList();
    if(good2[0].listOfAddressName.length != good2Address.length){
      Utils.showToast(context, "txtInviterAddress".tr);
      return false;
    }
    var good2Mno = good2[0].listOfMobile.where((element) => element != "").toList();
    if(good2[0].listOfMobile.length != good2Mno.length){
      Utils.showToast(context, "txtInviterMobile".tr);
      return false;
    }


    /*Atak*/
    if(atakController.text.isEmpty){
      Utils.showToast(context,"txtAtak".tr);
      return false;
    }


    /*God Detail*/
    var godArray = listOfAllGods.where((element) => element.isSelected == true).toList();
    if(godArray.length < 3){
      Utils.showToast(context, "txtGodSelect".tr);
      return false;
    }


    return true;
  }

  getAllValue(){
    /*Start init Classes*/
    createData.marriageInvitationCard = MarriageInvitationCard();

    createData.marriageInvitationCard!.coverImage = CoverImage();

    createData.marriageInvitationCard!.pair = [];

    createData.marriageInvitationCard!.inviter = InviterClass();
    createData.marriageInvitationCard!.inviter!.name = [];
    createData.marriageInvitationCard!.inviter!.address = [];
    createData.marriageInvitationCard!.inviter!.contactNo = [];

    createData.marriageInvitationCard!.functions = [];

    createData.marriageInvitationCard!.invitation = Invitation();
    createData.marriageInvitationCard!.invitation!.brideInviter = BrideInviter();
    createData.marriageInvitationCard!.invitation!.brideInviter!.values = BrideInviterValues();
    createData.marriageInvitationCard!.invitation!.groomInviter = GroomInviter();
    createData.marriageInvitationCard!.invitation!.groomInviter!.values = GroomInviterValues();


    createData.marriageInvitationCard!.affectionate = Affectionate();
    createData.marriageInvitationCard!.affectionate!.list = [];

    createData.marriageInvitationCard!.ambitious = Affectionate();
    createData.marriageInvitationCard!.ambitious!.list = [];

    createData.marriageInvitationCard!.chirping = Chirping();

    createData.marriageInvitationCard!.nephewGroup = Affectionate();
    createData.marriageInvitationCard!.nephewGroup!.list = [];

    createData.marriageInvitationCard!.uncleGroup = Affectionate();
    createData.marriageInvitationCard!.uncleGroup!.list = [];

    createData.marriageInvitationCard!.auspiciousPlace = AuspiciousPlace();
    createData.marriageInvitationCard!.auspiciousPlace!.contactNo = [];
    createData.marriageInvitationCard!.auspiciousPlace!.address = [];


    createData.marriageInvitationCard!.auspiciousMarriagePlace = AuspiciousPlace();
    createData.marriageInvitationCard!.auspiciousMarriagePlace!.address = [];
    createData.marriageInvitationCard!.auspiciousMarriagePlace!.contactNo = [];

    createData.marriageInvitationCard!.godDetails = [];

    /*End init Classes*/

    /*====================================================================================*/

    /*Fill Up Values In The Class Map*/
    createData.email = (getAllInvitationCard.email != null)?getAllInvitationCard.email : userData.email;
    createData.layoutDesignId = (getAllInvitationCard.layoutDesignId != null)?getAllInvitationCard.layoutDesignId: "3409e5aac99c";
    createData.marriageInvitationCardId = (getAllInvitationCard.marriageInvitationCardId != null)?getAllInvitationCard.marriageInvitationCardId: "2f61ff54";
    createData.marriageInvitationCardName = (getAllInvitationCard.marriageInvitationCardName != null)?getAllInvitationCard.marriageInvitationCardName: "from app";
    createData.marriageInvitationCardType =(getAllInvitationCard.marriageInvitationCardType != null)?getAllInvitationCard.marriageInvitationCardType: "mict1";
    createData.isGroom = isGroomCard;

    var coverImage = CoverImage();
    coverImage.isShow = true;
    coverImage.url = (imgCoverURL != "")?imgCoverURL:Constant.godDemoImageURl.toString();
    createData.marriageInvitationCard!.coverImage = coverImage;

    /*====================================================================================*/

    /*Start For VarPaksh and KanyaPaksh Data*/
    var pairClass = Pair();

    var brideClass = Bride();
    var groomClass = Bride();


    brideClass.name = kanyaNuNameController.text;
    brideClass.enName = brideNameController.text;
    pairClass.bride = brideClass;


    groomClass.name = varRajaNuNameController.text;
    groomClass.enName = groomNameController.text;
    pairClass.groom = groomClass;


    pairClass.marriageDate = mrgDateGujarati;
    pairClass.enMarriageDate = mrgDate;
    pairClass.marriageDay = mrgDateDay;

    createData.marriageInvitationCard!.pair!.add(pairClass);
    Debug.printLog("Pair data==>> ${createData.marriageInvitationCard!.pair}");
    /*End For VarPaksh and KanyaPaksh Data*/

    /*====================================================================================*/

    /*Start For Nimantrak Data*/
    var nimantrakData = InviterClass();

    nimantrakData.name = listNimantrakName;
    nimantrakData.contactNo = listNimantrakMno;
    nimantrakData.address = listNimantrakAddress;
    nimantrakData.mapLink = "https://goo.gl/maps/K2Sg5DtFbSMJ8YgQ6";
    createData.marriageInvitationCard!.inviter = nimantrakData;
    /*End For Nimantrak Data*/


    /*Start For Function Data*/
    for(int i = 0; i < functionsList.length ; i++){
      var functionsClass = Functions();
      functionsClass.functionId = functionsList[i].functionId;
      functionsClass.functionName = functionsList[i].functionName;
      functionsClass.inviter = (functionsList[i].listNames.toString() != "")?functionsList[i].listNames:[];
      functionsClass.functionTime = functionsList[i].functionTime;
      functionsClass.functionDate = functionsList[i].functionDate;
      functionsClass.functionPlace = functionsList[i].functionPlace;
      functionsClass.message = functionsList[i].functionMessage;
      if(functionsClass.functionTime != "" && functionsClass.functionDate != "") {
        createData.marriageInvitationCard!.functions!.add(functionsClass);
      }
    }
    /*End For Function Data*/

    /*====================================================================================*/

    /*Start For Amantrak*/
    var invitation = Invitation();

    var groomData = GroomInviter();
    groomData.id = chirpingInfoGroom.id;
    groomData.type = chirpingInfoGroom.type;
    groomData.marriageOf = chirpingInfoGroom.marriageOf;
    groomData.html = chirpingInfoGroom.html;
    groomData.previewText = dropDownFromGroomMessage;
    var groomInviterValues= GroomInviterValues();

    if(chirpingInfoGroom.values!.day != null) {
      groomInviterValues.day = mrgDateDay;
    }
    if(chirpingInfoGroom.values!.date != null) {
      groomInviterValues.date = mrgDateGujarati;
    }
    if(chirpingInfoGroom.values!.godName != null) {
      groomInviterValues.godName = groomGodNameController.text;
    }
    if(chirpingInfoGroom.values!.motherName != null) {
      groomInviterValues.motherName = groomMotherNameController.text;
    }
    if(chirpingInfoGroom.values!.fatherName != null) {
      groomInviterValues.fatherName = groomFatherNameController.text;
    }
    if(chirpingInfoGroom.values!.hometownName != null) {
      groomInviterValues.hometownName = groomVillageNameController.text;
    }

    invitation.groomInviter = groomData;
    invitation.groomInviter!.values = groomInviterValues;



    var brideData = BrideInviter();
    brideData.id = chirpingInfoBride.id;
    brideData.type = chirpingInfoBride.type;
    brideData.marriageOf = chirpingInfoBride.marriageOf;
    brideData.html = chirpingInfoBride.html;
    brideData.previewText = dropDownFromBrideMessage;
    var brideInviterValues= BrideInviterValues();
    if(chirpingInfoBride.values!.day != null) {
      brideInviterValues.day = mrgDateDay;
    }
    if(chirpingInfoBride.values!.date != null) {
      brideInviterValues.date = mrgDateGujarati;
    }
    if(chirpingInfoBride.values!.motherName != null) {
      brideInviterValues.motherName = brideMotherNameController.text;
    }
    if(chirpingInfoBride.values!.fatherName != null) {
      brideInviterValues.fatherName = brideFatherNameController.text;
    }
    if(chirpingInfoBride.values!.hometownName != null) {
      brideInviterValues.hometownName = brideVillageNameController.text;
    }
    if(chirpingInfoBride.values!.godName != null) {
      brideInviterValues.godName = brideGodController.text;
    }

    invitation.brideInviter = brideData;
    invitation.brideInviter!.values = brideInviterValues;

    createData.marriageInvitationCard!.invitation = invitation;
    /*End For Amantrak*/

    /*====================================================================================*/

    /*Start For Guest All Names Data*/
    var allNamesData = Affectionate();
    var firstList = guestNamesList.where((element) => element.titleName == "txtAapneAavkarvaAatur".tr).toList();
    if(firstList[0].listOfGuestNames.where((element) => element != "").isNotEmpty) {
      allNamesData.list = firstList[0].listOfGuestNames;
      allNamesData.title = firstList[0].titleName;
      createData.marriageInvitationCard!.affectionate = allNamesData;
    }

    allNamesData = Affectionate();
    var secondList = guestNamesList.where((element) => element.titleName == "txtSanehaDhin".tr).toList();
    allNamesData.list = secondList[0].listOfGuestNames;
    allNamesData.title = secondList[0].titleName;
    createData.marriageInvitationCard!.ambitious = allNamesData;

    allNamesData = Affectionate();
    var thirdList = guestNamesList.where((element) => element.titleName == "txtMosalPaksh".tr).toList();
    allNamesData.list = thirdList[0].listOfGuestNames;
    allNamesData.title = thirdList[0].titleName;
    createData.marriageInvitationCard!.nephewGroup = allNamesData;

    allNamesData = Affectionate();
    var fourthList = guestNamesList.where((element) => element.titleName == "txtBhanejPaksh".tr).toList();
    allNamesData.list = fourthList[0].listOfGuestNames;
    allNamesData.title = fourthList[0].titleName;
    createData.marriageInvitationCard!.uncleGroup = allNamesData;
    /*End For Guest All Names Data*/

    /*====================================================================================*/


    /*Start For Tahuko Names Data*/
    var tahukoInviterName = Chirping();
    var listSelectChirp = listOfAllChirping.where((element) => element.previewText == dropDownTahukoMessage).toList();
    tahukoInviterName.html = listSelectChirp[0].html;
    tahukoInviterName.previewText = dropDownTahukoMessage.toString();
    tahukoInviterName.title = "txtTahuko".tr;
    tahukoInviterName.id = listSelectChirp[0].id;
    tahukoInviterName.inviter = listOfTahukoChildName;
    createData.marriageInvitationCard!.chirping = tahukoInviterName;

    /*End For Tahuko Names Data*/


    /*====================================================================================*/

    /*Start For Good Place Data*/
    for(int i = 0; i < goodPlaceNamesList.length ; i++){
      var goodPlace = AuspiciousPlace();
      goodPlace.title = goodPlaceNamesList[i].titleName ?? "";
      goodPlace.inviterName = goodPlaceNamesList[i].inviterName;
      goodPlace.address = goodPlaceNamesList[i].listOfAddressName;
      goodPlace.contactNo = goodPlaceNamesList[i].listOfMobile;
      if(goodPlaceNamesList[i].titleName == "txtSubhSathal".tr){
        createData.marriageInvitationCard!.auspiciousPlace = goodPlace;
      }else if(goodPlaceNamesList[i].titleName == "txtSubhLaganSathal".tr){
        createData.marriageInvitationCard!.auspiciousMarriagePlace = goodPlace;
      }
      Debug.printLog("Get All Value goodPlaceNamesList toJson==>>> ${goodPlace.toJson()}");

    }
    /*End For Good Place Data*/

    /*====================================================================================*/

    /*Start For Surname Data*/
    createData.marriageInvitationCard!.inviterSurname = atakController.text ?? "";
    /*End For Surname Data*/

    /*====================================================================================*/

    /*Start For God's Data*/
    for(int i = 0; i<listOfAllGods.length;i++){
      if(listOfAllGods[i].isSelected) {
        var godDetail = GodDetail();
        godDetail.id = listOfAllGods[i].id ?? "";
        godDetail.name = listOfAllGods[i].name ?? "";
        godDetail.image = listOfAllGods[i].image ?? "";
        createData.marriageInvitationCard!.godDetails!.add(godDetail);
      }
    }
    /*End For God's Data*/

    Debug.printLog("MarriageInvitationCard==>> ${jsonEncode(createData)}");

  }


  final imgPicker = ImagePicker();
  void selectImage(String type,BuildContext context) async {
    PickedFile? img = PickedFile("");
    if(type == Constant.typeCamera){
      img = await imgPicker.getImage(source: ImageSource.camera);
    }else{
      img =  await imgPicker.getImage(source: ImageSource.gallery);
    }
    imgFile = File(img!.path);
    Debug.printLog("Image FIle==>>> $imgFile  ${img.path}");
    update([Constant.idSetMainImage]);
    if(imgFile != null){
      callUploadCardAPI(context);
    }
  }


  getAllInfo(BuildContext context) async {
      if (await InternetConnectivity.isInternetConnect()) {
        isShowProgress = true;
        update([Constant.isShowProgressUpload]);
        var mrgType = (isGroomCard)?Constant.typeGroomAPI:Constant.typeBrideAPI;
        await newKankotriDataModel.getInfo(context,mrgType).then((value) {
          handleKankotriInfoResponse(value,context);
        });
      } else {
        Utils.showToast(context, "txtNoInternet".tr);
      }
  }

  handleKankotriInfoResponse(GetInfoData newKankotriData, BuildContext context) async {
    if (newKankotriData.status == Constant.responseSuccessCode) {
      if (newKankotriData.message != null) {
        Debug.printLog(
            "handleKankotriInfoResponse Res Success ===>> ${newKankotriData.toJson()} ");
        listOfAllChirping = newKankotriData.result!.chirPings!;
        if(listOfAllChirping.isNotEmpty){
          for(int i = 0 ;i < listOfAllChirping.length; i++){
            listOfAllStringChirping.add(listOfAllChirping[i].previewText.toString());
          }
          dropDownTahukoMessage = listOfAllStringChirping[0];
        }
        else{
          listOfAllStringChirping.add("");
          dropDownTahukoMessage = "";
        }

        listOfAllGods = newKankotriData.result!.godDetails!;


        listOfInvitersMessage = newKankotriData.result!.invitationMessages!;

        if(listOfInvitersMessage.isNotEmpty) {
          listOfInvitersGroomMessage = listOfInvitersMessage.where((element) => element.type == Constant.typeGroomAPI).toList();
          chirpingInfoGroom = listOfInvitersGroomMessage[0];
          listOfInvitersBrideMessage = listOfInvitersMessage.where((element) => element.type == Constant.typeBrideAPI).toList();
          chirpingInfoBride = listOfInvitersBrideMessage[0];

          for (int i = 0; i < listOfInvitersGroomMessage.length; i++) {
            listOfMessagesFromGroom.add(listOfInvitersGroomMessage[i].previewText.toString());
          }
          for (int i = 0; i < listOfInvitersBrideMessage.length; i++) {
            listOfMessagesFromBride.add(listOfInvitersBrideMessage[i].previewText.toString());
          }
          dropDownFromGroomMessage = listOfMessagesFromGroom[0];
          dropDownFromBrideMessage = listOfMessagesFromBride[0];
        }
        else{
          listOfMessagesFromGroom.add("");
          listOfMessagesFromBride.add("");
          dropDownFromGroomMessage = "";
          dropDownFromBrideMessage = "";
        }

        if(arguments[1] != null){
          getAllInvitationCard = arguments[1];
          setAllData();
          Debug.printLog("Is Groom Card==>> $isGroomCard");
        }

      } else {
        Debug.printLog(
            "handleKankotriInfoResponse Res Fail ===>> ${newKankotriData.toJson().toString()}");

        if (newKankotriData.message != null && newKankotriData.message!.isNotEmpty) {
          Utils.showToast(context,newKankotriData.message!);
        } else {
          Utils.showToast(context,"txtSomethingWentWrong".tr);
        }
      }
    } else {
      if (newKankotriData.message != null && newKankotriData.message!.isNotEmpty) {
        Utils.showToast(context,newKankotriData.message!);
      } else {
        Utils.showToast(context,"txtSomethingWentWrong".tr);
      }
    }
    isShowProgress = false;
    update([Constant.isShowProgressUpload,Constant.idInviterPart,Constant.idTahukoPart,Constant.idGodNames]);
  }

  callCreateUpdateCardAPI(BuildContext context) async {
    if (validation(context)) {
      if (await InternetConnectivity.isInternetConnect()) {
        Debug.printLog("Data ===>>> ${jsonEncode(createData)}");
        isShowProgress = true;
        update([Constant.isShowProgressUpload]);
        if(isFromAddUpdate == Constant.isFromUpdate){
          await newKankotriDataModel.updateKankotri(
              context, jsonEncode(createData), createData,createData.marriageInvitationCardId.toString()).then((value) {
            handleNewKankotriResponse(value, context);
          });
        }else {
          await newKankotriDataModel.createKankotri(
              context, jsonEncode(createData), createData).then((value) {
            handleNewKankotriResponse(value, context);
          });
        }
      } else {
        Utils.showToast(context, "txtNoInternet".tr);
      }
    }
  }

  handleNewKankotriResponse(CreateKankotriData newKankotriData, BuildContext context) async {
    if (newKankotriData.status == Constant.responseSuccessCode) {
      if (newKankotriData.message != null) {
        Debug.printLog(
            "handleNewKankotriResponse Res Success ===>> ${newKankotriData.toJson().toString()}");
        Utils.showToast(context,newKankotriData.message.toString());
        var functionList = createData.marriageInvitationCard!.functions!.where((element) => element.functionDate != "" && element.functionTime != "").toList();
        List<PreviewFunctions> functionStringTitleList = [];
        for(int i =0;i<functionList.length;i++){
          functionStringTitleList.add(PreviewFunctions(functionList[i].functionId, functionList[i].functionName ?? "",'txtSarvo'.tr));
        }
        Get.toNamed(AppRoutes.preview,arguments: [createData,functionStringTitleList]);
      } else {
        Debug.printLog(
            "handleNewKankotriResponse Res Fail ===>> ${newKankotriData.toJson().toString()}");

        if (newKankotriData.message != null && newKankotriData.message!.isNotEmpty) {
          Utils.showToast(context,newKankotriData.message!);
        } else {
          Utils.showToast(context,"txtSomethingWentWrong".tr);
        }
      }
    } else {
      if (newKankotriData.message != null && newKankotriData.message!.isNotEmpty) {
        Utils.showToast(context,newKankotriData.message!);
      } else {
        Utils.showToast(context,"txtSomethingWentWrong".tr);
      }
    }
    isShowProgress = false;
    update([Constant.isShowProgressUpload]);
  }

  callUploadCardAPI(BuildContext context) async {
      if (await InternetConnectivity.isInternetConnect()) {
        if(imgFile != null) {
          newKankotriDataModel.file = imgFile;
          isShowProgress = true;
          update([Constant.isShowProgressUpload]);
          await newKankotriDataModel.uploadCardImage(context).then((value) {
            handleUploadCardResponse(value, context);
          });
        }else{
          Utils.showToast(context, "txtChooseImage".tr);
        }
      } else {
        Utils.showToast(context, "txtNoInternet".tr);
      }
  }

  handleUploadCardResponse(UploadImageData newKankotriData, BuildContext context) async {
    if (newKankotriData.status == Constant.responseSuccessCode) {
      if (newKankotriData.message != null) {
        Debug.printLog(
            "handleUploadCardResponse Res Success ===>> ${newKankotriData.toJson().toString()}");
        imgCoverURL =  newKankotriData.result!.url ?? "";
        update([Constant.idSetMainImage]);
        // Utils.showToast(context,newKankotriData.message.toString());
      } else {
        Debug.printLog(
            "handleUploadCardResponse Res Fail ===>> ${newKankotriData.toJson().toString()}");

        if (newKankotriData.message != null && newKankotriData.message!.isNotEmpty) {
          Utils.showToast(context,newKankotriData.message!);
        } else {
          Utils.showToast(context,"txtSomethingWentWrong".tr);
        }
      }
    } else {
      if (newKankotriData.message != null && newKankotriData.message!.isNotEmpty) {
        Utils.showToast(context,newKankotriData.message!);
      } else {
        Utils.showToast(context,"txtSomethingWentWrong".tr);
      }
    }
    isShowProgress = false;
    update([Constant.isShowProgressUpload]);
  }


  void setAllData() {

    var mrgInvitationCard = getAllInvitationCard.marriageInvitationCard!;
    /*====================================================================================*/

    /*Image Cover URL*/
    imgCoverURL = mrgInvitationCard.coverImage!.url.toString() ?? "";
    update([Constant.idSetMainImage]);

    /*Start For VarPaksh and KanyaPaksh Data*/
    kanyaNuNameController.text = mrgInvitationCard.pair![0].bride!.name.toString();
    brideNameController.text = mrgInvitationCard.pair![0].bride!.enName.toString();

    varRajaNuNameController.text = mrgInvitationCard.pair![0].groom!.name.toString();
    groomNameController.text = mrgInvitationCard.pair![0].groom!.enName.toString();

    mrgDateGujarati = mrgInvitationCard.pair![0].marriageDate.toString();
    mrgDate = mrgInvitationCard.pair![0].enMarriageDate.toString();
    mrgDateDay = mrgInvitationCard.pair![0].marriageDay.toString();
    marriageDateController.text = mrgDateGujarati;
    update([Constant.idGroomPaksh,Constant.idBridePaksh,Constant.idMrgDate]);
    /*End For VarPaksh and KanyaPaksh Data*/

    /*====================================================================================*/

    /*Start For Nimantrak Data*/
    var listNimantrakNameGet = mrgInvitationCard.inviter!.name;
    for(int i =0; i<listNimantrakNameGet!.length; i++){
      listNimantrakName.add(listNimantrakNameGet[i]);
      // listNimantrakName[listNimantrakName.indexOf(listNimantrakName[i])] = listNimantrakNameGet[i];
      changeValueInListForNimantrak(i, Constant.typeNimantrakName, listNimantrakNameGet[i]);
    }

    var listNimantrakMnoGet = mrgInvitationCard.inviter!.contactNo;
    for(int i =0; i<listNimantrakMnoGet!.length; i++){
      listNimantrakMno.add(listNimantrakMnoGet[i]);
      // listNimantrakMno[listNimantrakMno.indexOf(listNimantrakMno[i])] = listNimantrakMnoGet[i];
      changeValueInListForNimantrak(i, Constant.typeNimantrakMobile, listNimantrakMnoGet[i]);
    }

    var listNimantrakAddressGet = mrgInvitationCard.inviter!.address;
    for(int i =0; i<listNimantrakAddressGet!.length; i++){
      listNimantrakAddress.add(listNimantrakAddressGet[i]);
      // listNimantrakAddress[listNimantrakAddress.indexOf(listNimantrakAddress[i])] = listNimantrakAddressGet[i];
      changeValueInListForNimantrak(i, Constant.typeNimantrakSarnamu, listNimantrakAddressGet[i]);
    }
    Debug.printLog("Nimantrak Data===>> $listNimantrakName  $listNimantrakMno $listNimantrakAddress");
    update([Constant.idAddNimantrakPart]);
    /*End For Nimantrak Data*/


    /*Start For Function Data*/
    var functionsListGet =  mrgInvitationCard.functions!;
    for(var i = 0 ; i < functionsListGet.length ; i ++){
      var functions = functionsListGet[i];
      functionsList.add(FunctionsNimantrakName(functions.functionId! ?? "", functions.functionName ?? "", functions.inviter ?? [], functions.functionDate ?? "", functions.functionTime ?? "",
          functions.functionPlace ?? "", functions.message ?? "",[]));
      functionsPlaceListController.add(TextEditingController(text:functions.functionPlace ?? "" ));
      functionsMessageListController.add(TextEditingController(text:functions.message ?? ""));
      for(var j = 0; j < functions.inviter!.length; j ++){
        functionsList[i].listEditTextNames.add(TextEditingController(text: functions.inviter![j]));
      }
    }
    update([Constant.idFunctionsPart]);
    /*End For Function Data*/

    /*====================================================================================*/

    /*Start For Amantrak*/
    var groomAmantrak = mrgInvitationCard.invitation!.groomInviter;
    if(groomAmantrak != null){
      if(groomAmantrak.values!.date != null) {
        mrgDateDay = groomAmantrak.values!.date!;
      }

      if(groomAmantrak.values!.date != null) {
        mrgDateGujarati = groomAmantrak.values!.day!;
      }

      if(groomAmantrak.values!.godName != null) {
        groomGodNameController.text = groomAmantrak.values!.godName!;
      }

      if(groomAmantrak.values!.motherName != null) {
        groomMotherNameController.text = groomAmantrak.values!.motherName!;
      }

      if(groomAmantrak.values!.fatherName != null) {
        groomFatherNameController.text = groomAmantrak.values!.fatherName!;
      }

      if(groomAmantrak.values!.hometownName != null) {
        groomVillageNameController.text = groomAmantrak.values!.hometownName!;
      }
    }

    var brideAmantrak = mrgInvitationCard.invitation!.brideInviter;
    if(brideAmantrak != null){
      if(brideAmantrak.values!.date != null) {
        mrgDateDay = brideAmantrak.values!.date!;
      }

      if(brideAmantrak.values!.date != null) {
        mrgDateGujarati = brideAmantrak.values!.day!;
      }

      if(brideAmantrak.values!.godName != null) {
        brideGodController.text = brideAmantrak.values!.godName!;
      }

      if(brideAmantrak.values!.motherName != null) {
        brideMotherNameController.text = brideAmantrak.values!.motherName!;
      }

      if(brideAmantrak.values!.fatherName != null) {
        brideFatherNameController.text = brideAmantrak.values!.fatherName!;
      }

      if(brideAmantrak.values!.hometownName != null) {
        brideVillageNameController.text = brideAmantrak.values!.hometownName!;
      }
    }

    /*2 Dropdown Pending*/
    dropDownFromBrideMessage = brideAmantrak!.previewText!;
    changeDropDownValueForGroomBride(dropDownFromBrideMessage,Constant.typeBride);


    dropDownFromGroomMessage = groomAmantrak!.previewText!;
    changeDropDownValueForGroomBride(dropDownFromGroomMessage,Constant.typeGroom);


    update([Constant.idInviterPart]);
    /*End For Amantrak*/

    /*====================================================================================*/

    /*Start For Guest All Names Data*/
    var allNamesDataGetFirst = mrgInvitationCard.affectionate;
    List<TextEditingController> firstEditList = [];
    if(allNamesDataGetFirst!.list!.isNotEmpty) {
      for (var i = 0; i < allNamesDataGetFirst.list!.length; i++) {
        firstEditList.add(
            TextEditingController(text: allNamesDataGetFirst.list![i]));
      }
    }
    guestNamesList.add(GuestAllName(allNamesDataGetFirst.title!, allNamesDataGetFirst.list!,firstEditList));


    var allNamesDataGetSecond = mrgInvitationCard.ambitious;
    List<TextEditingController> secondEditList = [];
    if(allNamesDataGetSecond!.list!.isNotEmpty) {
      for (var i = 0; i < allNamesDataGetSecond.list!.length; i++) {
        secondEditList.add(TextEditingController(text: allNamesDataGetSecond.list![i]));
      }
    }
    guestNamesList.add(GuestAllName(allNamesDataGetSecond.title!, allNamesDataGetSecond.list!,secondEditList));


    var allNamesDataGetThird = mrgInvitationCard.nephewGroup;
    List<TextEditingController> thirdEditList = [];
    if(allNamesDataGetThird!.list!.isNotEmpty) {
      for (var i = 0; i < allNamesDataGetThird.list!.length; i++) {
        thirdEditList.add(
            TextEditingController(text: allNamesDataGetThird.list![i]));
      }
    }
    guestNamesList.add(GuestAllName(allNamesDataGetThird.title!, allNamesDataGetThird.list!,thirdEditList));


    var allNamesDataGetFourth = mrgInvitationCard.uncleGroup;
    List<TextEditingController> fourthEditList = [];
    if(allNamesDataGetFourth!.list!.isNotEmpty) {
      for (var i = 0; i < allNamesDataGetFourth.list!.length; i++) {
        fourthEditList.add(
            TextEditingController(text: allNamesDataGetFourth.list![i]));
      }
    }
    guestNamesList.add(GuestAllName(allNamesDataGetFourth.title!, allNamesDataGetFourth.list!,fourthEditList));


    update([Constant.idGuestNameAll]);

    /*End For Guest All Names Data*/

    /*====================================================================================*/


    /*Start For Tahuko Names Data*/
    listOfTahukoChildName = mrgInvitationCard.chirping!.inviter!;
    dropDownTahukoMessage = mrgInvitationCard.chirping!.previewText!;
    changeDropDownValueForTahuko(dropDownTahukoMessage);
    var childNameList = mrgInvitationCard.chirping!.inviter;
    for (int i = 0; i < childNameList!.length; i++) {
      tahukoChildController.add(TextEditingController(text: childNameList[i]));
    }
    update([Constant.idTahukoPart]);
    /*End For Tahuko Names Data*/

    /*====================================================================================*/

    /*Start For Good Place Data*/
    var goodPlace = mrgInvitationCard.auspiciousPlace;
    List<TextEditingController> firstAddressEditList = [];
    if(goodPlace!.address!.isNotEmpty) {
      for (var i = 0; i < goodPlace.address!.length; i++) {
        firstAddressEditList.add(
            TextEditingController(text: goodPlace.address![i]));
      }
    }
    List<TextEditingController> firstContactEditList = [];
    if(goodPlace.contactNo!.isNotEmpty) {
      for (var i = 0; i < goodPlace.contactNo!.length; i++) {
        firstContactEditList.add(
            TextEditingController(text: goodPlace.contactNo![i]));
      }
    }
    goodPlaceNamesList.add(GoodPlaceAllName(goodPlace.title!, goodPlace.address!, goodPlace.contactNo!, goodPlace.inviterName!,
        firstAddressEditList,firstContactEditList,TextEditingController(text: goodPlace.inviterName)));



    var goodMrgPlace = mrgInvitationCard.auspiciousMarriagePlace;
    List<TextEditingController> secondAddressEditList = [];
    if(goodMrgPlace!.address!.isNotEmpty) {
      for (var i = 0; i < goodMrgPlace.address!.length; i++) {
        secondAddressEditList.add(
            TextEditingController(text: goodMrgPlace.address![i]));
      }
    }
    List<TextEditingController> secondContactEditList = [];
    if(goodMrgPlace.contactNo!.isNotEmpty) {
      for (var i = 0; i < goodMrgPlace.contactNo!.length; i++) {
        secondContactEditList.add(
            TextEditingController(text: goodMrgPlace.contactNo![i]));
      }
    }
    goodPlaceNamesList.add(GoodPlaceAllName(goodMrgPlace.title!, goodMrgPlace.address!,
        goodMrgPlace.contactNo!, goodMrgPlace.inviterName!,secondAddressEditList,secondContactEditList,TextEditingController(text: goodMrgPlace.inviterName)));
    update([Constant.idGoodPlaceAll]);
    /*End For Good Place Data*/

    /*====================================================================================*/

    /*Start For Surname Data*/
    atakController.text = mrgInvitationCard.inviterSurname!;
    /*End For Surname Data*/

    /*====================================================================================*/

    /*Start For God's Data*/

    var godDetailGetList = mrgInvitationCard.godDetails!;
    List<String> godIds = [];
    for(int i =0;i< godDetailGetList.length;i++){
      if(godDetailGetList[i].id != "") {
        godIds.add(godDetailGetList[i].id!);
      }else{
        godIds.add("");
      }
    }


    for(int i=0;i<listOfAllGods.length;i++){
      if(godIds.contains(listOfAllGods[i].id!)){
        Debug.printLog("Contain Id==>> ");
        listOfAllGods[i].isSelected = true;
      }else{
        listOfAllGods[i].isSelected = false;
        Debug.printLog("Contain Not Id==>> $godIds");
      }
    }

    var anotherList = godDetailGetList.where((element) => element.id == "").toList();
    for(int i = 0 ; i < anotherList.length; i++){
      var god = GodDetailInfo();
      god.name = anotherList[i].name;
      god.image = "";
      god.isSelected = true;
      god.id = "";
      listOfAllGods.add(god);
    }

    update([Constant.idGodNames]);


    /*var godDetailGetList = mrgInvitationCard.godDetails;


    for(int i = 0; i<listOfAllGods.length;i++){
      if(listOfAllGods[i].isSelected) {
        var godDetail = GodDetail();
        godDetail.id = listOfAllGods[i].id ?? "";
        godDetail.name = listOfAllGods[i].name ?? "";
        godDetail.image = listOfAllGods[i].image ?? "";
        createData.marriageInvitationCard!.godDetails!.add(godDetail);
      }*/
    }
    /*End For God's Data*/
  }


class FunctionsNimantrakName{
  String functionId = "";
  String functionName = "";
  String functionDate = "";
  String functionTime = "";
  String functionPlace = "";
  String functionMessage = "";
  List<String> listNames = [];
  List<TextEditingController> listEditTextNames = [];

  FunctionsNimantrakName(this.functionId,this.functionName,this.listNames,this.functionDate,this.functionTime,this.functionPlace,this.functionMessage,this.listEditTextNames);
}

class GuestAllName{
  String titleName = "";
  List<String> listOfGuestNames = [];
  List<TextEditingController>? listOfGuestNamesController = [];

  GuestAllName(this.titleName,this.listOfGuestNames, this.listOfGuestNamesController);
}

class GoodPlaceAllName{
  String titleName = "";
  List<String> listOfAddressName = [];
  List<String> listOfMobile = [];
  String? inviterName;
  TextEditingController? inviterController;
  List<TextEditingController> listEditTextAddress = [];
  List<TextEditingController> listEditTextMobile = [];
  GoodPlaceAllName(this.titleName,this.listOfAddressName,this.listOfMobile,this.inviterName,this.listEditTextAddress,this.listEditTextMobile,this.inviterController);
}

class PreviewFunctions{
  String? fId = "";
  String? fName = "";
  String? fPerson = "";

  PreviewFunctions(this.fId,this.fName,this.fPerson);
}
/*
class GodInformation{
  String godImageURL = "";
  String godName = "";
  bool? isSelected = false;

  GodInformation(this.godImageURL,this.godName,this.isSelected);
}*/
