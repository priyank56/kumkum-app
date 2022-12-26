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
        this.marriageInvitationCardId,
        this.marriageInvitationCardName,
        this.userId,
        this.marriageInvitationCardType,
        this.layoutDesignId,
        this.isGroom,
    });

    String? previewUrl;
    String? marriageInvitationCardId;
    String? marriageInvitationCardName;
    String? userId;
    String? marriageInvitationCardType;
    String? layoutDesignId;
    bool? isGroom;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        previewUrl: json["previewUrl"],
        marriageInvitationCardId: json["marriageInvitationCardId"],
        marriageInvitationCardName: json["marriageInvitationCardName"],
        userId: json["userId"],
        marriageInvitationCardType: json["marriageInvitationCardType"],
        layoutDesignId: json["layoutDesignId"],
        isGroom: json["isGroom"],
    );

    Map<String, dynamic> toJson() => {
        "previewUrl": previewUrl,
        "marriageInvitationCardId": marriageInvitationCardId,
        "marriageInvitationCardName": marriageInvitationCardName,
        "userId": userId,
        "marriageInvitationCardType": marriageInvitationCardType,
        "layoutDesignId": layoutDesignId,
        "isGroom": isGroom,
    };
}