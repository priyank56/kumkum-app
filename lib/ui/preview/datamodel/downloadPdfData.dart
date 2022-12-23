// To parse this JSON data, do
//
//     final downloadPdfData = downloadPdfDataFromJson(jsonString);

import 'dart:convert';

DownloadPdfData downloadPdfDataFromJson(String str) => DownloadPdfData.fromJson(json.decode(str));

String downloadPdfDataToJson(DownloadPdfData data) => json.encode(data.toJson());

class DownloadPdfData {
    DownloadPdfData({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    Result? result;

    factory DownloadPdfData.fromJson(Map<String, dynamic> json) => DownloadPdfData(
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
        this.type,
        this.data,
    });

    String? type;
    List<int>? data;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        type: json["type"],
        data: List<int>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "data": List<dynamic>.from(data!.map((x) => x)),
    };
}
