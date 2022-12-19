import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import 'package:contacts_service/contacts_service.dart';

import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../utils/utils.dart';
import '../../addKankotri/datamodel/newKankotriData.dart';
import '../../addKankotri/datamodel/newkankotridatamodel.dart';

class ContactController extends GetxController {

  int currentPos = 1;
  String selectedSendWp = Constant.selectedSendWpSarvo;
  bool isCheck = false;
  List<AllContact> contactList = [];
  List<AllContact> contactListSarvo = [];
  List<AllContact> contactListSajode = [];
  List<AllContact> contactList1Person = [];

  bool isShowProgress = false;
  NewKankotriDataModel newKankotriDataModel = NewKankotriDataModel();
  List<ResultGet> allYourCardList = [];
  var auth = FirebaseAuth.instance;


  @override
  void onInit() {
    super.onInit();
    getAllYourCardsAPI(Get.context!);
  }

  getAllYourCardsAPI(BuildContext context) async {
    if (await InternetConnectivity.isInternetConnect()) {
      isShowProgress = true;
      update([Constant.isShowProgressUpload,Constant.idMainPage,Constant.idBottomText,Constant.idNextPrevious,Constant.idBottomViewPos]);
      await newKankotriDataModel.getAllInvitationCards(
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
    update([Constant.isShowProgressUpload,Constant.idBottomViewPos,Constant.idMainPage]);
  }



  changeBottomViewPos(int pos)async{
    currentPos = pos;
    if(pos == 2){
      if (await Permission.contacts.request().isGranted) {
        getAllContact();
      } else if (await Permission.contacts.request().isPermanentlyDenied) {
        await openAppSettings();
      }else if (await Permission.contacts.request().isDenied) {
        Get.back();
      }
    }
    update([Constant.idNextPrevious,Constant.idBottomText,Constant.idBottomViewPos,Constant.idMainPage,]);
  }

  changeSendOption(String value){
    selectedSendWp = value;
    if(selectedSendWp == Constant.selectedSendWpSarvo){
      contactListSarvo = contactList.where((element) => element.sendType != Constant.selectedSendWp1Person && element.sendType != Constant.selectedSendWpSajode).toList();
    }else if(selectedSendWp == Constant.selectedSendWpSajode){
      contactListSajode = contactList.where((element) => element.sendType != Constant.selectedSendWpSarvo && element.sendType != Constant.selectedSendWp1Person).toList();
    }else if(selectedSendWp == Constant.selectedSendWp1Person){
      contactList1Person = contactList.where((element) => element.sendType != Constant.selectedSendWpSarvo && element.sendType != Constant.selectedSendWpSajode).toList();
    }
    update([Constant.idBottomViewPos,Constant.idContactList]);
  }

  changeCheckValue(bool value,int index, String selectedType){
    if(selectedType == Constant.selectedSendWpSarvo){
      contactListSarvo[index].isSelected = !contactListSarvo[index].isSelected;
      if(!contactListSarvo[index].isSelected){
        contactListSarvo[index].sendType = "";
      }else{
        contactListSarvo[index].sendType = selectedType;
      }
    }else if(selectedType == Constant.selectedSendWpSajode){
      contactListSajode[index].isSelected = !contactListSajode[index].isSelected;
      if(!contactListSajode[index].isSelected){
        contactListSajode[index].sendType = "";
      }else{
        contactListSajode[index].sendType = selectedType;
      }
    }else if(selectedType == Constant.selectedSendWp1Person){
      contactList1Person[index].isSelected = !contactList1Person[index].isSelected;
      if(!contactList1Person[index].isSelected){
        contactList1Person[index].sendType = "";
      }else{
        contactList1Person[index].sendType = selectedType;
      }

    }
    update([Constant.idBottomViewPos,Constant.idMainPage]);
  }

  Future<void> getAllContact()async{
    if(contactList.isNotEmpty){
      return;
    }
    List<Contact> contacts = await ContactsService.getContacts();
    for(int i=0;i<contacts.length;i++){
      var contactNumber = contacts[i].phones![0].value;
      var contactName = contacts[i].displayName;
      var sendType = "";
      var isSelected = false;
      Debug.printLog("Contacts===>> ${contacts[i].phones![0].value}  ${contacts[i].displayName}");
      contactList.add(AllContact(contactNumber!,contactName!,sendType,isSelected));
      changeSendOption(Constant.selectedSendWpSarvo);
      update([Constant.idBottomViewPos]);
    }
    Debug.printLog("contacts=>>> Sizes   ${contacts.length}");
  }
}

class AllContact{
  String contactNumber = "";
  String contactName = "";
  String sendType = Constant.selectedSendWpSarvo;
  bool isSelected = false;

  AllContact(this.contactNumber,this.contactName,this.sendType,this.isSelected);
}

