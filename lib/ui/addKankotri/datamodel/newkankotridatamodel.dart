import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/createKankotriData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/getInfoData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/newKankotriData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/uploadImageData.dart';
import 'package:spotify_flutter_code/utils/params.dart';
import '../../../dio/dioclient.dart';
import '../../../repository/repository.dart';

class NewKankotriDataModel {

  File? file;
  String? id = "";

  Future<CreateKankotriData> createKankotri(BuildContext context, String createData,CreateData createDataObject) {
    DioClient dioClient = DioClient(context,isPassAuth: true);
    return Repository(dioClient).createKankotri(this, createData,createDataObject,context);
  }

  Future<CreateKankotriData> updateKankotri(BuildContext context, String createData,CreateData createDataObject,String cardId) {
    DioClient dioClient = DioClient(context,isPassAuth: true);
    return Repository(dioClient).updateKankotri(this, createData,createDataObject,cardId,context);
  }

  Future<GetInfoData> getInfo(BuildContext context,String mrgType) {
    DioClient dioClient = DioClient(context,isPassAuth: true);
    return Repository(dioClient).getInfo(this,mrgType,context);
  }

  Future<NewKankotriData> getAllInvitationCards(BuildContext context) {
    DioClient dioClient = DioClient(context,isPassAuth: true);
    return Repository(dioClient).getYourInvitationCard(this,context);
  }

  Future<NewKankotriData> getAllPreBuiltCards(BuildContext context) {
    DioClient dioClient = DioClient(context,isPassAuth: true);
    return Repository(dioClient).getAllPreBuiltCards(this,context);
  }

  Future<UploadImageData> uploadCardImage(BuildContext context) {
    DioClient dioClient = DioClient(context,isPassAuth: true,isMultipart: true);
    return Repository(dioClient).uploadImage(this,context);
  }
}
