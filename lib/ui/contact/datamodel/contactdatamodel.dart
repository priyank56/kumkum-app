import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/createKankotriData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/getInfoData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/newKankotriData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/uploadImageData.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/getNumbersData.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/numbersJsonData.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/sendNumbersData.dart';
import 'package:spotify_flutter_code/ui/contact/datamodel/sendNumbersJsonData.dart';
import 'package:spotify_flutter_code/utils/params.dart';
import '../../../dio/dioclient.dart';
import '../../../repository/repository.dart';

class ContactDataModel {

  Future<GetNumbersData> getAllSelectedNumbers(BuildContext context) {
    DioClient dioClient = DioClient(context,isPassAuth: true);
    return Repository(dioClient).getAllSelectedNumbers(this,context);
  }

  Future<SendNumbersData> sendAllSelectedNumbers(BuildContext context, SendNumbersJsonData numberData) {
    DioClient dioClient = DioClient(context,isPassAuth: true);
    return Repository(dioClient).sendAllSelectedNumbers(this,numberData,context);
  }
}
