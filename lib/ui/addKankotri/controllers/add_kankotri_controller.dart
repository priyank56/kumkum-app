import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/newkankotridatamodel.dart';
import 'package:spotify_flutter_code/utils/debug.dart';

import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../datamodel/newKankotriData.dart';

class AddKankotriController extends GetxController {

  bool isShowProgress = false;
  NewKankotriDataModel newKankotriDataModel = NewKankotriDataModel();

  CreateData createData = CreateData();

  List<String> listNimantrakName = [];
  List<String> listNimantrakAddress = [];
  List<String> listNimantrakMno = [];
  List<String> listOfChirping = [];
  List<String> listOfMessagesFromBride = [];
  List<String> listOfMessagesFromGroom = [];
  List<String> listOfGuestNameFirst = [];
  List<FunctionsNimantrakName> functionsList = [];
  List<GuestAllName> guestNamesList = [];
  List<GoodPlaceAllName> goodPlaceNamesList = [];
  List<GodInformation> godInformationList = [];
  List<GodInformation> selectedGodList = [];

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
  TextEditingController brideMarriageDateController = TextEditingController();
  String dropDownFromBrideMessage = "";



  /*Drop Down Messages*/
  String dropDownTahukoMessage = "";


  /*Atak*/
  TextEditingController atakController = TextEditingController();

  /*Edittext Controller*/
  TextEditingController godNameController = TextEditingController();



