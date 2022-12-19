
import 'dart:convert';

UploadImageData uploadImageDataFromJson(String str) => UploadImageData.fromJson(json.decode(str));

String uploadImageDataToJson(UploadImageData data) => json.encode(data.toJson());

class UploadImageData {
    UploadImageData({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    Result? result;

    factory UploadImageData.fromJson(Map<String, dynamic> json) => UploadImageData(
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
        this.url,
    });

    String? url;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
