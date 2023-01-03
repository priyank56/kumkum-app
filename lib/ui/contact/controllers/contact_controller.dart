import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotify_flutter_code/ui/category/controllers/category_controller.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/contactdatamodel.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/getNumbersData.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/numbersJsonData.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/sendNumbersData.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/sendNumbersJsonData.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/sendPdfWpData.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/sendPdfWpOriginalData.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as update_contact;

import '../../../connectivitymanager/connectivitymanager.dart';
import '../../../main.dart';
import '../../../utils/color.dart';
import '../../../utils/sizer_utils.dart';
import '../../../utils/utils.dart';
import '../../addKankotri/controllers/add_kankotri_controller.dart';
import '../../addKankotri/datamodel/newKankotriData.dart';
import '../../addKankotri/datamodel/newkankotridatamodel.dart';
import '../../preview/controllers/preview_controller.dart';
import '../../preview/datamodel/functionUploadData.dart';

class ContactController extends GetxController {

  int currentPos = 1;
  String selectedSendWp = Constant.selectedSendWpSarvo;
  String displayDefaultVal = "txtSarvo".tr;
  TextEditingController searchController = TextEditingController();

  bool isCheck = false;
  List<AllContact> contactList = [];
  List<AllContact> allContactList = [];
  final List<OptionsClass> listPersons = [];
  // List<FunctionPreview>? functionsUploadList = [];
  List<PreviewFunctions> functionStringTitleList = [];
  List<SendPdfWpFunction> functionPdfSendWpList = [];
  bool isAdvanceEnabled = false;

  String? selectedValue;
  String? previewURL= "";
  // List<AllContact> contactListSarvo = [];
  // List<AllContact> contactListSajode = [];
  // List<AllContact> contactList1Person = [];
  
  List<AllContact> getAllContactBackend = [];

  bool isShowProgress = false;
  NewKankotriDataModel newKankotriDataModel = NewKankotriDataModel();
  ContactDataModel contactDataModel = ContactDataModel();
  List<ResultGet> allYourCardList = [];
  var auth = FirebaseAuth.instance;
  var selectedCardId = "";
  ResultGet selectedCardData = ResultGet();
  PanelController panelController = PanelController();
  bool isSlideUp = false;

  @override
  void onInit() {
    super.onInit();
    getAllYourCardsAPI(Get.context!);

  }

  changeSlideUpDown(bool value){
    isSlideUp = value;
    update([Constant.idBottomViewPos]);
  }
  changeSelectedId(String id,int pos){
    selectedCardId = id;
    selectedCardData = allYourCardList[pos];
    var truePos = allYourCardList.indexWhere((element) => element.isSelect == true);
    if(truePos != -1){
      allYourCardList[truePos].isSelect = !allYourCardList[truePos].isSelect!;
    }
    allYourCardList[pos].isSelect = !allYourCardList[pos].isSelect!;
    update([Constant.idNextPrevious,Constant.idBottomText,Constant.idBottomViewPos,Constant.idMainPage,]);
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
    Debug.printLog("changeBottomViewPos selectedCardId===>>> $pos  $selectedCardId");
    if(pos == 2){
      if (await Permission.contacts.request().isGranted) {
        getAllContact();
      } else if (await Permission.contacts.request().isPermanentlyDenied) {
        await openAppSettings();
      }else if (await Permission.contacts.request().isDenied) {
        Get.back();
      }
    }/*else if(pos == 3){
      getAllSelectedGuestNames();
    }*/
    update([Constant.idNextPrevious,Constant.idBottomText,Constant.idBottomViewPos,Constant.idMainPage,]);
  }

  changeSendOption(String value){
    selectedSendWp = value;
    /*if(selectedSendWp == Constant.selectedSendWpSarvo){
      contactListSarvo = contactList.where((element) => element.sendType != Constant.selectedSendWp1Person && element.sendType != Constant.selectedSendWpSajode).toList();
    }else if(selectedSendWp == Constant.selectedSendWpSajode){
      contactListSajode = contactList.where((element) => element.sendType != Constant.selectedSendWpSarvo && element.sendType != Constant.selectedSendWp1Person).toList();
    }else if(selectedSendWp == Constant.selectedSendWp1Person){
      contactList1Person = contactList.where((element) => element.sendType != Constant.selectedSendWpSarvo && element.sendType != Constant.selectedSendWpSajode).toList();
    }*/
    update([Constant.idBottomViewPos,Constant.idContactList]);
  }

