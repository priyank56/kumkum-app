import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/getInfoData.dart';
import 'package:spotify_flutter_code/ui/login/datamodel/logindatamodel.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import 'package:spotify_flutter_code/utils/params.dart';
import '../dio/dioclient.dart';
import '../ui/addKankotri/datamodel/createKankotriData.dart';
import '../ui/addKankotri/datamodel/newKankotriData.dart';
import '../ui/addKankotri/datamodel/newkankotridatamodel.dart';
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


  Future<CreateKankotriData> createKankotri(NewKankotriDataModel newKankotriDataModel,String createData,CreateData createDataObject,
      [BuildContext? context]) async {
    try {
      Response response = await dioClient!.dio.post<String>("/api/marriageInvitationCard",
          data: createDataObject.toJson());
      Debug.printLog("createKankotri RESPONSE ==>> $response ");

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return CreateKankotriData.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return CreateKankotriData.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return CreateKankotriData();
        }
      } else {
        throw Exception('Exception -->> Failed to createKankotri Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return CreateKankotriData.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return CreateKankotriData();
      }
    }
  }



  Future<CreateKankotriData> updateKankotri(NewKankotriDataModel newKankotriDataModel,String createData,CreateData createDataObject,String cardId,
      [BuildContext? context]) async {
    try {

      Response response = await dioClient!.dio.put<String>("/api/marriageInvitationCard/$cardId",
          data: createDataObject.toJson());
      Debug.printLog("updateKankotri RESPONSE ==>> $response ==>>> $cardId");

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return CreateKankotriData.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return CreateKankotriData.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return CreateKankotriData();
        }
      } else {
        throw Exception('Exception -->> Failed to createKankotri Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return CreateKankotriData.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return CreateKankotriData();
      }
    }
  }





  Future<GetInfoData> getInfo(NewKankotriDataModel newKankotriDataModel,String mrgType,
      [BuildContext? context]) async {
    try {
      Response response = await dioClient!.dio.get<String>("/api/marriageInvitationCard/info",queryParameters:{Params.type:mrgType} );
      Debug.printLog("getInfo RESPONSE ==>> $response ");

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return GetInfoData.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return GetInfoData.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return GetInfoData();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return GetInfoData.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return GetInfoData();
      }
    }
  }

  Future<NewKankotriData> getYourInvitationCard(NewKankotriDataModel newKankotriDataModel,
      [BuildContext? context]) async {
    try {
      Response response = await dioClient!.dio.get<String>("/api/marriageInvitationCard" );
      Debug.printLog("getYourInvitationCard RESPONSE ==>> $response ");

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return NewKankotriData.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return NewKankotriData.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return NewKankotriData();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return NewKankotriData.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return NewKankotriData();
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
