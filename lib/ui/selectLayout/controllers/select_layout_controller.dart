import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/selectLayout/datamodel/layoutdesigndatamodel.dart';
import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../utils/constant.dart';
import '../../../utils/debug.dart';
import '../../../utils/utils.dart';
import '../../addKankotri/datamodel/newKankotriData.dart';
import '../../addKankotri/datamodel/newkankotridatamodel.dart';
import '../datamodel/layoutDesignData.dart';

class SelectLayoutController extends GetxController {
  bool isShowProgress = false;
  LayoutDesignDataModel layoutDesignDataModel = LayoutDesignDataModel();
  List<ResultLayout> layoutDesignList = [];

  @override
  void onInit() {
    super.onInit();
    getAllLayoutDesignAPI(Get.context!);
  }

  getAllLayoutDesignAPI(BuildContext context) async {
    if (await InternetConnectivity.isInternetConnect()) {
      isShowProgress = true;
      update([Constant.isShowProgressUpload,Constant.idGetAllYourCards]);
      await layoutDesignDataModel.getLayoutDesign(
          context).then((value) {
        handleGetLayoutDesignResponse(value, context);
      });
    } else {
      Utils.showToast(context, "txtNoInternet".tr);
    }
  }

  handleGetLayoutDesignResponse(LayoutDesignData layoutDesignData, BuildContext context) async {
    layoutDesignList.clear();
    if (layoutDesignData.status == Constant.responseSuccessCode) {
      if (layoutDesignData.message != null) {
        Debug.printLog(
            "handleGetLayoutDesignResponse Res Success ===>> ${layoutDesignData.toJson().toString()}");
        layoutDesignList = layoutDesignData.result!;
      } else {
        Debug.printLog(
            "handleGetLayoutDesignResponse Res Fail ===>> ${layoutDesignData.toJson().toString()}");
        if (layoutDesignData.message != null && layoutDesignData.message!.isNotEmpty) {
          Utils.showToast(context,layoutDesignData.message!);
        } else {
          Utils.showToast(context,"txtSomethingWentWrong".tr);
        }
      }
    } else {
      if (layoutDesignData.message != null && layoutDesignData.message!.isNotEmpty) {
        Utils.showToast(context,layoutDesignData.message!);
      } else {
        Utils.showToast(context,"txtSomethingWentWrong".tr);
      }
    }
    isShowProgress = false;
    update([Constant.isShowProgressUpload,Constant.idGetAllYourCards]);
  }

}