  Future<void> selectDate(BuildContext context,{int index = -1}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      String convertedDateTime =
          "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      Debug.printLog("convertedDateTime==>> $convertedDateTime $mrgDateDay $mrgDateGujarati $index");
      if(index != -1){
        var date = DateFormat("yyyy-MM-dd","gu").format(picked);
        functionsList[functionsList.indexOf(functionsList[index])].functionDate = date.toString();
      }else{
        mrgDate = convertedDateTime.toString();
        mrgDateGujarati = DateFormat("yyyy-MM-dd","gu").format(picked);
        mrgDateDay = DateFormat("EEEE","gu").format(picked);
      }

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
      Debug.printLog("picked == >>> Time ${picked.hour}:${picked.minute}  ${functionsList[index].functionTime}  $date");

    }
    update([Constant.idFunctionsPart]);
  }


  @override
  void onInit() {
    super.onInit();
    addNimantrakNameListData(true);
    addNimantrakAddressListData(true);
    addNimantrakMnoListData(true);
    addAllFunctionsList();
    addInviterMessage();
    addChirpingList();
    addAllGuestNames();
    addGoodPlaceNames();
    addGodInfo();

  }

  addNimantrakNameListData(bool isAdd, {int? index = 0}) {
    if (isAdd) {
      listNimantrakName.add("");
    } else {
      listNimantrakName.removeAt(index!);
    }
    update([Constant.idAddNimantrakPart]);
  }

  addNimantrakAddressListData(bool isAdd, {int? index = 0}) {
    if (isAdd) {
      listNimantrakAddress.add("");
    } else {
      listNimantrakAddress.removeAt(index!);
    }
    update([Constant.idAddNimantrakPart]);
  }

  addNimantrakMnoListData(bool isAdd, {int? index = 0}) {
    if (isAdd) {
      listNimantrakMno.add("");
    } else {
      listNimantrakMno.removeAt(index!);
    }
    update([Constant.idAddNimantrakPart]);
  }

  addRemoveFunctionsNimantrakName(bool isAdd,int mainIndex,{int? index = 0}){
    if (isAdd) {
      functionsList[mainIndex].listNames.add("");
    } else {
      functionsList[mainIndex].listNames.removeAt(index!);
    }
    update([Constant.idFunctionsPart]);
  }

  addAllFunctionsList() {
    functionsList.add(FunctionsNimantrakName("txtMadapMuhrat".tr,[""],"","","",""));
    functionsList.add(FunctionsNimantrakName("txtBhojan".tr,[""],"","","",""));
    functionsList.add(FunctionsNimantrakName("txtGitSandhya".tr,[""],"","","",""));
    functionsList.add(FunctionsNimantrakName("txtRasGarba".tr,[""],"","","",""));
    functionsList.add(FunctionsNimantrakName("txtJan".tr,[""],"","","",""));
    functionsList.add(FunctionsNimantrakName("txtHastMelap".tr,[""],"","","",""));
    update([Constant.idFunctionsPart]);
  }


  addAllGuestNames() {
    guestNamesList.add(GuestAllName("txtAapneAavkarvaAatur".tr,[""]));
    guestNamesList.add(GuestAllName("txtSanehaDhin".tr,[""]));
    guestNamesList.add(GuestAllName("txtMosalPaksh".tr,[""]));
    guestNamesList.add(GuestAllName("txtBhanejPaksh".tr,[""]));
    update([Constant.idGuestNameAll]);
  }

  addRemoveGuestNamesName(bool isAdd,int mainIndex,{int? index = 0}){
    if (isAdd) {
      guestNamesList[mainIndex].listOfGuestNames.add("");
    } else {
      guestNamesList[mainIndex].listOfGuestNames.removeAt(index!);
    }
    update([Constant.idGuestNameAll]);
  }


  addGoodPlaceNames() {
    goodPlaceNamesList.add(GoodPlaceAllName("txtSubhSathal".tr,[""],[""],""));
    goodPlaceNamesList.add(GoodPlaceAllName("txtSubhLaganSathal".tr,[""],[""],""));
    update([Constant.idGoodPlaceAll]);
  }

  addRemoveGoodPlaceNamesName(bool isAdd,int mainIndex,bool isAddress,{int? index = 0}){
    if(isAddress) {
      if (isAdd) {
        goodPlaceNamesList[mainIndex].listOfAddressName.add("");
      } else {
        goodPlaceNamesList[mainIndex].listOfAddressName.removeAt(index!);
      }
    }else {
      if (isAdd) {
        goodPlaceNamesList[mainIndex].listOfMobile.add("");
      } else {
        goodPlaceNamesList[mainIndex].listOfMobile.removeAt(index!);
      }
    }
    update([Constant.idGoodPlaceAll]);
  }

  addGodInfo(){
    godInformationList.add(GodInformation(Constant.godDemoImageURl, "શ્રી ગણેશાય નમઃ",false));
    godInformationList.add(GodInformation(Constant.godDemoImageURl, "શ્રી ગેલ અંબે માતાજી",false));
    godInformationList.add(GodInformation(Constant.godDemoImageURl, "ૐ નમઃ શિવાય",false));
  }

  addRemoveGodNamesName(bool isAdd, int index,String name){
    if(name == ""){
      return;
    }
    if (isAdd) {
      godInformationList.add(GodInformation("", name,false));
    } else {
      godInformationList.removeAt(index);
    }
    update([Constant.idGodNames]);
  }

  godSelectOnTap(int index){
    godInformationList[index].isSelected = !godInformationList[index].isSelected!;
    update([Constant.idGodNames]);
  }

  addInviterMessage() {
    listOfMessagesFromGroom.add("Messages Groom 1");
    listOfMessagesFromGroom.add("Messages Groom 2");
    dropDownFromGroomMessage = listOfMessagesFromGroom[0];

    listOfMessagesFromBride.add("Messages Bride 1");
    listOfMessagesFromBride.add("Messages Bride 2");
    dropDownFromBrideMessage = listOfMessagesFromBride[0];

    update([Constant.idInviterPart]);
   }

   addChirpingList() {
     listOfChirping.add("Tahuko 1");
     listOfChirping.add("Tahuko 2");
     dropDownTahukoMessage = listOfChirping[0];
     update([Constant.idTahukoPart]);

   }

   changeGodName(String name){
     newGodName = name;
     update([Constant.idGodNames]);
   }

   /* Replace Value In List */


  changeValueInListForNimantrak(int index,String type,dynamic value) {
    if(type == Constant.typeNimantrakName){
      listNimantrakName[listNimantrakName.indexOf(listNimantrakName[index])] = value;
    }else if(type == Constant.typeNimantrakSarnamu){
      listNimantrakAddress[listNimantrakAddress.indexOf(listNimantrakAddress[index])] = value;
    }else if(type == Constant.typeNimantrakMobile){
      listNimantrakMno[listNimantrakMno.indexOf(listNimantrakMno[index])] = value;
    }
    update([Constant.idAddNimantrakPart]);
  }

  changeValueInListForFunctions(int index,String type,dynamic value) {
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

  changeValueInListForFunctionsNimantrakName(int index,int mainIndex,dynamic value) {
    functionsList[mainIndex].listNames[functionsList[mainIndex].listNames.indexOf(functionsList[mainIndex].listNames[index])] = value;
    update([Constant.idFunctionsPart]);
  }

  changeValueInListForGuestAllNames(int index,int mainIndex,dynamic value) {
    guestNamesList[mainIndex].listOfGuestNames[guestNamesList[mainIndex].listOfGuestNames.indexOf(guestNamesList[mainIndex].listOfGuestNames[index])] = value;
    update([Constant.idGuestNameAll]);
  }

  changeValueInListForGoodPlaceAmantrakName(int mainIndex,dynamic value) {
    goodPlaceNamesList[mainIndex].inviterName = value;
    update([Constant.idGoodPlaceAll]);
  }

  changeDropDownValueForGroomBride(dynamic value,String type){
    if(type == Constant.typeGroom){
      dropDownFromGroomMessage = value;
    }else{
      dropDownFromBrideMessage = value;
    }

    update([Constant.idInviterPart]);
  }

  changeDropDownValueForTahuko(dynamic value){
    dropDownTahukoMessage = value;
    update([Constant.idInviterPart]);
  }
  changeValueInListForGoodPlace(int index,int mainIndex,String type,dynamic value) {
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

  getAllValue(){
    Debug.printLog("Get All Value==>>> $listNimantrakName  $listNimantrakAddress  $listNimantrakMno");
    for(int i = 0; i < functionsList.length ; i++){
      Debug.printLog("Get All Value Functions==>>> ${functionsList[i].listNames}  ${functionsList[i].functionDate}  ${functionsList[i].functionTime}  ${functionsList[i].functionPlace}  ${functionsList[i].functionMessage}");
    }

    for(int i = 0; i < guestNamesList.length ; i++){
      Debug.printLog("Get All Value guestNamesList==>>> ${guestNamesList[i].listOfGuestNames} ${guestNamesList[i].titleName}");
    }

    for(int i = 0; i < goodPlaceNamesList.length ; i++){
      Debug.printLog("Get All Value goodPlaceNamesList==>>> ${goodPlaceNamesList[i].listOfAddressName} ${goodPlaceNamesList[i].listOfMobile} ${goodPlaceNamesList[i].titleName}");
    }

    selectedGodList = godInformationList.where((element) => element.isSelected == true).toList();

    for(int i = 0; i < selectedGodList.length ; i++){
      Debug.printLog("Get All Value selectedGodList==>>> ${selectedGodList[i].godImageURL} ${selectedGodList[i].godName}");
    }

    Debug.printLog("Get All Value atak==>>> ${atakController.text}");
    Debug.printLog("Get All Value tahukoMessage==>>> $dropDownTahukoMessage  $dropDownFromGroomMessage  $dropDownFromBrideMessage");

    /*====================================================================================*/

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
    createData.email = "email.com";
    createData.layoutDesignId = "3409e5aac99c";
    createData.marriageInvitationCardId = "2f61ff54";
    createData.marriageInvitationCardName = "from app";
    createData.marriageInvitationCardType = "mict1";

    var coverImage = CoverImage();
    coverImage.isShow = true;
    coverImage.url = Constant.godDemoImageURl.toString();
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
      functionsClass.inviter = functionsList[i].listNames;
      functionsClass.functionTime = functionsList[i].functionTime;
      functionsClass.functionDate = functionsList[i].functionDate;
      functionsClass.functionPlace = functionsList[i].functionPlace;
      functionsClass.message = functionsList[i].functionMessage;
      createData.marriageInvitationCard!.functions!.add(functionsClass);
    }
    /*End For Function Data*/

    /*====================================================================================*/

    /*Start For Amantrak*/
    var invitation = Invitation();

    var groomData = GroomInviter();
    groomData.value = dropDownFromGroomMessage;
    var groomInviterValues= GroomInviterValues();
    groomInviterValues.godName = groomGodNameController.text;
    groomInviterValues.motherName = groomMotherNameController.text;
    groomInviterValues.fatherName = groomFatherNameController.text;
    groomInviterValues.hometownName = groomVillageNameController.text;
    invitation.groomInviter = groomData;
    invitation.groomInviter!.values = groomInviterValues;

    var brideData = BrideInviter();
    brideData.value = dropDownFromBrideMessage;
    var brideInviterValues= BrideInviterValues();
    brideInviterValues.day = mrgDateDay;
    brideInviterValues.date = mrgDateGujarati;
    brideInviterValues.motherName = brideMotherNameController.text;
    brideInviterValues.fatherName = brideFatherNameController.text;
    brideInviterValues.hometownName = brideVillageNameController.text;
    invitation.brideInviter = brideData;
    invitation.brideInviter!.values = brideInviterValues;

    createData.marriageInvitationCard!.invitation = invitation;
    /*End For Amantrak*/

    /*====================================================================================*/

    /*Start For Guest All Names Data*/
    var allNamesData = Affectionate();
    var firstList = guestNamesList.where((element) => element.titleName == "txtAapneAavkarvaAatur".tr).toList();
    allNamesData.list = firstList[0].listOfGuestNames;
    allNamesData.title = firstList[0].titleName;
    createData.marriageInvitationCard!.affectionate = allNamesData;

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

    var godDetail = GodDetail();
    godDetail.id = "f8753460";
    createData.marriageInvitationCard!.godDetails!.add(godDetail);

    /*End For God's Data*/

    Debug.printLog("MarriageInvitationCard==>> ${createData.toJson().toString()}");

  }


  File? imgFile;
  final imgPicker = ImagePicker();
  void selectImage(String type) async {
    PickedFile? img = PickedFile("");
    if(type == Constant.typeCamera){
      img = await imgPicker.getImage(source: ImageSource.camera);
    }else{
      img =  await imgPicker.getImage(source: ImageSource.gallery);
    }
    imgFile = File(img!.path);
    Debug.printLog("Image FIle==>>> $imgFile  ${img.path}");
    update([Constant.idSetMainImage]);
  }


  callCreateCardAPI(BuildContext context) async {
    if (await InternetConnectivity.isInternetConnect()) {
      isShowProgress = true;
      update([Constant.isShowProgressUpload]);
      await newKankotriDataModel.createKankotri(context,createData).then((value) {
        handleNewKankotriResponse(value, context);
      });
    }else {
      Utils.showToast(context, "txtNoInternet".tr);
    }
  }

  handleNewKankotriResponse(NewKankotriData newKankotriData, BuildContext context) async {
    if (newKankotriData.status == Constant.responseSuccessCode) {
      if (newKankotriData.message != null) {
        Debug.printLog(
            "handleNewKankotriResponse Res Success ===>> ${newKankotriData.toJson().toString()}");
        Utils.showToast(context,newKankotriData.message.toString());
      } else {
        Debug.printLog(
            "handleNewKankotriResponse Res Fail ===>> ${newKankotriData.toJson().toString()}");

        if (newKankotriData.message != null && newKankotriData.message!.isNotEmpty) {
          Utils.showToast(context,newKankotriData.message!);
        } else {
          Utils.showToast(context,"msgLoginFail".tr);
        }
      }
    } else {
      if (newKankotriData.message != null && newKankotriData.message!.isNotEmpty) {
        Utils.showToast(context,newKankotriData.message!);
      } else {
        Utils.showToast(context,"msgLoginFail".tr);
      }
    }
    isShowProgress = false;
    update([Constant.isShowProgressUpload]);
  }

}

class FunctionsNimantrakName{
  String functionName = "";
  String functionDate = "";
  String functionTime = "";
  String functionPlace = "";
  String functionMessage = "";
  List<String> listNames = [];

  FunctionsNimantrakName(this.functionName,this.listNames,this.functionDate,this.functionTime,this.functionPlace,this.functionMessage);
}

class GuestAllName{
  String titleName = "";
  List<String> listOfGuestNames = [];

  GuestAllName(this.titleName,this.listOfGuestNames);
}

class GoodPlaceAllName{
  String titleName = "";
  List<String> listOfAddressName = [];
  List<String> listOfMobile = [];
  String? inviterName;
  GoodPlaceAllName(this.titleName,this.listOfAddressName,this.listOfMobile,this.inviterName);
}

class GodInformation{
  String godImageURL = "";
  String godName = "";
  bool? isSelected = false;

  GodInformation(this.godImageURL,this.godName,this.isSelected);
}