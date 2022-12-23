import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../utils/constant.dart';
import '../../../utils/debug.dart';
import '../../../utils/utils.dart';
import '../../addKankotri/datamodel/newKankotriData.dart';
import '../../addKankotri/datamodel/newkankotridatamodel.dart';

class HomeController extends GetxController {

  bool isShowProgress = false;
  NewKankotriDataModel newKankotriDataModel = NewKankotriDataModel();
  List<ResultGet> allYourCardList = [];

  @override
  void onInit() {
    super.onInit();
    getAllPreBuiltCardsAPI(Get.context!);
    saveFileFromBufferData();
  }

  getAllPreBuiltCardsAPI(BuildContext context) async {
    if (await InternetConnectivity.isInternetConnect()) {
      isShowProgress = true;
      update([Constant.isShowProgressUpload,Constant.idMainPage]);
      await newKankotriDataModel.getAllPreBuiltCards(
          context).then((value) {
        handleGetAllMyKankotriResponse(value, context);
      });
    } else {
      Utils.showToast(context, "txtNoInternet".tr);
    }
  }

  handleGetAllMyKankotriResponse(NewKankotriData getAllKankotriData, BuildContext context) async {
    allYourCardList.clear();
    if (getAllKankotriData.status == Constant.responseSuccessCode) {
      if (getAllKankotriData.message != null) {
        Debug.printLog(
            "handleGetAllMyKankotriResponse Res Success ===>> ${getAllKankotriData.toJson().toString()}");
        allYourCardList = getAllKankotriData.result!;
      } else {
        Debug.printLog(
            "handleGetAllMyKankotriResponse Res Fail ===>> ${getAllKankotriData.toJson().toString()}");
        if (getAllKankotriData.message != null && getAllKankotriData.message!.isNotEmpty) {
          Utils.showToast(context,getAllKankotriData.message!);
        } else {
          Utils.showToast(context,"txtSomethingWentWrong".tr);
        }
      }
    } else {
      if (getAllKankotriData.message != null && getAllKankotriData.message!.isNotEmpty) {
        Utils.showToast(context,getAllKankotriData.message!);
      } else {
        Utils.showToast(context,"txtSomethingWentWrong".tr);
      }
    }
    isShowProgress = false;
    update([Constant.isShowProgressUpload,Constant.idMainPage]);
  }

  saveFileFromBufferData() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/card.pdf');
    await file.writeAsBytes([]);
  }



}

