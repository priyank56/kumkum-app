import 'dart:convert';

CreateKankotriData newKankotriDataFromJson(String str) => CreateKankotriData.fromJson(json.decode(str));

String newKankotriDataToJson(CreateKankotriData data) => json.encode(data.toJson());

class CreateKankotriData {
    CreateKankotriData({
        this.status,
        this.message,
    });

    int? status;
    String? message;

    factory CreateKankotriData.fromJson(Map<String, dynamic> json) => CreateKankotriData(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}