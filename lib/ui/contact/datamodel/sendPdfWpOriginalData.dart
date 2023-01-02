import 'dart:convert';

SendPdfWpOriginalData sendPdfWpOriginalDataFromJson(String str) => SendPdfWpOriginalData.fromJson(json.decode(str));

String sendPdfWpOriginalDataToJson(SendPdfWpOriginalData data) => json.encode(data.toJson());

class SendPdfWpOriginalData {
    SendPdfWpOriginalData({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    Result? result;

    factory SendPdfWpOriginalData.fromJson(Map<String, dynamic> json) => SendPdfWpOriginalData(
        status: json["status"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result!.toJson(),
    };
}

class Result {
    Result({
        this.pdfBuffer,
    });

    PdfBuffer? pdfBuffer;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        pdfBuffer: PdfBuffer.fromJson(json["pdfBuffer"]),
    );

    Map<String, dynamic> toJson() => {
        "pdfBuffer": pdfBuffer!.toJson(),
    };
}

class PdfBuffer {
    PdfBuffer({
        this.type,
        this.data,
    });

    String? type;
    List<int>? data;

    factory PdfBuffer.fromJson(Map<String, dynamic> json) => PdfBuffer(
        type: json["type"],
        data: List<int>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "data": List<dynamic>.from(data!.map((x) => x)),
    };
}
