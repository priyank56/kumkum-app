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

  TextEditingController functionDate = TextEditingController();
  TextEditingController functionTime = TextEditingController();
  TextEditingController functionPlace = TextEditingController();
  TextEditingController functionMessage = TextEditingController();
  List<TextEditingController> inviterList = [];

  @override
  void onInit() {
    super.onInit();
    addNimantrakNameListData(true);
    addNimantrakAddressListData(true);
    addNimantrakMnoListData(true);
    addAllFunctionsList();
    addChirpingList();
    addGuestNameFirsListData(true);

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

  addGuestNameFirsListData(bool isAdd, {int? index = 0}) {
    if (isAdd) {
      listOfGuestNameFirst.add("");
    } else {
      listOfGuestNameFirst.removeAt(index!);
    }
    update([Constant.idGuestNameFirst]);
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

   addChirpingList() {
     listOfChirping.add("1");
     listOfChirping.add("2");
     update([Constant.idInviterPart]);

   }
}

class FunctionsNimantrakName{
  String functionName = "";
  List<String> listNames = [];

  FunctionsNimantrakName(this.functionName,this.listNames);
}
