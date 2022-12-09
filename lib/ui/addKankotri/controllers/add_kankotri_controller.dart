import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/utils/debug.dart';

import '../../../utils/constant.dart';

class AddKankotriController extends GetxController {
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      String convertedDateTime =
          "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      Debug.printLog("convertedDateTime==>> $convertedDateTime");
    }
  }

  Future<void> selectTime(BuildContext context) async {
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
      Debug.printLog("picked == >>> Time ${picked.hour}  ${picked.minute}");
    }
  }


  List<String> listNimantrakName = [];
  List<String> listNimantrakAddress = [];
  List<String> listNimantrakMno = [];
  List<String> listOfChirping = [];
  List<String> listOfGuestNameFirst = [];
  List<FunctionsNimantrakName> functionsList = [];
  List<GuestAllName> guestNamesList = [];
  List<GoodPlaceAllName> goodPlaceNamesList = [];
  List<GodInformation> godInformationList = [];

  TextEditingController functionDate = TextEditingController();
  TextEditingController functionTime = TextEditingController();
  TextEditingController functionPlace = TextEditingController();
  TextEditingController functionMessage = TextEditingController();
  List<TextEditingController> inviterList = [];

  String newGodName = "";

  /*Edittext Controller*/
  TextEditingController godNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    addNimantrakNameListData(true);
    addNimantrakAddressListData(true);
    addNimantrakMnoListData(true);
    addAllFunctionsList();
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
    functionsList.add(FunctionsNimantrakName("txtMadapMuhrat".tr,["",""]));
    functionsList.add(FunctionsNimantrakName("txtBhojan".tr,["",""]));
    functionsList.add(FunctionsNimantrakName("txtGitSandhya".tr,["",""]));
    functionsList.add(FunctionsNimantrakName("txtRasGarba".tr,["",""]));
    functionsList.add(FunctionsNimantrakName("txtJan".tr,["",""]));
    functionsList.add(FunctionsNimantrakName("txtHastMelap".tr,["",""]));
    update([Constant.idFunctionsPart]);
  }


  addAllGuestNames() {
    guestNamesList.add(GuestAllName("txtAapneAavkarvaAatur".tr,["",""]));
    guestNamesList.add(GuestAllName("txtSanehaDhin".tr,["",""]));
    guestNamesList.add(GuestAllName("txtMosalPaksh".tr,["",""]));
    guestNamesList.add(GuestAllName("txtBhanejPaksh".tr,["",""]));
    update([Constant.idGuestNameAll]);
  }

  addRemoveGuestNamesName(bool isAdd,int mainIndex,{int? index = 0}){
    if (isAdd) {
      guestNamesList[mainIndex].listOfGuestNames.add("");
    } else {
      guestNamesList[mainIndex].listOfGuestNames.removeAt(index!);
    }
    update([Constant.idFunctionsPart]);
  }


  addGoodPlaceNames() {
    goodPlaceNamesList.add(GoodPlaceAllName("txtSubhSathal".tr,["",""],["",""]));
    goodPlaceNamesList.add(GoodPlaceAllName("txtSubhLaganSathal".tr,["",""],["",""]));
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

  addChirpingList() {
     listOfChirping.add("1");
     listOfChirping.add("2");
     update([Constant.idInviterPart]);

   }

   changeGodName(String name){
     newGodName = name;
     update([Constant.idGodNames]);
   }
}

class FunctionsNimantrakName{
  String functionName = "";
  List<String> listNames = [];

  FunctionsNimantrakName(this.functionName,this.listNames);
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

  GoodPlaceAllName(this.titleName,this.listOfAddressName,this.listOfMobile);
}

class GodInformation{
  String godImageURL = "";
  String godName = "";
  bool? isSelected = false;

  GodInformation(this.godImageURL,this.godName,this.isSelected);
}