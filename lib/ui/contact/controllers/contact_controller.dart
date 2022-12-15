import 'package:get/get.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactController extends GetxController {

  int currentPos = 1;
  String selectedSendWp = Constant.selectedSendWpSarvo;
  bool isCheck = false;
  List<AllContact> contactList = [];

  changeBottomViewPos(int pos){
    currentPos = pos;
    if(pos == 2){
      getAllContact();
    }
    update([Constant.idNextPrevious,Constant.idBottomText,Constant.idBottomViewPos,Constant.idMainPage,]);
  }

  changeSendOption(String value){
    selectedSendWp = value;
    update([Constant.idBottomViewPos]);
  }

  changeCheckValue(bool value,int index, String selectedType){
    contactList[index].isSelected = !contactList[index].isSelected;
    contactList[index].sendType = selectedType;
    update([Constant.idBottomViewPos,Constant.idMainPage]);
  }

  Future<void> getAllContact()async{
    List<Contact> contacts = await ContactsService.getContacts();
    for(int i=0;i<contacts.length;i++){
      var contactNumber = contacts[i].phones![0].value;
      var contactName = contacts[i].displayName;
      var sendType = "";
      var isSelected = false;
      Debug.printLog("Contacts===>> ${contacts[i].phones![0].value}  ${contacts[i].displayName}");
      contactList.add(AllContact(contactNumber!,contactName!,sendType,isSelected));
      update([Constant.idBottomViewPos]);
    }
  }
}

class AllContact{
  String contactNumber = "";
  String contactName = "";
  String sendType = "";
  bool isSelected = false;

  AllContact(this.contactNumber,this.contactName,this.sendType,this.isSelected);
}

