import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/dio/dioclient.dart';
import 'package:spotify_flutter_code/ui/login/datamodel/logindata.dart';
import 'package:spotify_flutter_code/utils/params.dart';

import '../../../repository/repository.dart';


class LoginDataModel {

  String? email;
  String? password;

  Map<String, dynamic> toJson() => {
    Params.email: email,
    Params.password: password,
  };

  Future<LoginData> getAllAboutsUsData(BuildContext context) {
    DioClient dioClient = DioClient(context);
    return Repository(dioClient).login(this, context);
  }
}
