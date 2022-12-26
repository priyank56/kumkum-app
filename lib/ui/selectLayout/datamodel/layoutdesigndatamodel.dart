import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/createKankotriData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/getInfoData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/newKankotriData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/uploadImageData.dart';
import 'package:spotify_flutter_code/ui/selectLayout/datamodel/layoutDesignData.dart';
import 'package:spotify_flutter_code/utils/params.dart';
import '../../../dio/dioclient.dart';
import '../../../repository/repository.dart';

class LayoutDesignDataModel {

  Future<LayoutDesignData> getLayoutDesign(BuildContext context) {
    DioClient dioClient = DioClient(context,isPassAuth: true);
    return Repository(dioClient).getAllLayoutDesign(this,context);
  }
}
