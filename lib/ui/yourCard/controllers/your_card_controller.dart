import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../utils/constant.dart';
import '../../../utils/debug.dart';
import '../../../utils/utils.dart';
import '../../addKankotri/datamodel/newKankotriData.dart';
import '../../addKankotri/datamodel/newkankotridatamodel.dart';

class YourCardsController extends GetxController {

  bool isShowProgress = false;
  NewKankotriDataModel newKankotriDataModel = NewKankotriDataModel();
  List<ResultGet> allYourCardList = [];

  @override
  void onInit() {
    super.onInit();
    getAllYourCardsAPI(Get.context!);
  }

  getAllYourCardsAPI(BuildContext context) async {
      if (await InternetConnectivity.isInternetConnect()) {
        isShowProgress = true;
        update([Constant.isShowProgressUpload]);
        await newKankotriDataModel.getAllInvitationCards(
            context).then((value) {
          handleGetAllMyKankotriResponse(value, context);
        });
      } else {
        Utils.showToast(context, "txtNoInternet".tr);
      }
  }

  handleGetAllMyKankotriResponse(NewKankotriData getAllKankotriData, BuildContext context) async {
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
          Utils.showToast(context,"msgLoginFail".tr);
        }
      }
    } else {
      if (getAllKankotriData.message != null && getAllKankotriData.message!.isNotEmpty) {
        Utils.showToast(context,getAllKankotriData.message!);
      } else {
        Utils.showToast(context,"msgLoginFail".tr);
      }
    }
    isShowProgress = false;
    update([Constant.isShowProgressUpload,Constant.idGetAllYourCards]);
  }

}

