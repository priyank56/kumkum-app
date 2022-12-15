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
        this.result,
    });

    int? status;
    String? message;
    List<ResultGet>? result;

    factory NewKankotriData.fromJson(Map<String, dynamic> json) => NewKankotriData(
        status: json["status"],
        message: json["message"],
        result: List<ResultGet>.from(json["result"].map((x) => ResultGet.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class ResultGet {
    ResultGet({
        this.marriageInvitationCardId,
        this.marriageInvitationCardName,
        this.email,
        this.marriageInvitationCard,
        this.marriageInvitationCardType,
        this.layoutDesignId,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String? marriageInvitationCardId;
    String? marriageInvitationCardName;
    String? email;
    MarriageInvitationCardRes? marriageInvitationCard;
    String? marriageInvitationCardType;
    String? layoutDesignId;
    String? id;
    String? createdAt;
    String? updatedAt;
    int? v;

    factory ResultGet.fromJson(Map<String, dynamic> json) => ResultGet(
        marriageInvitationCardId: json["marriageInvitationCardId"],
        marriageInvitationCardName: json["marriageInvitationCardName"],
        email: json["email"],
        marriageInvitationCard: MarriageInvitationCardRes.fromJson(json["marriageInvitationCard"]),
        marriageInvitationCardType: json["marriageInvitationCardType"],
        layoutDesignId: json["layoutDesignId"],
        id: json["_id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "marriageInvitationCardId": marriageInvitationCardId,
        "marriageInvitationCardName": marriageInvitationCardName,
        "email": email,
        "marriageInvitationCard": marriageInvitationCard!.toJson(),
        "marriageInvitationCardType": marriageInvitationCardType,
        "layoutDesignId": layoutDesignId,
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
    };
}

class MarriageInvitationCardRes {
    MarriageInvitationCardRes({
        this.coverImage,
        this.pair,
        this.guestName,
        this.inviter,
        this.functions,
        this.invitation,
        this.affectionate,
        this.ambitious,
        this.chirping,
        this.nephewGroup,
        this.uncleGroup,
        this.auspiciousPlace,
        this.auspiciousMarriagePlace,
        this.inviterSurname,
        this.godDetails,
    });

    CoverImageRes? coverImage;
    List<PairRes>? pair;
    dynamic guestName;
    InviterRes? inviter;
    List<FunctionsRes>? functions;
    InvitationRes? invitation;
    AffectionateRes? affectionate;
    AffectionateRes? ambitious;
    ChirpingRes? chirping;
    AffectionateRes? nephewGroup;
    AffectionateRes? uncleGroup;
    AuspiciousPlaceRes? auspiciousPlace;
    AuspiciousPlaceRes? auspiciousMarriagePlace;
    String? inviterSurname;
    List<GodDetailRes>? godDetails;

    factory MarriageInvitationCardRes.fromJson(Map<String, dynamic> json) => MarriageInvitationCardRes(
        coverImage: CoverImageRes.fromJson(json["coverImage"]),
        pair: List<PairRes>.from(json["pair"].map((x) => PairRes.fromJson(x))),
        guestName: json["guestName"],
        inviter: InviterRes.fromJson(json["inviter"]),
        functions: List<FunctionsRes>.from(json["functions"].map((x) => FunctionsRes.fromJson(x))),
        invitation: InvitationRes.fromJson(json["invitation"]),
        affectionate: AffectionateRes.fromJson(json["affectionate"]),
        ambitious: AffectionateRes.fromJson(json["ambitious"]),
        chirping: ChirpingRes.fromJson(json["chirping"]),
        nephewGroup: AffectionateRes.fromJson(json["nephewGroup"]),
        uncleGroup: AffectionateRes.fromJson(json["uncleGroup"]),
        auspiciousPlace: AuspiciousPlaceRes.fromJson(json["auspiciousPlace"]),
        auspiciousMarriagePlace: AuspiciousPlaceRes.fromJson(json["auspiciousMarriagePlace"]),
        inviterSurname: json["inviterSurname"],
        godDetails: List<GodDetailRes>.from(json["godDetails"].map((x) => GodDetailRes.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "coverImage": coverImage!.toJson(),
        "pair": List<dynamic>.from(pair!.map((x) => x.toJson())),
        "guestName": guestName,
        "inviter": inviter!.toJson(),
        "functions": List<dynamic>.from(functions!.map((x) => x.toJson())),
        "invitation": invitation!.toJson(),
        "affectionate": affectionate!.toJson(),
        "ambitious": ambitious!.toJson(),
        "chirping": chirping!.toJson(),
        "nephewGroup": nephewGroup!.toJson(),
        "uncleGroup": uncleGroup!.toJson(),
        "auspiciousPlace": auspiciousPlace!.toJson(),
        "auspiciousMarriagePlace": auspiciousMarriagePlace!.toJson(),
        "inviterSurname": inviterSurname,
        "godDetails": List<dynamic>.from(godDetails!.map((x) => x.toJson())),
    };
}

class AffectionateRes {
    AffectionateRes({
        this.title,
        this.list,
    });

    String? title;
    List<String>? list;

    factory AffectionateRes.fromJson(Map<String, dynamic> json) => AffectionateRes(
        title: json["title"],
        list: List<String>.from(json["list"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "list": List<dynamic>.from(list!.map((x) => x)),
    };
}

class AuspiciousPlaceRes {
    AuspiciousPlaceRes({
        this.title,
        this.inviterName,
        this.address,
        this.mapLink,
        this.contactNo,
    });

    String? title;
    String? inviterName;
    List<String>? address;
    dynamic mapLink;
    List<String>? contactNo;

    factory AuspiciousPlaceRes.fromJson(Map<String, dynamic> json) => AuspiciousPlaceRes(
        title: json["title"],
        inviterName: json["inviterName"],
        address: List<String>.from(json["address"].map((x) => x)),
        mapLink: json["mapLink"],
        contactNo: List<String>.from(json["contactNo"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "inviterName": inviterName,
        "address": List<dynamic>.from(address!.map((x) => x)),
        "mapLink": mapLink,
        "contactNo": List<dynamic>.from(contactNo!.map((x) => x)),
    };
}

class ChirpingRes {
    ChirpingRes({
        this.title,
        this.id,
        this.html,
        this.value,
        this.inviter,
    });

    dynamic title;
    dynamic id;
    dynamic html;
    dynamic value;
    dynamic inviter;

    factory ChirpingRes.fromJson(Map<String, dynamic> json) => ChirpingRes(
        title: json["title"],
        id: json["id"],
        html: json["html"],
        value: json["value"],
        inviter: json["inviter"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "html": html,
        "value": value,
        "inviter": inviter,
    };
}

class CoverImageRes {
    CoverImageRes({
        // this.isShow,
        this.url,
    });

    // bool? isShow = false;
    String? url;

    factory CoverImageRes.fromJson(Map<String, dynamic> json) => CoverImageRes(
        // isShow: json["isShow"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        // "isShow": isShow,
        "url": url,
    };
}

class FunctionsRes {
    FunctionsRes({
        this.functionId,
        this.functionName,
        this.functionDate,
        this.functionTime,
        this.message,
        this.inviter,
        this.banquetPerson,
        this.functionPlace,
    });

    String? functionId;
    dynamic functionName;
    String? functionDate;
    String? functionTime;
    String? message;
    List<String>? inviter;
    dynamic banquetPerson;
    String? functionPlace;

    factory FunctionsRes.fromJson(Map<String, dynamic> json) => FunctionsRes(
        functionId: json["functionId"],
        functionName: json["functionName"],
        functionDate: json["functionDate"],
        functionTime: json["functionTime"],
        message: json["message"],
        inviter: List<String>.from(json["inviter"].map((x) => x)),
        banquetPerson: json["banquetPerson"],
        functionPlace: json["functionPlace"],
    );

    Map<String, dynamic> toJson() => {
        "functionId": functionId,
        "functionName": functionName,
        "functionDate": functionDate,
        "functionTime": functionTime,
        "message": message,
        "inviter": List<dynamic>.from(inviter!.map((x) => x)),
        "banquetPerson": banquetPerson,
        "functionPlace": functionPlace,
    };
}

class GodDetailRes {
    GodDetailRes({
        this.id,
    });

    String? id;

    factory GodDetailRes.fromJson(Map<String, dynamic> json) => GodDetailRes(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}

class InvitationRes {
    InvitationRes({
        this.guestName,
        this.brideInviter,
        this.groomInviter,
    });

    dynamic guestName;
    BrideInviterRes? brideInviter;
    GroomInviterRes? groomInviter;

    factory InvitationRes.fromJson(Map<String, dynamic> json) => InvitationRes(
        guestName: json["guestName"],
        brideInviter: BrideInviterRes.fromJson(json["brideInviter"]),
        groomInviter: GroomInviterRes.fromJson(json["groomInviter"]),
    );

    Map<String, dynamic> toJson() => {
        "guestName": guestName,
        "brideInviter": brideInviter!.toJson(),
        "groomInviter": groomInviter!.toJson(),
    };
}

class BrideInviterRes {
    BrideInviterRes({
        this.value,
        this.type,
        this.html,
        this.values,
    });

    String? value;
    dynamic type;
    dynamic html;
    BrideInviterValuesRes? values;

    factory BrideInviterRes.fromJson(Map<String, dynamic> json) => BrideInviterRes(
        value: json["value"],
        type: json["type"],
        html: json["html"],
        values: BrideInviterValuesRes.fromJson(json["values"]),
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "type": type,
        "html": html,
        "values": values!.toJson(),
    };
}

class BrideInviterValuesRes {
    BrideInviterValuesRes({
        this.godName,
        this.motherName,
        this.fatherName,
        this.hometownName,
        this.date,
        this.day,
    });

    String? godName;
    String? motherName;
    String? fatherName;
    String? hometownName;
    String? date;
    String? day;

    factory BrideInviterValuesRes.fromJson(Map<String, dynamic> json) => BrideInviterValuesRes(
        godName: json["godName"],
        motherName: json["motherName"],
        fatherName: json["fatherName"],
        hometownName: json["hometownName"],
        date: json["date"],
        day: json["day"],
    );

    Map<String, dynamic> toJson() => {
        "godName": godName,
        "motherName": motherName,
        "fatherName": fatherName,
        "hometownName": hometownName,
        "date": date,
        "day": day,
    };
}

class GroomInviterRes {
    GroomInviterRes({
        this.value,
        this.type,
        this.html,
        this.values,
    });

    String? value;
    dynamic type;
    dynamic html;
    GroomInviterValuesRes? values;

    factory GroomInviterRes.fromJson(Map<String, dynamic> json) => GroomInviterRes(
        value: json["value"],
        type: json["type"],
        html: json["html"],
        values: GroomInviterValuesRes.fromJson(json["values"]),
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "type": type,
        "html": html,
        "values": values!.toJson(),
    };
}

class GroomInviterValuesRes {
    GroomInviterValuesRes({
        this.godName,
        this.motherName,
        this.fatherName,
        this.hometownName,
        this.date,
        this.day,
    });

    String? godName;
    String? motherName;
    String? fatherName;
    String? hometownName;
    String? date;
    String? day;

    factory GroomInviterValuesRes.fromJson(Map<String, dynamic> json) => GroomInviterValuesRes(
        godName: json["godName"],
        motherName: json["motherName"],
        fatherName: json["fatherName"],
        hometownName: json["hometownName"],
        date: json["date"],
        day: json["day"],
    );

    Map<String, dynamic> toJson() => {
        "godName": godName,
        "motherName": motherName,
        "fatherName": fatherName,
        "hometownName": hometownName,
        "date": date,
        "day": day,
    };
}

class InviterRes {
    InviterRes({
        this.name,
        this.address,
        this.mapLink,
        this.contactNo,
    });

    List<String>? name;
    List<String>? address;
    String? mapLink;
    List<String>? contactNo;

    factory InviterRes.fromJson(Map<String, dynamic> json) => InviterRes(
        name: List<String>.from(json["name"].map((x) => x)),
        address: List<String>.from(json["address"].map((x) => x)),
        mapLink: json["mapLink"],
        contactNo: List<String>.from(json["contactNo"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": List<dynamic>.from(name!.map((x) => x)),
        "address": List<dynamic>.from(address!.map((x) => x)),
        "mapLink": mapLink,
        "contactNo": List<dynamic>.from(contactNo!.map((x) => x)),
    };
}

class PairRes {
    PairRes({
        this.bride,
        this.groom,
        this.marriageDate,
        this.enMarriageDate,
        this.marriageDay,
    });

    BrideRes? bride;
    BrideRes? groom;
    String? marriageDate;
    String? enMarriageDate;
    String? marriageDay;

    factory PairRes.fromJson(Map<String, dynamic> json) => PairRes(
        bride: BrideRes.fromJson(json["bride"]),
        groom: BrideRes.fromJson(json["groom"]),
        marriageDate: json["marriageDate"],
        enMarriageDate: json["enMarriageDate"],
        marriageDay: json["marriageDay"],
    );

    Map<String, dynamic> toJson() => {
        "bride": bride!.toJson(),
        "groom": groom!.toJson(),
        "marriageDate": marriageDate,
        "enMarriageDate": enMarriageDate,
        "marriageDay": marriageDay,
    };
}

class BrideRes {
    BrideRes({
        this.name,
        this.enName,
    });

    String? name;
    String? enName;

    factory BrideRes.fromJson(Map<String, dynamic> json) => BrideRes(
        name: json["name"],
        enName: json["enName"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "enName": enName,
    };
}
