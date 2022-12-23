import 'dart:convert';

CreateKankotriData newKankotriDataFromJson(String str) => CreateKankotriData.fromJson(json.decode(str));

String newKankotriDataToJson(CreateKankotriData data) => json.encode(data.toJson());

class CreateKankotriData {
    CreateKankotriData({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    List<Result>? result;

    factory CreateKankotriData.fromJson(Map<String, dynamic> json) => CreateKankotriData(
        status: json["status"],
        message: json["message"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.previewUrl,
    });

    String? previewUrl;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        previewUrl: json["previewUrl"],
    );

    Map<String, dynamic> toJson() => {
        "previewUrl": previewUrl,
    };
}