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

    List<InvitationMessage>? invitationMessages;
    List<GodDetailInfo>? godDetails;
    // List<InvitationMessage>? chirPings;
    List<ChirpingInfo>? chirPings;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        invitationMessages: List<InvitationMessage>.from(json["invitationMessages"].map((x) => InvitationMessage.fromJson(x))),
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
        this.previewText,
        this.html,
    });

    String? id;
    String? previewText;
    String? html;

    factory ChirpingInfo.fromJson(Map<String, dynamic> json) => ChirpingInfo(
        id: json["_id"],
        previewText: json["previewText"],
        html: json["html"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "previewText": previewText,
        "html": html,
    };
}


class InvitationMessage {
    InvitationMessage({
        this.id,
        this.values,
        this.html,
        this.type,
        this.marriageOf,
        this.previewText,
    });

    String? id;
    ValuesInfo? values = ValuesInfo();
    String? html;
    String? type;
    String? marriageOf;
    String? previewText;

    factory InvitationMessage.fromJson(Map<String, dynamic> json) => InvitationMessage(
        id: json["_id"],
        values: ValuesInfo.fromJson(json["values"]),
        html: json["html"],
        type: json["type"],
        marriageOf: json["marriageOf"],
        previewText: json["previewText"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "values": values!.toJson(),
        "html": html,
        "type": type,
        "marriageOf": marriageOf,
        "previewText": previewText,
    };
}

class ValuesInfo {
    ValuesInfo({
        this.motherName,
        this.fatherName,
        this.hometownName,
        this.date,
        this.day,
        this.godName,
    });

    String? motherName;
    String? fatherName;
    String? hometownName;
    String? date;
    String? day;
    String? godName;

    factory ValuesInfo.fromJson(Map<String, dynamic> json) => ValuesInfo(
        motherName: json["motherName"],
        fatherName: json["fatherName"],
        hometownName: json["hometownName"],
        date: json["date"],
        day: json["day"],
        godName: json["godName"],
    );

    Map<String, dynamic> toJson() => {
        "motherName": motherName,
        "fatherName": fatherName,
        "hometownName": hometownName,
        "date": date,
        "day": day,
        "godName": godName,
    };
}


class GodDetailInfo {
    GodDetailInfo({
        this.id,
        this.name,
        this.image,
    });

    String? id;
    String? name;
    String? image;
    bool isSelected = false;

    factory GodDetailInfo.fromJson(Map<String, dynamic> json) => GodDetailInfo(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
    };
}
