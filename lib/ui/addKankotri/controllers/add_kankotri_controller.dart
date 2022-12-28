import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/routes/app_routes.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/getInfoData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/newkankotridatamodel.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/uploadImageData.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import 'package:spotify_flutter_code/utils/params.dart';

import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../datamodel/createKankotriData.dart';
import '../datamodel/newKankotriData.dart';

class AddKankotriController extends GetxController {

  var arguments = Get.arguments;
  bool isGroomCard = true;
  String isFromAddUpdate = "";
  String isFromScreen = "";
  User userData = FirebaseAuth.instance.currentUser!;
  bool isShowProgress = false;
  NewKankotriDataModel newKankotriDataModel = NewKankotriDataModel();
  File? imgFile;
  String? imgCoverURL = "";
  String? imgCoverId = "";

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

  // List<String> listNimantrakName = [];
  List<String> listNimantrakAddress = [];
  List<String> listNimantrakMno = [];
  List<NimantrakModel> listNimantrakName = [];
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

  List<String> listOfAllOtherTitles = [];
  String dropDownOtherTitle = "";

  String dropDownGroomMotherName = Utils.getDefaultSelectedTitle();
  String dropDownGroomFatherName = Utils.getDefaultSelectedTitle();
  String dropDownBrideMotherName = Utils.getDefaultSelectedTitle();
  String dropDownBrideFatherName = Utils.getDefaultSelectedTitle();

  String dropDownGoodPlace = Utils.getDefaultSelectedTitle();
  String dropDownGoodMrgPlace = Utils.getDefaultSelectedTitle();


  /*Layout Id and Type*/
  var newLayoutId = "";
  var newLayoutType = "";
  var newCreatedCardId = "";

  @override
  void onInit() {
    super.onInit();
    if(arguments[0] != null){
      isGroomCard = arguments[0];
      Debug.printLog("Card arguments 0==>> $isGroomCard");
    }


    if(arguments[1] != null){
      getAllInvitationCard = arguments[1];
      if(arguments[3] == Constant.isFromHomeScreen){
        addData();
      }
    }else {
      addData();
    }

    getAllInfo(Get.context!);


    if(arguments[2] != null){
      isFromAddUpdate = arguments[2];
      Debug.printLog("Card arguments 2==>> $isFromAddUpdate");
    }
    if(arguments[3] != null){
      isFromScreen = arguments[3];
      Debug.printLog("Card arguments 3==>> $isFromAddUpdate");
    }
  }

  addData(){
    addNimantrakNameListData(true);
    addNimantrakAddressListData(true);
    addNimantrakMnoListData(true);
    addAllFunctionsList();
    addAllGuestNames();
    addRemoveTahukoChildName(true);
    addGoodPlaceNames();
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
        // var date = DateFormat("yyyy-MM-dd","gu").format(picked);
        var date = Utils.translateMobileNumber(DateFormat("dd-MM-yyyy").format(picked));
        functionsList[functionsList.indexOf(functionsList[index])].functionDate = date.toString();
      }else{
        mrgDate = convertedDateTime.toString();
        mrgDateGujarati = Utils.translateMobileNumber(DateFormat("dd-MM-yyyy").format(picked));
        mrgDateDay = DateFormat("EEEE","gu").format(picked);
      }
      Debug.printLog("convertedDateTime==>> $mrgDateDay =>  $mrgDateGujarati  " );
      marriageDateController.text = mrgDateGujarati;

