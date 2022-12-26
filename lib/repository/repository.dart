import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/datamodel/createData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/getInfoData.dart';
import 'package:spotify_flutter_code/ui/addKankotri/datamodel/uploadImageData.dart';
import 'package:spotify_flutter_code/ui/login/datamodel/logindatamodel.dart';
import 'package:spotify_flutter_code/ui/preview/datamodel/downloadPdfData.dart';
import 'package:spotify_flutter_code/ui/preview/datamodel/functionUploadData.dart';
import 'package:spotify_flutter_code/ui/selectLayout/datamodel/layoutDesignData.dart';
import 'package:spotify_flutter_code/utils/constant.dart';
import 'package:spotify_flutter_code/utils/debug.dart';
import 'package:spotify_flutter_code/utils/params.dart';
import '../dio/dioclient.dart';
import '../ui/addKankotri/datamodel/createKankotriData.dart';
import '../ui/addKankotri/datamodel/newKankotriData.dart';
import '../ui/addKankotri/datamodel/newkankotridatamodel.dart';
import '../ui/contact/datamodel/contactdatamodel.dart';
import '../ui/contact/datamodel/getNumbersData.dart';
import '../ui/contact/datamodel/numbersJsonData.dart';
import '../ui/contact/datamodel/sendNumbersData.dart';
import '../ui/contact/datamodel/sendNumbersJsonData.dart';
import '../ui/login/datamodel/logindata.dart';
import '../ui/preview/datamodel/downloadPdfDatamodel.dart';
import '../ui/selectLayout/datamodel/layoutdesigndatamodel.dart';

class Repository {
  DioClient? dioClient;

  Repository([this.dioClient]);

  Future<CreateKankotriData> createKankotri(NewKankotriDataModel newKankotriDataModel,String createData,CreateData createDataObject,
      [BuildContext? context]) async {
    try {
      Response response = await dioClient!.dio.post<String>("/api/marriage-invitation-card",
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

      Response response = await dioClient!.dio.put<String>("/api/marriage-invitation-card/$cardId",
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
    Debug.printLog("getInfo mrgType==>> : $mrgType");
    try {
      Response response = await dioClient!.dio.get<String>("/api/marriage-invitation-card/info",queryParameters:{Params.type:mrgType} );

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
      Response response = await dioClient!.dio.get<String>("/api/marriage-invitation-card" );
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


  Future<NewKankotriData> getAllPreBuiltCards(NewKankotriDataModel newKankotriDataModel,
      [BuildContext? context]) async {
    try {
      Response response = await dioClient!.dio.get<String>("/api/prebuilt-invitation-card" );
      Debug.printLog("getAllPreBuiltCards RESPONSE ==>> $response ");

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


  Future<UploadImageData> uploadImage(NewKankotriDataModel uploadImageDataModel,
      [BuildContext? context]) async {
    try {
      FormData formData;

      if(uploadImageDataModel.id == ""){
        formData = FormData.fromMap({
          Params.image: await MultipartFile.fromFile(uploadImageDataModel.file!.path, filename:uploadImageDataModel.file!.path.split('/').last),
        });
      }else {
        formData = FormData.fromMap({
          Params.image: await MultipartFile.fromFile(uploadImageDataModel.file!.path, filename: uploadImageDataModel.file!.path.split('/').last),
          Params.id: uploadImageDataModel.id,
        });
      }
      // Debug.printLog("uploadImageDataModel===>>>> ${formData.boundary.toString()}");

      Response response =
          await dioClient!.dio.post<String>("/api/marriage-invitation-card/upload/image", data: formData);
      Debug.printLog("uploadImage RESPONSE ==>> $response ");

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return UploadImageData.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return UploadImageData.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return UploadImageData();
        }
      } else {
        throw Exception(
            'Exception -->> Failed to createQrCode Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return UploadImageData.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return UploadImageData();
      }
    }
  }

  Future<GetNumbersData> getAllSelectedNumbers(ContactDataModel contactDataModel, [BuildContext? context]) async {
    try {
      Response response = await dioClient!.dio.get<String>("/api/contact-list");

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return GetNumbersData.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return GetNumbersData.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return GetNumbersData();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return GetNumbersData.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return GetNumbersData();
      }
    }
  }

  Future<SendNumbersData> sendAllSelectedNumbers(ContactDataModel contactDataModel, SendNumbersJsonData numberData ,[BuildContext? context]) async {
    try {
      Response response = await dioClient!.dio.post<String>("/api/contact-list",data: numberData.toJson());

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return SendNumbersData.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return SendNumbersData.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return SendNumbersData();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return SendNumbersData.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return SendNumbersData();
      }
    }
  }

  Future<DownloadPdfData> getDownloadPdf(DownloadPdfDataModel downLoadData, FunctionUploadData functionData ,String cardId,String isFromScreen,[BuildContext? context]) async {
    try {
      Response response;
     /* if(isFromScreen == Constant.isFromCategoryScreen){
        response = await dioClient!.dio.post<String>(
            "/api/prebuilt-invitation-card/banquet-person/buffer/$cardId",
            data: functionData.toJson());
      }else {*/
        response = await dioClient!.dio.post<String>(
            "/api/marriage-invitation-card/banquet-person/buffer/$cardId",
            data: functionData.toJson());
      // }

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return DownloadPdfData.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return DownloadPdfData.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return DownloadPdfData();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return DownloadPdfData.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return DownloadPdfData();
      }
    }
  }

  Future<LayoutDesignData> getAllLayoutDesign(LayoutDesignDataModel newKankotriDataModel, [BuildContext? context]) async {
    try {
      Response response = await dioClient!.dio.get<String>("/api/designs");

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return LayoutDesignData.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return LayoutDesignData.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return LayoutDesignData();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return LayoutDesignData.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return LayoutDesignData();
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
