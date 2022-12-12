// To parse this JSON data, do
//
//     final newKankotriData = newKankotriDataFromJson(jsonString);

import 'dart:convert';

NewKankotriData newKankotriDataFromJson(String str) => NewKankotriData.fromJson(json.decode(str));

String newKankotriDataToJson(NewKankotriData data) => json.encode(data.toJson());

class NewKankotriData {
    NewKankotriData({
        this.status,
        this.message,
    });

    int? status;
    String? message;

    factory NewKankotriData.fromJson(Map<String, dynamic> json) => NewKankotriData(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}