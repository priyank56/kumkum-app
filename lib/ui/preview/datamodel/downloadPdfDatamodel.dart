import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/ui/preview/datamodel/downloadPdfData.dart';

import '../../../dio/dioclient.dart';
import '../../../repository/repository.dart';
import 'functionUploadData.dart';

class DownloadPdfDataModel {

  Future<DownloadPdfData> getDownloadPdf(BuildContext context,FunctionUploadData uploadData,String cardId,String isFromScreen, bool changeEndPointForDownload) {
    DioClient dioClient = DioClient(context,isPassAuth: true);
    return Repository(dioClient).getDownloadPdf(this,uploadData,cardId,isFromScreen,changeEndPointForDownload,context);
  }

}