  Future<void> getAllContact()async{
    if(contactList.isNotEmpty){
      return;
    }

    List<Contact> contacts = await ContactsService.getContacts();
    for(int i=0;i<contacts.length;i++){
      // var contactNumber = int.parse(contacts[i].phones![0].value!.replaceAll("+", ""));
      var contactNumber = "";
      if(contacts[i].phones!.isNotEmpty) {
        try {
          contactNumber = contacts[i].phones![0].value!;
        } catch (e) {
          contactNumber = "";
        }
      }else{
        contactNumber = contacts[i].givenName.toString();
      }
      var contactName = contacts[i].displayName;
      var sendType = "";
      var isSelected = false;
      Debug.printLog("Contacts===>>   ${contacts[i].displayName} ${contacts[i].givenName}");

      contactList.add(AllContact(contactNumber,contactName!,sendType,isSelected,TextEditingController(text:contactName )));
      allContactList.add(AllContact(contactNumber,contactName!,sendType,isSelected,TextEditingController(text:contactName )));
      changeSendOption(Constant.selectedSendWpSarvo);
      update([Constant.idBottomViewPos]);
    }
    getAllSelectedNumbers(Get.context!);

    Debug.printLog("contacts=>>> Sizes   ${contacts.length}");
  }

  TextEditingController nameContactController = TextEditingController();
  TextEditingController numberContactController = TextEditingController();

  addContact(String name,String number) async {
    if(name == "" || number == ""){
      return;
    }
    contactList.insert(0, AllContact(number, name, "", false, TextEditingController(text: name)));
    allContactList.insert(0, AllContact(number, name, "", false, TextEditingController(text: name)));
    // contactListSarvo.insert(0, AllContact(number, name, "", false, TextEditingController(text: name)));
    // contactList1Person.insert(0, AllContact(number, name, "", false, TextEditingController(text: name)));
    // contactList1Person.insert(0, AllContact(number, name, "", false, TextEditingController(text: name)));
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

    contactList[index].contactName = contactList[index].controller.text;
    allContactList[index].contactName = allContactList[index].controller.text;
    var updatedName = contactList[index].contactName;
    var currentNumber = contactList[index].contactNumber;

   /* (type == Constant.selectedSendWpSarvo)
        ? contactListSarvo[index].contactName = contactListSarvo[index].controller.text
        : (type == Constant.selectedSendWpSajode)
        ? contactListSajode[index].contactName = contactListSajode[index].controller.text
        : contactList1Person[index].contactName = contactList1Person[index].controller.text;
    var updatedName = (type == Constant.selectedSendWpSarvo)
        ? contactListSarvo[index].contactName
        : (type == Constant.selectedSendWpSajode)
        ? contactListSajode[index].contactName
        : contactList1Person[index].contactName;

    var currentNumber = (type == Constant.selectedSendWpSarvo)
        ? contactListSarvo[index].contactNumber
        : (type == Constant.selectedSendWpSajode)
        ? contactListSajode[index].contactNumber
        : contactList1Person[index].contactNumber;*/

    var positionOfContactList = contactList.indexWhere((element) => element.contactNumber == currentNumber);
    contactList[positionOfContactList].contactName = updatedName;
    allContactList[positionOfContactList].contactName = updatedName;
    /*For Update Contact flutter_contacts */
    update_contact.Contact? contact = await update_contact.FlutterContacts.getContact(updateContact.first.id,withAccounts: true);
    contact!.name.first = updatedName;
    await contact.update();
    Get.back();
    update([Constant.idBottomViewPos,Constant.idContactList]);
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
    /*var numberData = NumbersJsonData();
    List<NumberList> list = [];
    var selectedNumbers = contactList.where((element) => element.isSelected == true).toList();
    for(int i=0;i<selectedNumbers.length;i++) {
      list.add(NumberList(banquetPerson: selectedNumbers[i].sendType, name: selectedNumbers[i].contactName,number: selectedNumbers[i].contactNumber));
    }
    numberData.numberList = list;*/
    var mainAllContact = contactList;
    var sendNumberData = SendNumbersJsonData();
    List<SendNumberList> sendList = [];
    var sendSelectedNumbers = mainAllContact.where((element) => element.isSelected == true).toList();
    for(int i=0;i<sendSelectedNumbers.length;i++) {
      sendList.add(SendNumberList(number:  sendSelectedNumbers[i].contactNumber,name:sendSelectedNumbers[i].contactName ,banquetPerson:sendSelectedNumbers[i].sendType ));
    }
    sendNumberData.numberList = sendList;

    Debug.printLog("getAllSelectedGuestNames==>>${jsonEncode(sendNumberData)}");
    sendAllSelectedNumbers(Get.context!,sendNumberData);

  }

