import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/createKankotriData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/getInfoData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/newKankotriData.dart';
import '../../../dio/dioclient.dart';
import '../../../repository/repository.dart';

class NewKankotriDataModel {

  Future<CreateKankotriData> createKankotri(BuildContext context, String createData,CreateData createDataObject) {
    DioClient dioClient = DioClient(context);
    return Repository(dioClient).createKankotri(this, createData,createDataObject,context);
  }

  Future<CreateKankotriData> updateKankotri(BuildContext context, String createData,CreateData createDataObject,String cardId) {
    DioClient dioClient = DioClient(context);
    return Repository(dioClient).updateKankotri(this, createData,createDataObject,cardId,context);
  }

  Future<GetInfoData> getInfo(BuildContext context,String mrgType) {
    DioClient dioClient = DioClient(context);
    return Repository(dioClient).getInfo(this,mrgType,context);
  }

  Future<NewKankotriData> getAllInvitationCards(BuildContext context) {
    DioClient dioClient = DioClient(context);
    return Repository(dioClient).getYourInvitationCard(this,context);
  }
}
