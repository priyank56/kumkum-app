import 'dart:convert';

SendNumbersData sendNumbersDataFromJson(String str) => SendNumbersData.fromJson(json.decode(str));

String sendNumbersDataToJson(SendNumbersData data) => json.encode(data.toJson());

class SendNumbersData {
    SendNumbersData({
        this.status,
        this.message,
    });

    int? status;
    String? message;

    factory SendNumbersData.fromJson(Map<String, dynamic> json) => SendNumbersData(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