  getAllSelectedNumbers(BuildContext context) async {
    if (await InternetConnectivity.isInternetConnect()) {
      isShowProgress = true;
      update([Constant.isShowProgressUpload]);
      await contactDataModel.getAllSelectedNumbers(context).then((value) {
        handleAllSelectedNumbersResponse(value,context);
      });
    } else {
      Utils.showToast(context, "txtNoInternet".tr);
    }
  }

  handleAllSelectedNumbersResponse(GetNumbersData newKankotriData, BuildContext context) async {
    if (newKankotriData.status == Constant.responseSuccessCode) {
      if (newKankotriData.message != null) {
        Debug.printLog(
            "handleAllSelectedNumbersResponse Res Success ===>> ${newKankotriData.toJson()} ");
        if(newKankotriData.result!.numberList!.isNotEmpty) {
          for(int i = 0;i<newKankotriData.result!.numberList!.length;i++){
            var data = newKankotriData.result!.numberList![i];
            getAllContactBackend.add(AllContact(data.number!, data.name!, data.banquetPerson!, true, TextEditingController(text: data.name!)));
          }
          if(getAllContactBackend.isEmpty){
            return;
          }
          for (int i = 0; i < getAllContactBackend.length; i++) {
            var number = getAllContactBackend[i].contactNumber;
            var pos = contactList.indexWhere((element) => element.contactNumber == number);
            if (pos != -1) {
              contactList[contactList.indexOf(contactList[pos])].isSelected = true;
              contactList[contactList.indexOf(contactList[pos])].sendType = getAllContactBackend[i].sendType;
              allContactList[allContactList.indexOf(allContactList[pos])].isSelected = true;
              allContactList[allContactList.indexOf(allContactList[pos])].sendType = getAllContactBackend[i].sendType;
            }
          }
          changeSendOption(Constant.selectedSendWpSarvo);
          update([Constant.idBottomViewPos, Constant.idMainPage]);
        }

      } else {
        Debug.printLog(
            "handleAllSelectedNumbersResponse Res Fail ===>> ${newKankotriData.toJson().toString()}");

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
    update([Constant.isShowProgressUpload,Constant.idBottomViewPos]);
  }



  sendAllSelectedNumbers(BuildContext context, SendNumbersJsonData numberData) async {
    if (await InternetConnectivity.isInternetConnect()) {
      isShowProgress = true;
      update([Constant.isShowProgressUpload]);
      await contactDataModel.sendAllSelectedNumbers(context,numberData).then((value) {
        handleSendSelectedNumbersResponse(value,context);
      });
    } else {
      Utils.showToast(context, "txtNoInternet".tr);
    }
  }

  handleSendSelectedNumbersResponse(SendNumbersData newKankotriData, BuildContext context) async {
    if (newKankotriData.status == Constant.responseSuccessCode) {
      if (newKankotriData.message != null) {
        Debug.printLog(
            "handleSendSelectedNumbersResponse Res Success ===>> ${newKankotriData.toJson()} ");

      } else {
        Debug.printLog(
            "handleSendSelectedNumbersResponse Res Fail ===>> ${newKankotriData.toJson().toString()}");

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
    update([Constant.isShowProgressUpload,Constant.idBottomViewPos]);
  }



  changeAdvanced(){
    isAdvanceEnabled = !isAdvanceEnabled;
    update([Constant.idAllButton]);
  }



  showCustomizeDialog(BuildContext context, ContactController logic, int index,{bool isFromDownload = true}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            runAlignment: WrapAlignment.center,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: contentBox(context,index,isFromDownload),
              ),
            ],
          );
        }).then((value) => (){
          Debug.printLog("Dismiss==>>> ");
    });
  }

  showAlertDialogPermission(BuildContext context,ContactController logic) {
    // Create button
    Widget okButton = TextButton(
      child: Text("txtOk".tr),
      onPressed: () async {
        await openAppSettings();
      },
    );

    Widget cancelButton = TextButton(
      child: Text("txtCancel".tr),
      onPressed: () {
        Get.back();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("txtPermission".tr),
      content: Text("txtPermissionDesc".tr),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  contentBox(BuildContext context, int index, bool isFromDownload) {
    return GetBuilder<ContactController>(
        id: Constant.idAllButton,
        builder: (logic) {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Sizes.height_2, bottom: Sizes.height_1),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: Sizes.width_4, right: Sizes.width_1),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      // backgroundColor: CColor.theme,
                                      elevation: 0,
                                      backgroundColor: (logic.selectedSendWp ==
                                          Constant.selectedSendWpSarvo)
                                          ? CColor.themeDark
                                          : CColor.gray,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5), // <-- Radius
                                      ),
                                      textStyle: TextStyle(
                                          color: CColor.white,
                                          fontSize: FontSize.size_12,
                                          fontFamily: Constant.appFont,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () {
                                      logic.changeDefaultOption(Constant.selectedSendWpSarvo);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "txtSarvo".tr,
                                        style: TextStyle(
                                            color: (logic.selectedSendWp ==
                                                Constant.selectedSendWpSarvo)
                                                ? CColor.white
                                                : CColor.black,
                                            fontSize: FontSize.size_12,
                                            fontFamily: Constant.appFont),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: Sizes.width_2, left: Sizes.width_1),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      // backgroundColor: CColor.theme,
                                      elevation: 0,
                                      backgroundColor: (logic.selectedSendWp ==
                                          Constant.selectedSendWpSajode)
                                          ? CColor.themeDark
                                          : CColor.gray,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5), // <-- Radius
                                      ),
                                      textStyle: TextStyle(
                                          color: CColor.white,
                                          fontSize: FontSize.size_12,
                                          fontFamily: Constant.appFont,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () {
                                      logic.changeDefaultOption(Constant.selectedSendWpSajode);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "txtSajode".tr,
                                        style: TextStyle(
                                            color: (logic.selectedSendWp ==
                                                Constant.selectedSendWpSajode)
                                                ? CColor.white
                                                : CColor.black,
                                            fontSize: FontSize.size_12,
                                            fontFamily: Constant.appFont),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: Sizes.width_4,),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      // backgroundColor: CColor.theme,
                                      elevation: 0,
                                      backgroundColor: (logic.selectedSendWp ==
                                          Constant.selectedSendWp1Person)
                                          ? CColor.themeDark
                                          : CColor.gray,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5), // <-- Radius
                                      ),
                                      textStyle: TextStyle(
                                          color: CColor.white,
                                          fontSize: FontSize.size_12,
                                          fontFamily: Constant.appFont,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () {
                                      logic.changeDefaultOption(Constant.selectedSendWp1Person);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "txt1".tr,
                                        style: TextStyle(
                                            color: (logic.selectedSendWp ==
                                                Constant.selectedSendWp1Person)
                                                ? CColor.white
                                                : CColor.black,
                                            fontSize: FontSize.size_12,
                                            fontFamily: Constant.appFont),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: Sizes.height_3),
                    alignment: Alignment.center,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return _itemWidgetJan(index, context, logic);
                      },
                      shrinkWrap: true,
                      itemCount:
                      (logic.isAdvanceEnabled) ? logic.functionStringTitleList.length : (logic.functionStringTitleList.length > 3)?3:logic.functionStringTitleList.length,
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                  Column(
                    // alignment: Alignment.centerRight,
                    children: [
                      if (logic.functionStringTitleList.length > 3)
                        Container(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              logic.changeAdvanced();
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: Sizes.height_2),
                              child: Text(
                                (!logic.isAdvanceEnabled)
                                    ? "txtVadhare".tr
                                    : "txtOchu".tr,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: CColor.blue,
                                    fontFamily: Constant.appFont,
                                    fontWeight: FontWeight.w700,
                                    fontSize: FontSize.size_12),
                              ),
                            ),
                          ),
                        )
                      else Container(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            left: Sizes.width_5, right: Sizes.width_5,bottom: Sizes.height_1_5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CColor.blueDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // <-- Radius
                            ),
                            textStyle: TextStyle(
                                color: CColor.white,
                                fontSize: FontSize.size_12,
                                fontFamily: Constant.appFont,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () async {
                            if (await Permission.storage
                                .request()
                                .isGranted) {
                              logic.generateUploadFunctionsData(index,isFromDownload);
                              Get.back();
                            } else if (await Permission.storage
                                .request()
                                .isPermanentlyDenied) {
                              showAlertDialogPermission(context,logic);
                            } else if (await Permission.storage
                                .request()
                                .isDenied) {
                              Get.back();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(Sizes.height_1_5),
                            child: Text((isFromDownload)?"txtDownloadBtn".tr:"txtSend".tr,),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  _itemWidgetJan(int index, BuildContext context, ContactController logic) {
    return Container(
      margin: EdgeInsets.only(
          left: Sizes.width_5, right: Sizes.width_5, top: Sizes.height_2),
      // alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text(
            logic.functionStringTitleList[index].fName.toString(),
            style: TextStyle(
                color: CColor.black,
                fontSize: FontSize.size_14,
                fontWeight: FontWeight.w500,
                fontFamily: Constant.appFont),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              items: listPersons[index].strValue!
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: CColor.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
                  .toList(),
              value: listPersons[index].selectedValue,
              onChanged: (value) {
                logic.changeDropDownValue(value.toString(),index);
              },
              buttonWidth: 160,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: CColor.white,
              ),
              buttonElevation: 2,
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: 160,
              dropdownPadding: null,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: CColor.white,
              ),
              dropdownElevation: 8,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              offset: const Offset(0, 0),
            ),
          ),
        ],
      ),
    );
  }


  void emptySearch() {
    searchController.text = "";
    contactList = allContactList;
    update([Constant.idContactList]);
  }

  changeDropDownValue(String value, int index){
    // selectedValue = value;
    listPersons[listPersons.indexOf(listPersons[index])].selectedValue = value;
    functionStringTitleList[functionStringTitleList.indexOf(functionStringTitleList[index])].fPerson = value;
    update([Constant.idAllButton]);
  }

  onChangeContactList(String strVal){
    Debug.printLog("onChangeContactList==>> $strVal");

    contactList = allContactList.where((element) => element.contactName.toLowerCase().contains(strVal.toLowerCase())
        || element.contactNumber.toLowerCase().contains(strVal.toLowerCase())).toList();
    update([Constant.idContactList]);
  }



  void generateUploadFunctionsData(int index, bool isFromDownload) {
    // FocusScope.of(Get.context!).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();

    /*if(functionsUploadList!.isNotEmpty){
      functionsUploadList!.clear();
    }*/
    if(functionPdfSendWpList.isNotEmpty){
      functionPdfSendWpList.clear();
    }
    for(int i = 0 ;i< functionStringTitleList.length;i++){
      /*functionsUploadList!.add(FunctionPreview(
          functionId: functionStringTitleList[i].fId,
          banquetPerson: functionStringTitleList[i].fPerson));*/
      functionPdfSendWpList.add(SendPdfWpFunction(
          functionId: functionStringTitleList[i].fId,
          banquetPerson: functionStringTitleList[i].fPerson
      ));
    }
/*    var previewData = FunctionUploadData();
    previewData.functions = functionsUploadList;*/
    sendPdfWhatsapp(index,isFromDownload);
    Debug.printLog("functionsUploadList===>>");

  }


  addDropDownMenuData({bool regenerateData = false,String? value = ""}){
    if(regenerateData){
      if(listPersons.isNotEmpty) {
        listPersons.clear();
      }
      if(functionStringTitleList.isNotEmpty) {
        functionStringTitleList.clear();
      }
    }
    List<FunctionsRes> list = selectedCardData.marriageInvitationCard!.functions!;
    for(int i =0;i<list.length;i++){
      // functionStringTitleList.add(PreviewFunctions(list[i].functionId, list[i].functionName ?? "",'txtSarvo'.tr));
      functionStringTitleList.add(PreviewFunctions(list[i].functionId, list[i].functionName ?? "",value));
    }
    for(int i =0 ; i<functionStringTitleList.length;i++){
      if(regenerateData){
        listPersons.add(OptionsClass(functionStringTitleList[i].fId.toString(), value,
            ['txtSarvo'.tr, 'txtSajode'.tr, 'txtAppShri'.tr]));
      }else {
        listPersons.add(OptionsClass(functionStringTitleList[i].fId.toString(), 'txtSarvo'.tr,
            ['txtSarvo'.tr, 'txtSajode'.tr, 'txtAppShri'.tr]));
      }
    }
    Debug.printLog("addDropDownMenuData==>> ${functionStringTitleList.length}  ${listPersons.length}");
    update([Constant.idAllButton,Constant.idContactList]);
  }

  changeDefaultOption(String value){
    selectedSendWp = value;
    if(value == Constant.selectedSendWpSarvo){
      displayDefaultVal = "txtSarvo".tr;
    }else if(value == Constant.selectedSendWpSajode){
      displayDefaultVal = "txtSajode".tr;
    }else if(value == Constant.selectedSendWp1Person){
      displayDefaultVal = "txtAppShri".tr;
    }
    addDropDownMenuData(regenerateData: true,value: displayDefaultVal);
    update([Constant.idAllButton,Constant.idContactList]);
  }


  Future<void> sendPdfWhatsapp(int index, bool isFromDownload) async {
    var sendPdfData = SendPdfWpData();
    sendPdfData.number = contactList[index].contactNumber;
    sendPdfData.name = contactList[index].contactName;
    sendPdfData.functions = functionPdfSendWpList;
    emptySearch();
    getNumberWisePdf(Get.context!,index,sendPdfData,isFromDownload);

    // FlutterShareMe flutterShareMe = FlutterShareMe();
    // await flutterShareMe.shareToWhatsApp(imagePath: file.absolute.path);
    /*if (Platform.isAndroid) {
      AndroidIntent intent = const AndroidIntent(
        action: 'action_send',
        type: "application/pdf",
        arguments: <String, dynamic>{
          'android.intent.extra.STREAM': file.absolute.path,
          'jid': '+918460085373',
        },
        package: 'com.whatsapp'
      );
      await intent.launch();
    }*/

    Debug.printLog("sendPdfWhatsapp===>>  $selectedCardId  ${functionPdfSendWpList.length.toString()}${jsonEncode(sendPdfData)}");

  }

  getNumberWisePdf(BuildContext context,int index,SendPdfWpData data, bool isFromDownload) async {
    if (await InternetConnectivity.isInternetConnect()) {
      isShowProgress = true;
      update([Constant.isShowProgressUpload,Constant.idBottomViewPos]);
      await contactDataModel.getNumberWisePdf(context,data,selectedCardId).then((value) {
        handleGetNumberWisePdfResponse(value, context,index,data,isFromDownload);
      });
    } else {
      Utils.showToast(context, "txtNoInternet".tr);
    }
  }

  handleGetNumberWisePdfResponse(SendPdfWpOriginalData getAllKankotriData, BuildContext context,int index, SendPdfWpData data, bool isFromDownload) async {
    // allYourCardList.clear();
    if (getAllKankotriData.status == Constant.responseSuccessCode) {
      if (getAllKankotriData.message != null) {
        Debug.printLog(
            "handleGetAllMyKankotriResponse Res Success ===>> ${getAllKankotriData.toJson().toString()}");
        // var path = "/storage/emulated/0/Download/card.pdf";
        // File file = File(path);

        var timeStamp  = DateTime.now().millisecondsSinceEpoch;
        final File file = File('${'/storage/emulated/0/Download/'}${data.name ?? "invitationCard"}_${timeStamp.toString()}.pdf');
        await file.writeAsBytes(getAllKankotriData.result!.pdfBuffer!.data ?? []);
        var filePath = file.absolute.path.toString();
        if(isFromDownload){
          showNotification(filePath);
        }else {
          Share.shareFiles([filePath]);
          contactList[index].isSelected = true;
        }

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
    update([Constant.isShowProgressUpload,Constant.idBottomViewPos]);
  }

  showNotification(String filePath)async{
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(
        "12345",
        "kumkum_app",
        importance: Importance.defaultImportance,
        priority: Priority.max);

    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        12345,
        "KumKum App",
        "PDF Download successfully",
        platformChannelSpecifics,
        payload:filePath );
  }

}

class AllContact{
  String contactNumber = "";
  // int contactNumber = 0;
  String contactName = "";
  String sendType = Constant.selectedSendWpSarvo;
  bool isSelected = false;
  TextEditingController controller;

  AllContact(this.contactNumber,this.contactName,this.sendType,this.isSelected,this.controller);
}

