import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/numbersData.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as update_contact;
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
  
  List<AllContact> getAllContactBackend = [];

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
    }else if(pos == 3){
      getAllSelectedGuestNames();
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
      var contactNumber = int.parse(contacts[i].phones![0].value!.replaceAll("+", ""));
      var contactName = contacts[i].displayName;
      var sendType = "";
      var isSelected = false;
      Debug.printLog("Contacts===>> ${contacts[i].phones![0].value}  ${contacts[i].displayName}");

      contactList.add(AllContact(contactNumber,contactName!,sendType,isSelected,TextEditingController(text:contactName )));
      getAllDummyContactListBackend();
      changeSendOption(Constant.selectedSendWpSarvo);
      update([Constant.idBottomViewPos]);
    }
    Debug.printLog("contacts=>>> Sizes   ${contacts.length}");
  }

  TextEditingController nameContactController = TextEditingController();
  TextEditingController numberContactController = TextEditingController();

  addContact(String name,String number) async {
    var numberInt = int.parse(number.replaceAll("+", ""));
    Debug.printLog("addContact==>> $name  $numberInt");
    contactList.insert(0, AllContact(numberInt, name, "", false, TextEditingController(text: name)));
    contactListSarvo.insert(0, AllContact(numberInt, name, "", false, TextEditingController(text: name)));
    contactList1Person.insert(0, AllContact(numberInt, name, "", false, TextEditingController(text: name)));
    contactList1Person.insert(0, AllContact(numberInt, name, "", false, TextEditingController(text: name)));
    /*For Add Contact contacts_service */
    Contact contacts = Contact();
    contacts.givenName = name;
    contacts.phones = [
      Item(label: "mobile", value: number)
    ];
    await ContactsService.addContact(contacts);
    Get.back();
    update([Constant.idBottomViewPos,Constant.idContactList]);
  }

  updateContactName(int index,String type,BuildContext context) async {
    List<update_contact.Contact> updateContact = await update_contact.FlutterContacts.getContacts(withProperties: true, withPhoto: true,withAccounts: true);

    (type == Constant.selectedSendWpSarvo)
        ? contactListSarvo[index].contactName = contactListSarvo[index].controller.text
        : (type == Constant.selectedSendWpSajode)
        ? contactListSajode[index].contactName = contactListSajode[index].controller.text
        : contactList1Person[index].contactName = contactList1Person[index].controller.text;
    var updatedName = (type == Constant.selectedSendWpSarvo)
        ? contactListSarvo[index].contactName
        : (type == Constant.selectedSendWpSajode)
        ? contactListSajode[index].contactName
        : contactList1Person[index].contactName;

    /*For Update Contact flutter_contacts */
    update_contact.Contact? contact = await update_contact.FlutterContacts.getContact(updateContact.first.id,withAccounts: true);
    contact!.name.first = updatedName;
    await contact.update();
    Get.back();
    update([Constant.idBottomViewPos,Constant.idContactList]);
  }

  getAllDummyContactListBackend(){
    getAllContactBackend.add(AllContact(366, "hhhhhhj", Constant.selectedSendWpSarvo, true, TextEditingController(text: "hhhhhhj")));
    getAllContactBackend.add(AllContact(50550, "pppp", Constant.selectedSendWpSarvo, true, TextEditingController(text: "pppp")));
    getAllContactBackend.add(AllContact(8523697669, "Jaydip", Constant.selectedSendWp1Person, true, TextEditingController(text: "Jaydip")));
    getAllContactBackend.add(AllContact(8460085374, "Jd", Constant.selectedSendWpSajode, true, TextEditingController(text: "Jd")));

    for (int i = 0; i < getAllContactBackend.length; i++) {
      var number = getAllContactBackend[i].contactNumber;
      var pos = contactList.indexWhere((element) => element.contactNumber == number);
      if(pos != -1) {
        contactList[contactList.indexOf(contactList[pos])].isSelected = true;
        contactList[contactList.indexOf(contactList[pos])].sendType = getAllContactBackend[i].sendType;
      }
    }
    update([Constant.idBottomViewPos,Constant.idMainPage]);
  }

  getCountForSarvo(){
    return contactList.where((element) => element.sendType == Constant.selectedSendWpSarvo && element.isSelected == true).toList().length;
  }

  getCountForSajode(){
    return contactList.where((element) =>element.sendType == Constant.selectedSendWpSajode && element.isSelected == true).toList().length;
  }

  getCountForPerson(){
    return contactList.where((element) => element.sendType == Constant.selectedSendWp1Person && element.isSelected == true).toList().length;
  }

  getAllSelectedGuestNames(){
    var numberData = NumbersData();
    List<NumberList> list = [];
    var selectedNumbers = contactList.where((element) => element.isSelected == true).toList();
    for(int i=0;i<selectedNumbers.length;i++) {
      list.add(NumberList(banquetPerson: selectedNumbers[i].sendType, name: selectedNumbers[i].contactName,number: selectedNumbers[i].contactNumber));
    }
    numberData.numberList = list;
    Debug.printLog("getAllSelectedGuestNames==>> ${numberData.toJson()}  ${jsonEncode(numberData)}");
  }
}

class AllContact{
  // String contactNumber = "";
  int contactNumber = 0;
  String contactName = "";
  String sendType = Constant.selectedSendWpSarvo;
  bool isSelected = false;
  TextEditingController controller;

  AllContact(this.contactNumber,this.contactName,this.sendType,this.isSelected,this.controller);
}

