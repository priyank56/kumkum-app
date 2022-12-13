import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/getInfoData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/newKankotriData.dart';
import '../../../dio/dioclient.dart';
import '../../../repository/repository.dart';

class NewKankotriDataModel {

  Future<NewKankotriData> createKankotri(BuildContext context, String createData) {
    DioClient dioClient = DioClient(context);
    return Repository(dioClient).createKankotri(this, createData,context);
  }

  Future<GetInfoData> getInfo(BuildContext context) {
    DioClient dioClient = DioClient(context);
    return Repository(dioClient).getInfo(this,context);
  }
}
