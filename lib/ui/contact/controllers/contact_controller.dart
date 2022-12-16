import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactController extends GetxController {

  int currentPos = 1;
  String selectedSendWp = Constant.selectedSendWpSarvo;
  bool isCheck = false;
  List<AllContact> contactList = [];
  List<AllContact> contactListSarvo = [];
  List<AllContact> contactListSajode = [];
  List<AllContact> contactList1Person = [];

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
  @override
  void onInit() {
    super.onInit();

  }
}

class AllContact{
  String contactNumber = "";
  String contactName = "";
  String sendType = Constant.selectedSendWpSarvo;
  bool isSelected = false;

  AllContact(this.contactNumber,this.contactName,this.sendType,this.isSelected);
}