      update([Constant.idMrgDate,Constant.idFunctionsPart,Constant.idInviterPart]);

    }

  }

  Future<void> selectTime(BuildContext context,int index) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked != null){
      TimeOfDay morningTime = TimeOfDay(hour: picked.hour, minute:picked.minute);
      var timeAmPm = "";
      if (morningTime.period == DayPeriod.am) {
        timeAmPm = "વાગે સવારે";
      } else {
        timeAmPm = "વાગે સાંજે";
      }
      morningTime = morningTime.replacing(hour: morningTime.hourOfPeriod);

      var time = "${Utils.translateMobileNumber("${morningTime.hour}:${morningTime.minute}")} $timeAmPm";
      functionsList[functionsList.indexOf(functionsList[index])].functionTime = time.toString();
    }
    update([Constant.idFunctionsPart]);
  }

  addNimantrakNameListData(bool isAdd, {int? index = 0}) {
    if (isAdd) {
      var data = NimantrakModel();
      data.nimantrakName = "";
      data.otherTitleList = Utils.getOtherTitlesList();
      data.selectedTitle = Utils.getDefaultSelectedTitle();
      listNimantrakName.add(data);
      // listNimantrakName.add("");
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
      var data = NimantrakModel();
      data.selectedTitle = Utils.getDefaultSelectedTitle();
      data.otherTitleList = Utils.getOtherTitlesList();
      data.nimantrakName = "";
      functionsList[mainIndex].listEditTextNames.add(TextEditingController());
      functionsList[mainIndex].listNames.add(data);
    } else {
      functionsList[mainIndex].listEditTextNames.removeAt(index!);
      functionsList[mainIndex].listNames.removeAt(index);
    }
    update([Constant.idFunctionsPart]);
  }

  addAllFunctionsList() {
    var data = NimantrakModel();
    data.selectedTitle = Utils.getDefaultSelectedTitle();
    data.otherTitleList = Utils.getOtherTitlesList();
    data.nimantrakName = "";

    functionsList.add(FunctionsNimantrakName("f1","txtMadapMuhrat".tr,[data],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    functionsList.add(FunctionsNimantrakName("f2","txtGitSandhya".tr,[data],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    functionsList.add(FunctionsNimantrakName("f3","txtRasGarba".tr,[data],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    functionsList.add(FunctionsNimantrakName("f4",(isGroomCard)?"txtJan".tr:"txtJanAagman".tr,[data],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    functionsList.add(FunctionsNimantrakName("f5","txtBhojan".tr,[data],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    functionsList.add(FunctionsNimantrakName("f6","txtHastMelap".tr,[data],"","","","",[TextEditingController()]));
    functionsPlaceListController.add(TextEditingController());
    functionsMessageListController.add(TextEditingController());
    update([Constant.idFunctionsPart]);
  }


  addAllGuestNames() {
    var data = NimantrakModel();
    data.selectedTitle = Utils.getDefaultSelectedTitle();
    data.otherTitleList = Utils.getOtherTitlesList();
    data.nimantrakName = "";
    guestNamesList.add(GuestAllName("txtAapneAavkarvaAatur".tr,[data],[TextEditingController()]));
    guestNamesList.add(GuestAllName("txtSanehaDhin".tr,[data],[TextEditingController()]));
    guestNamesList.add(GuestAllName("txtMosalPaksh".tr,[data],[TextEditingController()]));
    guestNamesList.add(GuestAllName("txtBhanejPaksh".tr,[data],[TextEditingController()]));
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
      var data = NimantrakModel();
      data.selectedTitle = Utils.getDefaultSelectedTitle();
      data.otherTitleList = Utils.getOtherTitlesList();
      data.nimantrakName = "";
      guestNamesList[mainIndex].listOfGuestNamesController!.add(TextEditingController());
      guestNamesList[mainIndex].listOfGuestNames.add(data);
    } else {
      guestNamesList[mainIndex].listOfGuestNamesController!.removeAt(index!);
      guestNamesList[mainIndex].listOfGuestNames.removeAt(index);
    }
    update([Constant.idGuestNameAll]);
  }


  addGoodPlaceNames() {
    goodPlaceNamesList.add(GoodPlaceAllName("txtSubhSathal".tr,[""],[""],"",[TextEditingController()],[TextEditingController()],TextEditingController(),Utils.getDefaultSelectedTitle()));
    goodPlaceNamesList.add(GoodPlaceAllName("txtSubhLaganSathal".tr,[""],[""],"",[TextEditingController()],[TextEditingController()],TextEditingController(),Utils.getDefaultSelectedTitle()));
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


  /*changeValueInListForNimantrak(int index,String type,String value) {
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
  }*/

  changeValueInListForNimantrak(int index,String type,String value) {
    if(type == Constant.typeNimantrakName){
      listNimantrakName[listNimantrakName.indexOf(listNimantrakName[index])].nimantrakName = value;
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

  void onChangeDropDownAmantrak(String value, String type) {
    if (type == Constant.typeGroomMotherName) {
      dropDownGroomMotherName = value;
    } else if (type == Constant.typeGroomFatherName) {
      dropDownGroomFatherName = value;
    } else if (type == Constant.typeBrideMotherName) {
      dropDownBrideMotherName = value;
    } else if (type == Constant.typeBrideMotherName) {
      dropDownBrideMotherName = value;
    }
    update([Constant.idInviterPart]);
  }

  void changeDropDownValueForOtherTitle(String string, int index,String type) {
    if(type == Constant.typeNimantrakName) {
      listNimantrakName[index].selectedTitle = string;
    }
    update([Constant.idAddNimantrakPart]);
  }

  void changeDropDownValueForOtherTitleFunctions(String value, int index, int mainIndex) {
    functionsList[mainIndex].listNames[index].selectedTitle = value;
    update([Constant.idFunctionsPart]);
  }

  void changeDropDownValueForGuestNames(String value, int index, int mainIndex) {
    guestNamesList[mainIndex].listOfGuestNames[index].selectedTitle = value;
    update([Constant.idGuestNameAll]);
  }

  void changeDropDownValueForGoodPlace(String value,int mainIndex) {
    goodPlaceNamesList[mainIndex].selectedValue = value;
    update([Constant.idGoodPlaceAll]);
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
    functionsList[mainIndex].listNames[functionsList[mainIndex].listNames.indexOf(functionsList[mainIndex].listNames[index])].nimantrakName = value;
    update([Constant.idFunctionsPart]);
  }

  changeValueInListForGuestAllNames(int index,int mainIndex,String value) {
    Debug.printLog("changeValueInListForGuestAllNames==>>  $value");
    /*guestNamesList[mainIndex].listOfGuestNames[guestNamesList[mainIndex]
        .listOfGuestNames.indexOf(
        guestNamesList[mainIndex].listOfGuestNames[index])] = value;
*/

    guestNamesList[mainIndex].listOfGuestNames[index].nimantrakName = value;
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
      if(selectedGroomList.isNotEmpty) {
        chirpingInfoGroom = selectedGroomList[0];
        dropDownFromGroomMessage = value;
      }else{
        if (isGroomCard) {
          chirpingInfoGroom.previewText =
              "સહર્ષ ખુશાલી સાથ જણાવવાનું કે અમારા કુળદેવી આઈ શ્રી ખોડિયાર માતાજીની અસીમ કૃપાથી નાની ભગેડી ( હાલ સુરત ) નિવાસી અ. સૌ. ચંપાબેન તથા શ્રી જગદીશભાઈ ચનાભાઈ વિરાણી ના સુપુત્ર";
          chirpingInfoGroom.html =
              "'<p style='text-align:center'>સહર્ષ ખુશાલી સાથ જણાવવાનું કે અમારા કુળદેવી \${godName}ની અસીમ કૃપાથી</p><p style='text-align:center'>\${hometownName} નિવાસી </p><p style='text-align:center'>\${motherName} તથા \${fatherName}ના સુપુત્ર</p>'";
          chirpingInfoGroom.type = Constant.typeGroom;
          chirpingInfoGroom.values = ValuesInfo();
          var data = ValuesInfo();
          data.fatherName = "શ્રી જગદીશભાઈ ચનાભાઈ વિરાણી";
          data.motherName = "શઅ. સૌ. ચંપાબેન";
          data.godName = "આઈ શ્રી ખોડિયાર માતાજી";
          data.hometownName = "નાની ભગેડી ( હાલ સુરત )";
          data.date = "";
          data.day = "";
          chirpingInfoGroom.values = data;
          dropDownFromGroomMessage =
              "સહર્ષ ખુશાલી સાથ જણાવવાનું કે અમારા કુળદેવી આઈ શ્રી ખોડિયાર માતાજીની અસીમ કૃપાથી નાની ભગેડી ( હાલ સુરત ) નિવાસી અ. સૌ. ચંપાબેન તથા શ્રી જગદીશભાઈ ચનાભાઈ વિરાણી ના સુપુત્ર";
        }
        else{
          chirpingInfoGroom.previewText = "નાની ભગેડી ( હાલ સુરત ) નિવાસી અ. સૌ. ચંપાબેન તથા શ્રી જગદીશભાઈ ચનાભાઈ વિરાણી ની સુપુત્ર સાથે સવંત ૨૦૭૮ ના માગસર સુદ ૧૧ ને રવિવાર તા.4/12/2022 ના રોજ શુભદિને નિરધાર્યાં છે. તો આનંદભરી વેળાએ વડીલોના આશિષ,સ્વજનોની લાગણીથી કુમ-કુમ તિલક,શ્રીફળ,અક્ષત અને અગ્નિની સાક્ષીએ રેશમની ગાંઠે બંધાશે,તો નવ યુગલને અંત:કરણના આશિષ અને શુભેચ્છાઓના નિરથી સીંચવા આપશ્રી અવશ્ય પધારશોજી.";
          chirpingInfoGroom.html = "'<p style='text-align:center'>\${hometownName} નિવાસી</p><p style='text-align:center'>\${motherName} તથા \${fatherName}ની સુપુત્ર સાથે સવંત ૨૦૭૮ ના માગસર સુદ ૧૧ ને \${day} તા.\${date} ના રોજ શુભદિને નિરધાર્યાં છે. તો આનંદભરી વેળાએ વડીલોના આશિષ,સ્વજનોની લાગણીથી કુમ-કુમ તિલક,શ્રીફળ,અક્ષત અને અગ્નિની સાક્ષીએ રેશમની ગાંઠે બંધાશે,તો નવ યુગલને અંત:કરણના આશિષ અને શુભેચ્છાઓના નિરથી સીંચવા આપશ્રી અવશ્ય પધારશોજી.</p>'";
          chirpingInfoGroom.type = Constant.typeGroom;
          chirpingInfoGroom.values = ValuesInfo();
          var data = ValuesInfo();
          data.fatherName = "શ્રી જગદીશભાઈ ચનાભાઈ વિરાણી";
          data.motherName = "અ. સૌ. ચંપાબેન";
          data.godName = "";
          data.hometownName = "નાની ભગેડી ( હાલ સુરત )";
          data.date = "4/12/2022";
          data.day = "રવિવાર";
          chirpingInfoGroom.values = data;
          dropDownFromGroomMessage =
          "નાની ભગેડી ( હાલ સુરત ) નિવાસી અ. સૌ. ચંપાબેન તથા શ્રી જગદીશભાઈ ચનાભાઈ વિરાણી ની સુપુત્ર સાથે સવંત ૨૦૭૮ ના માગસર સુદ ૧૧ ને રવિવાર તા.4/12/2022 ના રોજ શુભદિને નિરધાર્યાં છે. તો આનંદભરી વેળાએ વડીલોના આશિષ,સ્વજનોની લાગણીથી કુમ-કુમ તિલક,શ્રીફળ,અક્ષત અને અગ્નિની સાક્ષીએ રેશમની ગાંઠે બંધાશે,તો નવ યુગલને અંત:કરણના આશિષ અને શુભેચ્છાઓના નિરથી સીંચવા આપશ્રી અવશ્ય પધારશોજી.";
        }
      }
    }else{
      var selectedBrideList = listOfInvitersBrideMessage.where((element) => element.previewText == value).toList();
      if(selectedBrideList.isNotEmpty) {
        chirpingInfoBride = selectedBrideList[0];
        dropDownFromBrideMessage = value;
      }else{
        if (isGroomCard) {
          chirpingInfoBride.previewText = "મોટી વાવડી ( હાલ સુરત ) નિવાસી અ. સૌ. સંગીતાબેન તથા શ્રી પ્રવીણભાઈ મોહનભાઇ સુતરીયાની વ્હાલી આત્મજા સાથે સંવત ૨૦૭૮ ના કારતક વદ ૧૧ ને રવિવાર તા.4/12/2022 ના શુભ દિવસે વેદ, વિપ્ર, વડિલો અને અગ્નિની સાક્ષીએ આપની ઉષ્મા સભર ઉપસ્થિતિમાં સંસારયાત્રામાં પ્રવેશ કરશે, તો આ શુભ પ્રસંગે નવદંપતિને આશીર્વાદ આપવા સહકુટુંબને પધારવા અમારૂં ભાવભર્યું આમંત્રણ છે.";
          chirpingInfoBride.html = "'<p style='text-align:center'>\${hometownName} નિવાસી</p><p style='text-align:center'>\${motherName} તથા \${fatherName}ની વ્હાલી આત્મજા સાથે સંવત ૨૦૭૮ ના કારતક વદ ૧૧ ને \${day} તા.\${date} ના શુભ દિવસે વેદ, વિપ્ર, વડિલો અને અગ્નિની સાક્ષીએ આપની ઉષ્મા સભર ઉપસ્થિતિમાં સંસારયાત્રામાં પ્રવેશ કરશે, તો આ શુભ પ્રસંગે નવદંપતિને આશીર્વાદ આપવા સહકુટુંબને પધારવા અમારૂં ભાવભર્યું આમંત્રણ છે.</p>'";
          chirpingInfoBride.type = Constant.typeBride;
          chirpingInfoBride.values = ValuesInfo();
          var data = ValuesInfo();
          data.fatherName = "શ્રી પ્રવીણભાઈ મોહનભાઇ સુતરીયા";
          data.motherName = "અ. સૌ. સંગીતાબેન";
          data.godName = "";
          data.hometownName = "મોટી વાવડી ( હાલ સુરત )";
          data.date = "4/12/2022";
          data.day = "રવિવાર";
          chirpingInfoBride.values = data;
          dropDownFromBrideMessage =
          "મોટી વાવડી ( હાલ સુરત ) નિવાસી અ. સૌ. સંગીતાબેન તથા શ્રી પ્રવીણભાઈ મોહનભાઇ સુતરીયાની વ્હાલી આત્મજા સાથે સંવત ૨૦૭૮ ના કારતક વદ ૧૧ ને રવિવાર તા.4/12/2022 ના શુભ દિવસે વેદ, વિપ્ર, વડિલો અને અગ્નિની સાક્ષીએ આપની ઉષ્મા સભર ઉપસ્થિતિમાં સંસારયાત્રામાં પ્રવેશ કરશે, તો આ શુભ પ્રસંગે નવદંપતિને આશીર્વાદ આપવા સહકુટુંબને પધારવા અમારૂં ભાવભર્યું આમંત્રણ છે.";
        }
        else {
          chirpingInfoBride.previewText = "સહર્ષ ખુશાલી સાથ જણાવવાનું કે અમારા કુળદેવી આઈ શ્રી ખોડિયાર માતાજીની અસીમ કૃપાથી નાની ભગેડી ( હાલ સુરત ) નિવાસી અ. સૌ. ચંપાબેન તથા શ્રી જગદીશભાઈ ચનાભાઈ વિરાણી ના સુપુત્ર";
          chirpingInfoBride.html = "'<p style='text-align:center'>સહર્ષ ખુશાલી સાથ જણાવવાનું કે અમારા કુળદેવી \${godName}ની અસીમ કૃપાથી</p><p style='text-align:center'>\${hometownName} નિવાસી </p><p style='text-align:center'>\${motherName} તથા \${fatherName}ના સુપુત્ર</p>'";
          chirpingInfoBride.type = Constant.typeBride;
          chirpingInfoBride.values = ValuesInfo();
          var data = ValuesInfo();
          data.fatherName = "શ્રી જગદીશભાઈ ચનાભાઈ વિરાણી";
          data.motherName = "શઅ. સૌ. ચંપાબેન";
          data.godName = "આઈ શ્રી ખોડિયાર માતાજી";
          data.hometownName = "નાની ભગેડી ( હાલ સુરત )";
          data.date = "";
          data.day = "";
          chirpingInfoBride.values = data;
          dropDownFromBrideMessage =
          "સહર્ષ ખુશાલી સાથ જણાવવાનું કે અમારા કુળદેવી આઈ શ્રી ખોડિયાર માતાજીની અસીમ કૃપાથી નાની ભગેડી ( હાલ સુરત ) નિવાસી અ. સૌ. ચંપાબેન તથા શ્રી જગદીશભાઈ ચનાભાઈ વિરાણી ના સુપુત્ર";

        }
      }
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
    var n1 = listNimantrakName.where((element) => element.nimantrakName != "").toList();
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
    /*if(groomGodNameController.text.isEmpty && listOfInvitersGroomMessage.isNotEmpty &&
        chirpingInfoBride.values!.godName != null){
      Utils.showToast(context, "txtGroomGod".tr);
      return false;
    }*/
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
    /*if (brideGodController.text.isEmpty &&
        listOfInvitersBrideMessage.isNotEmpty &&
        chirpingInfoBride.values!.godName != null) {
      Utils.showToast(context, "txtBrideGod".tr);
      return false;
    }*/
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
    createData.marriageInvitationCard!.guestName = "";
    /*Fill Up Values In The Class Map*/
    /*if(isFromScreen == Constant.isFromCategoryScreen || isFromScreen == Constant.isFromHomeScreen){
      createData.layoutDesignId =  getAllInvitationCard.layoutDesignId ?? "";
      createData.marriageInvitationCardId = "";
      createData.marriageInvitationCardName =  getAllInvitationCard.marriageInvitationCardName ?? "";
      createData.marriageInvitationCardType = getAllInvitationCard.marriageInvitationCardType ?? "";
      createData.isGroom = isGroomCard;
    } else {
      createData.layoutDesignId = (getAllInvitationCard.layoutDesignId != null) ? getAllInvitationCard.layoutDesignId : "3409e5aac99c";
      createData.marriageInvitationCardId = (getAllInvitationCard.marriageInvitationCardId != null) ? getAllInvitationCard.marriageInvitationCardId : "";
      createData.marriageInvitationCardName = (getAllInvitationCard.marriageInvitationCardName != null) ? getAllInvitationCard.marriageInvitationCardName : "from app";
      createData.marriageInvitationCardType = (getAllInvitationCard.marriageInvitationCardType != null) ? getAllInvitationCard.marriageInvitationCardType : "mict1";
      createData.isGroom = isGroomCard;
    }*/

    createData.layoutDesignId = (newLayoutId == "") ? getAllInvitationCard.layoutDesignId : newLayoutId;
    createData.marriageInvitationCardId = (newCreatedCardId == "")?getAllInvitationCard.marriageInvitationCardId : newCreatedCardId;
    createData.marriageInvitationCardName = getAllInvitationCard.marriageInvitationCardName ?? "";
    createData.marriageInvitationCardType = (newLayoutType == "") ? getAllInvitationCard.marriageInvitationCardType : newLayoutType;
    createData.isGroom = isGroomCard;

    var coverImage = CoverImage();
    coverImage.isShow = getAllInvitationCard.marriageInvitationCard!.coverImage!.isShow ??  true;
    coverImage.url = (imgCoverURL != "")?imgCoverURL : "";
    coverImage.id = imgCoverId ?? "";
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
    List<String> nameList = [];
    for(int i =0;i < listNimantrakName.length ; i++){
      var title = listNimantrakName[i].selectedTitle;
      var name = listNimantrakName[i].nimantrakName;
      nameList.add("$title $name");
    }
    nimantrakData.name = nameList;
    nimantrakData.contactNo = listNimantrakMno;
    nimantrakData.address = listNimantrakAddress;
    var address = "";
    for(int i=0;i<listNimantrakAddress.length;i++){
      address = address+listNimantrakAddress[i];
    }
    getLocationFromAddress(address).then((value) => (){
      nimantrakData.mapLink = value;
      Debug.printLog("address map link==>> $address  $value  ${nimantrakData.mapLink}");
    });
    // nimantrakData.mapLink = "https://goo.gl/maps/K2Sg5DtFbSMJ8YgQ6";
    createData.marriageInvitationCard!.inviter = nimantrakData;
    /*End For Nimantrak Data*/


    /*Start For Function Data*/
    for(int i = 0; i < functionsList.length ; i++){
      var functionsClass = Functions();
      functionsClass.functionId = functionsList[i].functionId;
      functionsClass.functionName = functionsList[i].functionName;
      List<String> nameList = [];
      for(int j =0;j < functionsList[i].listNames.length ; j++){
        var title = functionsList[i].listNames[j].selectedTitle;
        var name = functionsList[i].listNames[j].nimantrakName;
        nameList.add("$title $name");
      }
      functionsClass.inviter = nameList;
      // functionsClass.inviter = (functionsList[i].listNames.toString() != "")?functionsList[i].listNames:[];
      functionsClass.functionTime = functionsList[i].functionTime;
      functionsClass.functionDate = functionsList[i].functionDate;
      functionsClass.functionPlace = functionsList[i].functionPlace;
      functionsClass.message = functionsList[i].functionMessage;
      functionsClass.banquetPerson = "";
      /*if(functionsClass.functionTime != "" && functionsClass.functionDate != "") {
        createData.marriageInvitationCard!.functions!.add(functionsClass);
      }*/
      createData.marriageInvitationCard!.functions!.add(functionsClass);
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
      groomInviterValues.motherName = "$dropDownGroomMotherName ${groomMotherNameController.text}";
    }
    if(chirpingInfoGroom.values!.fatherName != null) {
      groomInviterValues.fatherName = "$dropDownGroomFatherName ${groomFatherNameController.text}";
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
      brideInviterValues.motherName = "$dropDownBrideMotherName ${brideMotherNameController.text}";
    }
    if(chirpingInfoBride.values!.fatherName != null) {
      brideInviterValues.fatherName = "$dropDownBrideFatherName ${brideFatherNameController.text}";
    }
    if(chirpingInfoBride.values!.hometownName != null) {
      brideInviterValues.hometownName = brideVillageNameController.text;
    }
    if(chirpingInfoBride.values!.godName != null) {
      brideInviterValues.godName = brideGodController.text;
    }

    invitation.brideInviter = brideData;
    invitation.brideInviter!.values = brideInviterValues;
    invitation.guestName = "";
    createData.marriageInvitationCard!.invitation = invitation;
    /*End For Amantrak*/

    /*====================================================================================*/

    /*Start For Guest All Names Data*/
    var allNamesData = Affectionate();
    var firstList = guestNamesList
        .where((element) => element.titleName == "txtAapneAavkarvaAatur".tr)
        .toList();
    List<String> firstNameList = [];
    for (int j = 0; j < firstList[0].listOfGuestNames.length; j++) {
      var title = firstList[0].listOfGuestNames[j].selectedTitle;
      var name = firstList[0].listOfGuestNames[j].nimantrakName;
      firstNameList.add("$title $name");
    }
    allNamesData.list = firstNameList;
    allNamesData.title = firstList[0].titleName;
    createData.marriageInvitationCard!.affectionate = allNamesData;

    allNamesData = Affectionate();
    var secondList = guestNamesList.where((element) => element.titleName == "txtSanehaDhin".tr).toList();
    List<String> secondNameList = [];
    for (int j = 0; j < secondList[0].listOfGuestNames.length; j++) {
      var title = secondList[0].listOfGuestNames[j].selectedTitle;
      var name = secondList[0].listOfGuestNames[j].nimantrakName;
      secondNameList.add("$title $name");
    }
    allNamesData.list = secondNameList;
    allNamesData.title = secondList[0].titleName;
    createData.marriageInvitationCard!.ambitious = allNamesData;

    allNamesData = Affectionate();
    var thirdList = guestNamesList.where((element) => element.titleName == "txtMosalPaksh".tr).toList();
    List<String> thirdNameList = [];
    for (int j = 0; j < thirdList[0].listOfGuestNames.length; j++) {
      var title = thirdList[0].listOfGuestNames[j].selectedTitle;
      var name = thirdList[0].listOfGuestNames[j].nimantrakName;
      thirdNameList.add("$title $name");
    }
    allNamesData.list = thirdNameList;
    allNamesData.title = thirdList[0].titleName;
    createData.marriageInvitationCard!.nephewGroup = allNamesData;

    allNamesData = Affectionate();
    var fourthList = guestNamesList.where((element) => element.titleName == "txtBhanejPaksh".tr).toList();
    List<String> fourthNameList = [];
    for (int j = 0; j < fourthList[0].listOfGuestNames.length; j++) {
      var title = fourthList[0].listOfGuestNames[j].selectedTitle;
      var name = fourthList[0].listOfGuestNames[j].nimantrakName;
      fourthNameList.add("$title $name");
    }
    allNamesData.list = fourthNameList;
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
      goodPlace.inviterName = "${goodPlaceNamesList[i].selectedValue!} ${goodPlaceNamesList[i].inviterName}";
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
      callUploadCoverImageAPI(context);
    }
  }


  getAllInfo(BuildContext context) async {
      if (await InternetConnectivity.isInternetConnect()) {
        isShowProgress = true;
        update([Constant.isShowProgressUpload]);
        var mrgType = "";
        if(getAllInvitationCard.marriageInvitationCard != null){
          mrgType = (getAllInvitationCard.isGroom!)?Constant.typeGroomAPI:Constant.typeBrideAPI;
        }else{
          mrgType = (isGroomCard)?Constant.typeGroomAPI:Constant.typeBrideAPI;
        }
        Debug.printLog("getInfo mrgType==>> : $mrgType  $isGroomCard  ${getAllInvitationCard.isGroom}");

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

  callCreateUpdateCardAPI(BuildContext context, String isFromPreview) async {
    // if (validation(context)) {
      if (await InternetConnectivity.isInternetConnect()) {
        // Debug.printLog("Data ===>>> ${jsonEncode(createData)}");
        isShowProgress = true;
        update([Constant.isShowProgressUpload]);
        if(isFromAddUpdate == Constant.isFromUpdate || newCreatedCardId != ""){
          await newKankotriDataModel.updateKankotri(
              context, jsonEncode(createData), createData,createData.marriageInvitationCardId.toString()).then((value) {
            handleNewKankotriResponse(value, context,isFromPreview);
          });
          Debug.printLog("callCreateUpdateCardAPI===>>> From Update  $newCreatedCardId ");
        }else {
          await newKankotriDataModel.createKankotri(
              context, jsonEncode(createData), createData).then((value) {
            handleNewKankotriResponse(value, context,isFromPreview);
          });
          Debug.printLog("callCreateUpdateCardAPI===>>> From Create  $newCreatedCardId ");
        }
      } else {
        Utils.showToast(context, "txtNoInternet".tr);
      }
    // }
  }

  handleNewKankotriResponse(CreateKankotriData newKankotriData, BuildContext context, String isFromPreview) async {
    if (newKankotriData.status == Constant.responseSuccessCode) {
      if (newKankotriData.message != null) {
        Debug.printLog(
            "handleNewKankotriResponse Res Success ===>> ${newKankotriData.toJson().toString()}");
        // Utils.showToast(context,newKankotriData.message.toString());
        var functionList = createData.marriageInvitationCard!.functions!.where((element) => element.functionDate != "" && element.functionTime != "").toList();
        List<PreviewFunctions> functionStringTitleList = [];
        for(int i =0;i<functionList.length;i++){
          functionStringTitleList.add(PreviewFunctions(functionList[i].functionId, functionList[i].functionName ?? "",'txtSarvo'.tr));
        }
        if(isFromPreview == Constant.isFromSave) {
          Get.back();
        }else{
          createData.marriageInvitationCardId = newKankotriData.result![0].marriageInvitationCardId.toString();
          var data = await Get.toNamed(AppRoutes.preview, arguments: [
            createData,
            functionStringTitleList,
            newKankotriData.result![0].previewUrl.toString(),
            isFromScreen,
            isFromPreview,
            false
          ]);

          if(data != null){
            var map = data as Map;
            newCreatedCardId = map[Params.createdCardId];
            Debug.printLog("Data Map createdCardId==>> ${map[Params.createdCardId]}  $newCreatedCardId");
          }
        }

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

  callUploadCoverImageAPI(BuildContext context) async {
      if (await InternetConnectivity.isInternetConnect()) {
        if(imgFile != null) {
          newKankotriDataModel.file = imgFile;
          if(isFromAddUpdate == Constant.isFromUpdate){
            newKankotriDataModel.id = getAllInvitationCard.marriageInvitationCard!.coverImage!.id;
          }
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
        imgCoverId =  newKankotriData.result!.id ?? "";
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
    if(isFromScreen == Constant.isFromHomeScreen){
      return;
    }
    var mrgInvitationCard = getAllInvitationCard.marriageInvitationCard!;
    /*====================================================================================*/

    /*Image Cover URL*/
    imgCoverURL = mrgInvitationCard.coverImage!.url.toString() ?? "";
    imgCoverId = mrgInvitationCard.coverImage!.id.toString() ?? "";
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
      if(listNimantrakNameGet[i] != "") {
        var selectedTitle = listNimantrakNameGet[i].split(" ")[0];
        var name = listNimantrakNameGet[i].split(" ").sublist(1)
            .join(' ')
            .trim();
        var data = NimantrakModel();
        data.nimantrakName = name;
        data.selectedTitle = selectedTitle;
        data.otherTitleList = Utils.getOtherTitlesList();
        listNimantrakName.add(data);
        changeValueInListForNimantrak(i, Constant.typeNimantrakName, name);
      }else{
        var data = NimantrakModel();
        data.nimantrakName = "";
        data.selectedTitle = Utils.getDefaultSelectedTitle();
        data.otherTitleList = Utils.getOtherTitlesList();
        listNimantrakName.add(data);
        changeValueInListForNimantrak(i, Constant.typeNimantrakName, "");
      }
    }

    var listNimantrakMnoGet = mrgInvitationCard.inviter!.contactNo;
    for(int i =0; i<listNimantrakMnoGet!.length; i++){
      listNimantrakMno.add(listNimantrakMnoGet[i]);
      changeValueInListForNimantrak(i, Constant.typeNimantrakMobile, listNimantrakMnoGet[i]);
    }

    var listNimantrakAddressGet = mrgInvitationCard.inviter!.address;
    for(int i =0; i<listNimantrakAddressGet!.length; i++){
      listNimantrakAddress.add(listNimantrakAddressGet[i]);
      changeValueInListForNimantrak(i, Constant.typeNimantrakSarnamu, listNimantrakAddressGet[i]);
    }
    update([Constant.idAddNimantrakPart]);
    /*End For Nimantrak Data*/


    /*Start For Function Data*/
    var functionsListGet =  mrgInvitationCard.functions!;
    for(var i = 0 ; i < functionsListGet.length ; i ++){
      var functions = functionsListGet[i];
      List<NimantrakModel> listNameModel = [];

      for(var j = 0; j < functions.inviter!.length; j ++){
        if(functions.inviter![j] != ""){
          var selectedTitle = functionsListGet[i].inviter![j].split(" ")[0];
          var name = functionsListGet[i].inviter![j].split(" ").sublist(1)
              .join(' ')
              .trim();
          var data = NimantrakModel();
          data.nimantrakName = name;
          data.selectedTitle = selectedTitle;
          data.otherTitleList = Utils.getOtherTitlesList();
          listNameModel.add(data);
        }else{
          var data = NimantrakModel();
          data.nimantrakName = "";
          data.selectedTitle = Utils.getDefaultSelectedTitle();
          data.otherTitleList = Utils.getOtherTitlesList();
          listNameModel.add(data);
        }

      }
      functionsList.add(FunctionsNimantrakName(functions.functionId!, functions.functionName ?? "", listNameModel, functions.functionDate ?? "", functions.functionTime ?? "",
          functions.functionPlace ?? "", functions.message ?? "",[]));

      functionsPlaceListController.add(TextEditingController(text:functions.functionPlace ?? "" ));
      functionsMessageListController.add(TextEditingController(text:functions.message ?? ""));
      for(var j = 0; j < functions.inviter!.length; j ++){
        var name = functions.inviter![j].split(" ").sublist(1)
            .join(' ')
            .trim();
        functionsList[i].listEditTextNames.add(TextEditingController(text: name));
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
        dropDownGroomMotherName = groomAmantrak.values!.motherName!.split(" ")[0];
        groomMotherNameController.text = groomAmantrak.values!.motherName!.split(" ").sublist(1)
            .join(' ')
            .trim();
      }

      if(groomAmantrak.values!.fatherName != null) {
        dropDownGroomFatherName = groomAmantrak.values!.fatherName!.split(" ")[0];
        groomFatherNameController.text = groomAmantrak.values!.fatherName!.split(" ").sublist(1)
            .join(' ')
            .trim();
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
        dropDownBrideMotherName = brideAmantrak.values!.motherName!.split(" ")[0];
        brideMotherNameController.text = brideAmantrak.values!.motherName!.split(" ").sublist(1)
            .join(' ')
            .trim();
      }

      if(brideAmantrak.values!.fatherName != null) {
        dropDownBrideFatherName = brideAmantrak.values!.fatherName!.split(" ")[0];
        brideFatherNameController.text = brideAmantrak.values!.fatherName!.split(" ").sublist(1)
            .join(' ')
            .trim();
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
    List<NimantrakModel> firstListModel = [];
    if(allNamesDataGetFirst!.list!.isNotEmpty) {
      for (var i = 0; i < allNamesDataGetFirst.list!.length; i++) {
        if(allNamesDataGetFirst.list![i] != "") {
          var data = NimantrakModel();
          var selectedTitle = allNamesDataGetFirst.list![i].split(" ")[0];
          var name = allNamesDataGetFirst.list![i].split(" ").sublist(1)
              .join(' ')
              .trim();
          data.nimantrakName = name;
          data.otherTitleList = Utils.getOtherTitlesList();
          data.selectedTitle = selectedTitle;
          firstListModel.add(data);
          firstEditList.add(TextEditingController(text: name));
        }else{
          var data = NimantrakModel();
          data.nimantrakName = "";
          data.otherTitleList = Utils.getOtherTitlesList();
          data.selectedTitle = Utils.getDefaultSelectedTitle();
          firstListModel.add(data);
          firstEditList.add(TextEditingController(text: ""));
        }

      }
    }
    guestNamesList.add(GuestAllName(allNamesDataGetFirst.title!, firstListModel,firstEditList));


    var allNamesDataGetSecond = mrgInvitationCard.ambitious;
    List<TextEditingController> secondEditList = [];
    List<NimantrakModel> secondListModel = [];
    if(allNamesDataGetSecond!.list!.isNotEmpty) {
      for (var i = 0; i < allNamesDataGetSecond.list!.length; i++) {
        if(allNamesDataGetSecond.list![i] != "") {
          var data = NimantrakModel();
          var selectedTitle = allNamesDataGetSecond.list![i].split(" ")[0];
          var name = allNamesDataGetSecond.list![i].split(" ").sublist(1)
              .join(' ')
              .trim();
          data.nimantrakName = name;
          data.otherTitleList = Utils.getOtherTitlesList();
          data.selectedTitle = selectedTitle;
          secondListModel.add(data);
          secondEditList.add(TextEditingController(text: name));
        }else{
          var data = NimantrakModel();
          data.nimantrakName = "";
          data.otherTitleList = Utils.getOtherTitlesList();
          data.selectedTitle = Utils.getDefaultSelectedTitle();
          secondListModel.add(data);
          secondEditList.add(TextEditingController(text: ""));
        }

      }
    }
    guestNamesList.add(GuestAllName(allNamesDataGetSecond.title!, secondListModel,secondEditList));


    var allNamesDataGetThird = mrgInvitationCard.nephewGroup;
    List<TextEditingController> thirdEditList = [];
    List<NimantrakModel> thirdListModel = [];
    if(allNamesDataGetThird!.list!.isNotEmpty) {
      for (var i = 0; i < allNamesDataGetThird.list!.length; i++) {
        if(allNamesDataGetThird.list![i] != "") {
          var data = NimantrakModel();
          var selectedTitle = allNamesDataGetThird.list![i].split(" ")[0];
          var name = allNamesDataGetThird.list![i].split(" ").sublist(1)
              .join(' ')
              .trim();
          data.nimantrakName = name;
          data.otherTitleList = Utils.getOtherTitlesList();
          data.selectedTitle = selectedTitle;
          thirdListModel.add(data);
          thirdEditList.add(TextEditingController(text: name));
        }else{
          var data = NimantrakModel();
          data.nimantrakName = "";
          data.otherTitleList = Utils.getOtherTitlesList();
          data.selectedTitle = Utils.getDefaultSelectedTitle();
          thirdListModel.add(data);
          thirdEditList.add(TextEditingController(text: ""));
        }

      }
    }
    guestNamesList.add(GuestAllName(allNamesDataGetThird.title!, thirdListModel,thirdEditList));


    var allNamesDataGetFourth = mrgInvitationCard.uncleGroup;
    List<TextEditingController> fourthEditList = [];
    List<NimantrakModel> fourthListModel = [];
    if(allNamesDataGetFourth!.list!.isNotEmpty) {
      for (var i = 0; i < allNamesDataGetFourth.list!.length; i++) {
        if(allNamesDataGetFourth.list![i] != "") {
          var data = NimantrakModel();
          var selectedTitle = allNamesDataGetFourth.list![i].split(" ")[0];
          var name = allNamesDataGetFourth.list![i].split(" ").sublist(1)
              .join(' ')
              .trim();
          data.nimantrakName = name;
          data.otherTitleList = Utils.getOtherTitlesList();
          data.selectedTitle = selectedTitle;
          fourthListModel.add(data);
          fourthEditList.add(TextEditingController(text: name));
        }else{
          var data = NimantrakModel();
          data.nimantrakName = "";
          data.otherTitleList = Utils.getOtherTitlesList();
          data.selectedTitle = Utils.getDefaultSelectedTitle();
          fourthListModel.add(data);
          fourthEditList.add(TextEditingController(text: ""));
        }

      }
    }
    guestNamesList.add(GuestAllName(allNamesDataGetFourth.title!, fourthListModel,fourthEditList));


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
    if(goodPlace.inviterName != "") {
      var inviterTitleGoodPlace = goodPlace.inviterName!.split(" ")[0];
      var inviterNameGoodPlace = goodPlace.inviterName!.split(" ").sublist(1)
          .join(' ')
          .trim();
      goodPlaceNamesList.add(GoodPlaceAllName(
          goodPlace.title!,
          goodPlace.address!,
          goodPlace.contactNo!,
          inviterNameGoodPlace,
          firstAddressEditList,
          firstContactEditList,
          TextEditingController(text: inviterNameGoodPlace),
          inviterTitleGoodPlace));
    }else{
      goodPlaceNamesList.add(GoodPlaceAllName(
          goodPlace.title!,
          goodPlace.address!,
          goodPlace.contactNo!,
          "",
          firstAddressEditList,
          firstContactEditList,
          TextEditingController(text: ""),
          Utils.getDefaultSelectedTitle()));
    }


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
    if(goodMrgPlace.inviterName != "") {
      var inviterTitleGoodMrgPlace = goodMrgPlace.inviterName!.split(" ")[0];
      var inviterNameGoodMrgPlace = goodMrgPlace.inviterName!.split(" ")
          .sublist(1)
          .join(' ')
          .trim();
      goodPlaceNamesList.add(GoodPlaceAllName(
          goodMrgPlace.title!,
          goodMrgPlace.address!,
          goodMrgPlace.contactNo!,
          inviterNameGoodMrgPlace,
          secondAddressEditList,
          secondContactEditList,
          TextEditingController(text: inviterNameGoodMrgPlace),
          inviterTitleGoodMrgPlace));
    }else{
      goodPlaceNamesList.add(GoodPlaceAllName(
          goodMrgPlace.title!,
          goodMrgPlace.address!,
          goodMrgPlace.contactNo!,
          "",
          secondAddressEditList,
          secondContactEditList,
          TextEditingController(text: ""),
          Utils.getDefaultSelectedTitle()));
    }
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

  Future<String> getLocationFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    var mapLink =
        "https://www.google.com/maps/search/${locations[0].latitude},${locations[0].longitude}?shorturl=1";
    Debug.printLog("getLocationFromAddress==>> $locations  $mapLink");
    return mapLink;
  }

  void changeLayoutIdAndType(data) {
    if(data == ""){
      return;
    }

    var map = data as Map;
    newLayoutType = map[Constant.layoutType];
    newLayoutId = map[Constant.layoutId];
    Debug.printLog("Data Map==>> ${map[Constant.layoutId]}  ${map[Constant.layoutType]}  $newLayoutType   $newLayoutId");
  }




}

class FunctionsNimantrakName{
  String functionId = "";
  String functionName = "";
  String functionDate = "";
  String functionTime = "";
  String functionPlace = "";
  String functionMessage = "";
  // List<String> listNames = [];
  List<NimantrakModel> listNames = [];
  List<TextEditingController> listEditTextNames = [];

  FunctionsNimantrakName(this.functionId,this.functionName,this.listNames,this.functionDate,this.functionTime,this.functionPlace,this.functionMessage,this.listEditTextNames);
}

class GuestAllName{
  String titleName = "";
  // List<String> listOfGuestNames = [];
  List<NimantrakModel> listOfGuestNames = [];
  List<TextEditingController>? listOfGuestNamesController = [];

  GuestAllName(this.titleName,this.listOfGuestNames, this.listOfGuestNamesController);
}

class GoodPlaceAllName{
  String titleName = "";
  List<String> listOfAddressName = [];
  List<String> listOfMobile = [];
  String? inviterName;
  String? selectedValue;
  TextEditingController? inviterController;
  List<TextEditingController> listEditTextAddress = [];
  List<TextEditingController> listEditTextMobile = [];
  GoodPlaceAllName(this.titleName,this.listOfAddressName,this.listOfMobile,this.inviterName,this.listEditTextAddress,this.listEditTextMobile,this.inviterController,this.selectedValue);
}

class PreviewFunctions{
  String? fId = "";
  String? fName = "";
  String? fPerson = "";

  PreviewFunctions(this.fId,this.fName,this.fPerson);
}

class NimantrakModel{
  String selectedTitle = "";
  List<String> otherTitleList = [];
  String nimantrakName = "";
}
/*
class GodInformation{
  String godImageURL = "";
  String godName = "";
  bool? isSelected = false;

  GodInformation(this.godImageURL,this.godName,this.isSelected);
}*/
