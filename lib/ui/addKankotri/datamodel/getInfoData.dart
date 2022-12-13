import 'dart:convert';

GetInfoData getInfoDataFromJson(String str) => GetInfoData.fromJson(json.decode(str));

String getInfoDataToJson(GetInfoData data) => json.encode(data.toJson());

class GetInfoData {
    GetInfoData({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    Result? result;

    factory GetInfoData.fromJson(Map<String, dynamic> json) => GetInfoData(
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
        this.invitationMessages,
        this.godDetails,
        this.chirPings,
    });

    List<ChirpingInfo>? invitationMessages;
    List<GodDetailInfo>? godDetails;
    List<ChirpingInfo>? chirPings;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        invitationMessages: List<ChirpingInfo>.from(json["invitationMessages"].map((x) => ChirpingInfo.fromJson(x))),
        godDetails: List<GodDetailInfo>.from(json["godDetails"].map((x) => GodDetailInfo.fromJson(x))),
        chirPings: List<ChirpingInfo>.from(json["chirpings"].map((x) => ChirpingInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "invitationMessages": List<dynamic>.from(invitationMessages!.map((x) => x.toJson())),
        "godDetails": List<dynamic>.from(godDetails!.map((x) => x.toJson())),
        "chirpings": List<dynamic>.from(chirPings!.map((x) => x.toJson())),
    };
}

class ChirpingInfo {
    ChirpingInfo({
        this.id,
        this.value,
        this.html,
        this.type,
    });

    String? id;
    String? value;
    String? html;
    String? type;

    factory ChirpingInfo.fromJson(Map<String, dynamic> json) => ChirpingInfo(
        id: json["_id"],
        value: json["value"],
        html: json["html"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "value": value,
        "html": html,
        "type": type,
    };
}

class GodDetailInfo {
    GodDetailInfo({
        this.id,
        this.godDetailId,
        this.name,
        this.image,
    });

    String? id;
    String? godDetailId;
    String? name;
    String? image;

    factory GodDetailInfo.fromJson(Map<String, dynamic> json) => GodDetailInfo(
        id: json["_id"],
        godDetailId: json["id"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id": godDetailId,
        "name": name,
        "image": image,
    };
}
