import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/ui/login/datamodel/logindatamodel.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import '../dio/dioclient.dart';
import '../ui/login/datamodel/logindata.dart';

class Repository {
  DioClient? dioClient;

  Repository([this.dioClient]);

  Future<LoginData> login(LoginDataModel logInDataModel,
      [BuildContext? context]) async {
    try {

      Response response = await dioClient!.dio.post<String>("auth/login",
          data: FormData.fromMap(logInDataModel.toJson()));

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return LoginData.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return LoginData.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return LoginData(success: Constant.failureCode);
        }
      } else {
        throw Exception('Exception -->> Failed to Login Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return LoginData.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return LoginData(success: Constant.failureCode);
      }
    }
  }


  //Todo: For MultiPart Image API
  /* Future<CreateQrData> createQrCode(CreateQrDataModel createQrDataModel,
      [BuildContext? context]) async {
    try {
      List<int> listOfBytes = [];
      if(createQrDataModel.qrLogo != null) {
        listOfBytes = List.from(
            createQrDataModel.qrLogo!.readAsBytesSync());
      }

      FormData formData = FormData.fromMap({
        Params.id: createQrDataModel.id,
        Params.name: createQrDataModel.name,
        Params.isPersonal: createQrDataModel.isPersonal,
        Params.firstNameQR: createQrDataModel.firstNameQR,
        Params.lastNameQR: createQrDataModel.lastNameQR,
        Params.title: createQrDataModel.title,
        Params.street: createQrDataModel.street,
        Params.zipCode: createQrDataModel.zipCode,
        Params.city: createQrDataModel.city,
        Params.country: createQrDataModel.country,
        Params.company: createQrDataModel.company,
        Params.emailPersonal: createQrDataModel.emailPersonal,
        Params.emailBusiness: createQrDataModel.emailBusiness,
        Params.phonePersonal: createQrDataModel.phonePersonal,
        Params.phoneBusiness: createQrDataModel.phoneBusiness,
        Params.website: createQrDataModel.website,
        Params.facebook: createQrDataModel.facebook,
        Params.instagram: createQrDataModel.instagram,
        Params.linkedin: createQrDataModel.linkedin,
        Params.selected: createQrDataModel.selected,
        Params.bgColor: createQrDataModel.bgColor,
        Params.fgColor: createQrDataModel.fgColor,
        Params.qrImage: createQrDataModel.qrImage,
        Params.qrData: createQrDataModel.qrData,
        if (createQrDataModel.qrLogo != null)
          Params.qrLogo: MultipartFile.fromBytes(listOfBytes,filename: "logo.png"),
      });

      Response response = await dioClient!.dio.post<String>("vcard",
          data: formData);

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return CreateQrData.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return CreateQrData.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return CreateQrData(success: Constant.failureCode);
        }
      } else {
        throw Exception('Exception -->> Failed to createQrCode Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return CreateQrData.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return CreateQrData(success: Constant.failureCode);
      }
    }
  }*/

}
