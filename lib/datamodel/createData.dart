/*import 'dart:convert';

CreateData createDataFromJson(String str) => CreateData.fromJson(json.decode(str));

String createDataToJson(CreateData data) => json.encode(data.toJson());

class CreateData {
    CreateData({
        this.marriageInvitationCardId,
        this.marriageInvitationCardName,
        this.email,
        this.marriageInvitationCard,
        this.marriageInvitationCardType,
        this.layoutDesignId,
    });

    String? marriageInvitationCardId = "";
    String? marriageInvitationCardName = "";
    String? email = "";
    MarriageInvitationCard? marriageInvitationCard = MarriageInvitationCard();
    String? marriageInvitationCardType = "";
    String? layoutDesignId = "";

    factory CreateData.fromJson(Map<String, dynamic> json) => CreateData(
        marriageInvitationCardId: json["marriageInvitationCardId"],
        marriageInvitationCardName: json["marriageInvitationCardName"],
        email: json["email"],
        marriageInvitationCard: MarriageInvitationCard.fromJson(json["marriageInvitationCard"]),
        marriageInvitationCardType: json["marriageInvitationCardType"],
        layoutDesignId: json["layoutDesignId"],
    );

    Map<String, dynamic> toJson() => {
        "marriageInvitationCardId": marriageInvitationCardId,
        "marriageInvitationCardName": marriageInvitationCardName,
        "email": email,
        "marriageInvitationCard": marriageInvitationCard!.toJson(),
        "marriageInvitationCardType": marriageInvitationCardType,
        "layoutDesignId": layoutDesignId,
    };
}

class MarriageInvitationCard {
    MarriageInvitationCard({
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

  CoverImage? coverImage = CoverImage();
  List<Pair>? pair = [Pair()];
  String? guestName = "";
  InviterClass? inviter = InviterClass();
  List<Functions>? functions = [Functions()];
  Invitation? invitation = Invitation();
  Affectionate? affectionate = Affectionate();
  Affectionate? ambitious = Affectionate();
  Affectionate? nephewGroup = Affectionate();
  Affectionate? uncleGroup = Affectionate();
  AuspiciousPlace? auspiciousPlace = AuspiciousPlace();
  AuspiciousPlace? auspiciousMarriagePlace = AuspiciousPlace();
  Chirping? chirping = Chirping();
  String? inviterSurname;
  List<GodDetail>? godDetails = [GodDetail()];

  factory MarriageInvitationCard.fromJson(Map<String, dynamic> json) => MarriageInvitationCard(
        coverImage: CoverImage.fromJson(json["coverImage"]),
        pair: List<Pair>.from(json["pair"].map((x) => Pair.fromJson(x))),
        guestName: json["guestName"],
        inviter: InviterClass.fromJson(json["inviter"]),
        functions: List<Functions>.from(json["functions"].map((x) => Functions.fromJson(x))),
        invitation: Invitation.fromJson(json["invitation"]),
        affectionate: Affectionate.fromJson(json["affectionate"]),
        ambitious: Affectionate.fromJson(json["ambitious"]),
        chirping: Chirping.fromJson(json["chirping"]),
        nephewGroup: Affectionate.fromJson(json["nephewGroup"]),
        uncleGroup: Affectionate.fromJson(json["uncleGroup"]),
        auspiciousPlace: AuspiciousPlace.fromJson(json["auspiciousPlace"]),
        auspiciousMarriagePlace: AuspiciousPlace.fromJson(json["auspiciousMarriagePlace"]),
        inviterSurname: json["inviterSurname"],
        godDetails: List<GodDetail>.from(json["godDetails"].map((x) => GodDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "coverImage": coverImage!.toJson(),
        // "pair": List<Pair>.from(pair!.map((x) => x.toJson())),
        "pair": jsonEncode(pair!.map((e) => e.toJson()).toList()),
        "guestName": guestName,
        "inviter": inviter!.toJson(),
        // "functions": List<Functions>.from(functions!.map((x) => x.toJson())),
        "functions": jsonEncode(functions!.map((e) => e.toJson()).toList()),
        "invitation": invitation!.toJson(),
        "affectionate": affectionate!.toJson(),
        "ambitious": ambitious!.toJson(),
        "chirping": chirping!.toJson(),
        "nephewGroup": nephewGroup!.toJson(),
        "uncleGroup": uncleGroup!.toJson(),
        "auspiciousPlace": auspiciousPlace!.toJson(),
        "auspiciousMarriagePlace": auspiciousMarriagePlace!.toJson(),
        "inviterSurname": inviterSurname,
        // "godDetails": List<GodDetail>.from(godDetails!.map((x) => x.toJson())),
        "godDetails":  jsonEncode(godDetails!.map((e) => e.toJson()).toList()),
    };
}

class Affectionate {
    Affectionate({
        this.title,
        this.list,
    });

    String? title;
    List<String>? list = [];

    factory Affectionate.fromJson(Map<String, dynamic> json) => Affectionate(
        title: json["title"],
        list: json["list"] == null ? null : List<String>.from(json["list"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "list": list == null ? null : List<dynamic>.from(list!.map((x) => x)),
    };
}


class AuspiciousPlace {
    AuspiciousPlace({
        this.title,
        this.inviterName,
        this.address,
        this.mapLink,
        this.contactNo,
    });

    String? title;
    String? inviterName;
    List<String>? address= [];
    String? mapLink;
    List<String>? contactNo = [];

    factory AuspiciousPlace.fromJson(Map<String, dynamic> json) => AuspiciousPlace(
        title: json["title"],
        inviterName: json["inviterName"],
        address: List<String>.from(json["address"].map((x) => x)),
        mapLink: json["mapLink"],
        contactNo: json["contactNo"] == null ? null : List<String>.from(json["contactNo"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "inviterName": inviterName,
        "address": List<dynamic>.from(address!.map((x) => x)),
        "mapLink": mapLink,
        "contactNo": contactNo == null ? null : List<dynamic>.from(contactNo!.map((x) => x)),
    };
}

class Chirping {
    Chirping({
        this.title,
        this.id,
        this.html,
        this.value,
        this.inviter,
    });

    String? title;
    String? id;
    String? html;
    String? value;
    String? inviter;

    factory Chirping.fromJson(Map<String, dynamic> json) => Chirping(
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

class CoverImage {
    CoverImage({
        this.isShow,
        this.url,
    });

    bool? isShow = false;
    String? url = "";

    factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
        isShow: json["isShow"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "isShow": isShow,
        "url": url,
    };
}

class Functions {
    Functions({
        this.functionId,
        this.functionName,
        this.functionDate,
        this.functionTime,
        this.message,
        this.inviter,
        this.banquetPerson,
        this.functionPlace,
    });

    String? functionId = "";
    String? functionName= "";
    String? functionDate= "";
    String? functionTime= "";
    String? message= "";
    List<String>? inviter = [];
    String? banquetPerson= "";
    String? functionPlace= "";

    factory Functions.fromJson(Map<String, dynamic> json) => Functions(
        functionId: json["functionId"],
        functionName: json["functionName"],
        functionDate: json["functionDate"],
        functionTime: json["functionTime"],
        message: json["message"],
        inviter: json["inviter"] == null ? null : List<String>.from(json["inviter"].map((x) => x)),
        banquetPerson: json["banquetPerson"],
        functionPlace: json["functionPlace"],
    );

    Map<String, dynamic> toJson() => {
        "functionId": functionId,
        "functionName": functionName,
        "functionDate": functionDate,
        "functionTime": functionTime,
        "message": message,
        "inviter": inviter == null ? null : List<dynamic>.from(inviter!.map((x) => x)),
        "banquetPerson": banquetPerson,
        "functionPlace": functionPlace,
    };
}

class GodDetail {
    GodDetail({
        this.id,
    });

    String? id;

    factory GodDetail.fromJson(Map<String, dynamic> json) => GodDetail(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}

class Invitation {
    Invitation({
        this.guestName,
        this.brideInviter,
        this.groomInviter,
    });

    String? guestName;
    BrideInviter? brideInviter = BrideInviter();
    GroomInviter? groomInviter = GroomInviter();

    factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
        guestName: json["guestName"],
        brideInviter: BrideInviter.fromJson(json["brideInviter"]),
        groomInviter: GroomInviter.fromJson(json["groomInviter"]),
    );

    Map<String, dynamic> toJson() => {
        "guestName": guestName,
        "brideInviter": brideInviter!.toJson(),
        "groomInviter": groomInviter!.toJson(),
    };
}

class BrideInviter {
    BrideInviter({
        this.value,
        this.type,
        this.html,
        this.values,
    });

    String? value;
    String? type;
    String? html;
    BrideInviterValues? values = BrideInviterValues();

    factory BrideInviter.fromJson(Map<String, dynamic> json) => BrideInviter(
        value: json["value"],
        type: json["type"],
        html: json["html"],
        values: BrideInviterValues.fromJson(json["values"]),
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "type": type,
        "html": html,
        "values": values!.toJson(),
    };
}

class BrideInviterValues {
    BrideInviterValues({
        this.motherName,
        this.fatherName,
        this.hometownName,
        this.date,
        this.day,
    });

    String? motherName;
    String? fatherName;
    String? hometownName;
    String? date;
    String? day;

    factory BrideInviterValues.fromJson(Map<String, dynamic> json) => BrideInviterValues(
        motherName: json["motherName"],
        fatherName: json["fatherName"],
        hometownName: json["hometownName"],
        date: json["date"],
        day: json["day"],
    );

    Map<String, dynamic> toJson() => {
        "motherName": motherName,
        "fatherName": fatherName,
        "hometownName": hometownName,
        "date": date,
        "day": day,
    };
}

class GroomInviter {
    GroomInviter({
        this.value,
        this.type,
        this.html,
        this.values,
    });

    String? value;
    String? type;
    String? html;
    GroomInviterValues? values;

    factory GroomInviter.fromJson(Map<String, dynamic> json) => GroomInviter(
        value: json["value"],
        type: json["type"],
        html: json["html"],
        values: GroomInviterValues.fromJson(json["values"]),
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "type": type,
        "html": html,
        "values": values!.toJson(),
    };
}

class GroomInviterValues {
    GroomInviterValues({
        this.godName,
        this.motherName,
        this.fatherName,
        this.hometownName,
    });

    String? godName;
    String? motherName;
    String? fatherName;
    String? hometownName;

    factory GroomInviterValues.fromJson(Map<String, dynamic> json) => GroomInviterValues(
        godName: json["godName"],
        motherName: json["motherName"],
        fatherName: json["fatherName"],
        hometownName: json["hometownName"],
    );

    Map<String, dynamic> toJson() => {
        "godName": godName,
        "motherName": motherName,
        "fatherName": fatherName,
        "hometownName": hometownName,
    };
}

class InviterClass {
    InviterClass({
        this.name,
        this.address,
        this.mapLink,
        this.contactNo,
    });

    List<String>? name = [];
    List<String>? address = [];
    String? mapLink;
    List<String>? contactNo = [];

    factory InviterClass.fromJson(Map<String, dynamic> json) => InviterClass(
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

class Pair {
    Pair({
        this.bride,
        this.groom,
        this.marriageDate,
        this.enMarriageDate,
        this.marriageDay,
    });

    Bride? bride = Bride();
    Bride? groom = Bride();
    String? marriageDate;
    String? enMarriageDate;
    String? marriageDay;

    factory Pair.fromJson(Map<String, dynamic> json) => Pair(
        bride: Bride.fromJson(json["bride"]),
        groom: Bride.fromJson(json["groom"]),
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

class Bride {
    Bride({
        this.name,
        this.enName,
    });

    String? name;
    String? enName;

    factory Bride.fromJson(Map<String, dynamic> json) => Bride(
        name: json["name"],
        enName: json["enName"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "enName": enName,
    };
}*/

// To parse this JSON data, do
//
//     final createData = createDataFromJson(jsonString);

import 'dart:convert';

CreateData createDataFromJson(String str) => CreateData.fromJson(json.decode(str));

String createDataToJson(CreateData data) => json.encode(data.toJson());

class CreateData {
    CreateData({
        this.marriageInvitationCardId,
        this.marriageInvitationCardName,
        this.email,
        this.marriageInvitationCard,
        this.marriageInvitationCardType,
        this.layoutDesignId,
        this.isGroom,
    });

    String? marriageInvitationCardId;
    String? marriageInvitationCardName;
    String? email;
    MarriageInvitationCard? marriageInvitationCard;
    String? marriageInvitationCardType;
    String? layoutDesignId;
    bool? isGroom = true;

    factory CreateData.fromJson(Map<String, dynamic> json) => CreateData(
        marriageInvitationCardId: json["marriageInvitationCardId"],
        marriageInvitationCardName: json["marriageInvitationCardName"],
        email: json["email"],
        marriageInvitationCard: MarriageInvitationCard.fromJson(json["marriageInvitationCard"]),
        marriageInvitationCardType: json["marriageInvitationCardType"],
        layoutDesignId: json["layoutDesignId"],
        isGroom: json["isGroom"],
    );

    Map<String, dynamic> toJson() => {
        "marriageInvitationCardId": marriageInvitationCardId,
        "marriageInvitationCardName": marriageInvitationCardName,
        "email": email,
        "marriageInvitationCard": marriageInvitationCard!.toJson(),
        "marriageInvitationCardType": marriageInvitationCardType,
        "layoutDesignId": layoutDesignId,
        "isGroom": isGroom,
    };
}

class MarriageInvitationCard {
    MarriageInvitationCard({
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

    CoverImage? coverImage;
    List<Pair>? pair;
    String? guestName;
    InviterClass? inviter;
    List<Functions>? functions;
    Invitation? invitation;
    Affectionate? affectionate;
    Affectionate? ambitious;
    Chirping? chirping;
    Affectionate? nephewGroup;
    Affectionate? uncleGroup;
    AuspiciousPlace? auspiciousPlace;
    AuspiciousPlace? auspiciousMarriagePlace;
    String? inviterSurname;
    List<GodDetail>? godDetails;

    factory MarriageInvitationCard.fromJson(Map<String, dynamic> json) => MarriageInvitationCard(
        coverImage: CoverImage.fromJson(json["coverImage"]),
        pair: List<Pair>.from(json["pair"].map((x) => Pair.fromJson(x))),
        guestName: json["guestName"],
        inviter: InviterClass.fromJson(json["inviter"]),
        functions: List<Functions>.from(json["functions"].map((x) => Functions.fromJson(x))),
        invitation: Invitation.fromJson(json["invitation"]),
        affectionate: Affectionate.fromJson(json["affectionate"]),
        ambitious: Affectionate.fromJson(json["ambitious"]),
        chirping: Chirping.fromJson(json["chirping"]),
        nephewGroup: Affectionate.fromJson(json["nephewGroup"]),
        uncleGroup: Affectionate.fromJson(json["uncleGroup"]),
        auspiciousPlace: AuspiciousPlace.fromJson(json["auspiciousPlace"]),
        auspiciousMarriagePlace: AuspiciousPlace.fromJson(json["auspiciousMarriagePlace"]),
        inviterSurname: json["inviterSurname"],
        godDetails: List<GodDetail>.from(json["godDetails"].map((x) => GodDetail.fromJson(x))),
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

class Affectionate {
    Affectionate({
        this.title,
        this.list,
    });

    String? title;
    List<String>? list;

    factory Affectionate.fromJson(Map<String, dynamic> json) => Affectionate(
        title: json["title"],
        list: List<String>.from(json["address"].map((x) => x)),
        // list: List<ListElement>.from(json["list"].map((x) => listElementValues.map[x])),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        // "list": List<dynamic>.from(list.map((x) => listElementValues.reverse[x])),
        "list": List<String>.from(list!.map((x) => x)),
    };
}

/*enum ListElement { CANADA, EMPTY, POLAND, LIST, PURPLE, FLUFFY, USA, TENTACLED }

final listElementValues = EnumValues({
    "શ્રી જતીનભાઈ કેશવભાઈ બોરડા ( canada )": ListElement.CANADA,
    "શ્રી જતીનભાઈ કેશવભાઈ બોરડા": ListElement.EMPTY,
    "શ્રી દિનેશભાઈ રાઘ\u200bવભાઈ કાત્રોડીયા": ListElement.FLUFFY,
    "શ્રી નાગજીભાઈ દેવરાજભાઈ બોરડા": ListElement.LIST,
    "શ્રી નાગજીભાઈ દેવરાજભાઈ બોરડા ( Poland )": ListElement.POLAND,
    "શ્રી દિનેશભાઈ રાઘ\u200bવભાઈ કાત્રોડીયા ( રતનપર )": ListElement.PURPLE,
    "શ્રી સુરેશભાઈ કાળુભાઈ દેસાઈ": ListElement.TENTACLED,
    "શ્રી સુરેશભાઈ કાળુભાઈ દેસાઈ ( USA )": ListElement.USA
});*/

class AuspiciousPlace {
    AuspiciousPlace({
        this.title,
        this.inviterName,
        this.address,
        this.mapLink,
        this.contactNo,
    });

    String? title;
    String? inviterName;
    List<String>? address;
    String? mapLink;
    List<String>? contactNo;

    factory AuspiciousPlace.fromJson(Map<String, dynamic> json) => AuspiciousPlace(
        title: json["title"],
        inviterName: json["inviterName"],
        address: List<String>.from(json["address"].map((x) => x)),
        mapLink: json["mapLink"],
        // contactNo: json["contactNo"] == null ? null : List<String>.from(json["contactNo"].map((x) => x)),
        contactNo: List<String>.from(json["address"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "inviterName": inviterName,
        "address": List<String>.from(address!.map((x) => x)),
        "mapLink": mapLink,
        "contactNo": List<String>.from(contactNo!.map((x) => x)),
        // "contactNo": contactNo == null ? null : List<dynamic>.from(contactNo!.map((x) => x)),
    };
}

class Chirping {
    Chirping({
        this.title,
        this.id,
        this.html,
        this.previewText,
        this.inviter,
    });

    String? title;
    String? id;
    String? html;
    String? previewText;
    List<String>? inviter;

    factory Chirping.fromJson(Map<String, dynamic> json) => Chirping(
        title: json["title"],
        id: json["id"],
        html: json["html"],
        previewText: json["previewText"],
        // inviter: json["inviter"],
        inviter: List<String>.from(json["inviter"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "_id": id,
        "html": html,
        "previewText": previewText,
        // "inviter": inviter,
        "inviter": List<String>.from(inviter!.map((x) => x)),
    };
}

class CoverImage {
    CoverImage({
        this.isShow,
        this.url,
        this.id,
    });

    bool? isShow;
    String? url;
    String? id;

    factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
        isShow: json["isShow"],
        url: json["url"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "isShow": isShow,
        "url": url,
        "id": id,
    };
}

class Functions {
    Functions({
        this.functionId,
        this.functionName,
        this.functionDate,
        this.functionTime,
        this.functionEnTime,
        this.functionEnAmPm,
        this.message,
        this.inviter,
        this.banquetPerson,
        this.functionPlace,
        this.functionDay,
    });

    String? functionId;
    String? functionName;
    String? functionDate;
    String? functionTime;
    String? functionEnTime;
    String? functionEnAmPm;
    String? functionDay;
    String? message;
    List<String>? inviter;
    String? banquetPerson;
    String? functionPlace;

    factory Functions.fromJson(Map<String, dynamic> json) => Functions(
        functionId: json["functionId"],
        functionName: json["functionName"],
        functionDate: json["functionDate"],
        functionTime: json["functionTime"],
        message: json["message"],
        inviter: List<String>.from(json["inviter"].map((x) => x)),
        banquetPerson: json["banquetPerson"],
        functionPlace: json["functionPlace"],
        functionEnTime: json["functionEnTime"],
        functionEnAmPm: json["functionEnAmPm"],
        functionDay: json["functionDay"],
    );

    Map<String, dynamic> toJson() => {
        "functionId": functionId,
        "functionName": functionName,
        "functionDate": functionDate,
        "functionTime": functionTime,
        "message": message,
        "inviter": List<String>.from(inviter!.map((x) => x)),
        "banquetPerson": banquetPerson,
        "functionPlace": functionPlace,
        "functionDay": functionDay,
        "functionEnTime": functionEnTime,
        "functionEnAmPm": functionEnAmPm,
    };
}

/*enum InviterElement { EMPTY, INVITER }

final inviterElementValues = EnumValues({
    "ઉર્મિલાબેન સંજયભાઈ": InviterElement.EMPTY,
    "કલ્પનાબેન જશભાઈ": InviterElement.INVITER
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}*/


class GodDetail {
    /*GodDetail({
        this.id,
    });

    String? id;

    factory GodDetail.fromJson(Map<String, dynamic> json) => GodDetail(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };*/
    GodDetail({
        this.id,
        this.name,
        this.image,
    });

    String? id;
    String? name;
    String? image;

    factory GodDetail.fromJson(Map<String, dynamic> json) => GodDetail(
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

class Invitation {
    Invitation({
        this.guestName,
        this.brideInviter,
        this.groomInviter,
    });

    String? guestName;
    BrideInviter? brideInviter;
    GroomInviter? groomInviter;

    factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
        guestName: json["guestName"],
        brideInviter: BrideInviter.fromJson(json["brideInviter"]),
        groomInviter: GroomInviter.fromJson(json["groomInviter"]),
    );

    Map<String, dynamic> toJson() => {
        "guestName": guestName,
        "brideInviter": brideInviter!.toJson(),
        "groomInviter": groomInviter!.toJson(),
    };
}

class BrideInviter {
    BrideInviter({
        this.id,
        this.type,
        this.html,
        this.marriageOf,
        this.previewText,
        this.values,
    });

    String? id;
    String? type;
    String? html;
    String? marriageOf;
    String? previewText;
    BrideInviterValues? values;

    factory BrideInviter.fromJson(Map<String, dynamic> json) => BrideInviter(
        id: json["_id"],
        type: json["type"],
        html: json["html"],
        marriageOf: json["marriageOf"],
        previewText: json["previewText"],
        values: BrideInviterValues.fromJson(json["values"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "html": html,
        "marriageOf": marriageOf,
        "previewText": previewText,
        "values": values!.toJson(),
    };
}

class BrideInviterValues {
    BrideInviterValues({
        this.motherName,
        this.fatherName,
        this.hometownName,
        this.godName,
        this.gujaratiDate,
        this.date,
        this.day,
    });

    String? motherName;
    String? fatherName;
    String? hometownName;
    String? godName;
    String? gujaratiDate;
    String? date;
    String? day;

    factory BrideInviterValues.fromJson(Map<String, dynamic> json) => BrideInviterValues(
        godName: json["godName"],
        motherName: json["motherName"],
        fatherName: json["fatherName"],
        hometownName: json["hometownName"],
        gujaratiDate: json["gujratiDate"],
        date: json["date"],
        day: json["day"],
    );

    Map<String, dynamic> toJson() => {
        "godName": godName,
        "motherName": motherName,
        "fatherName": fatherName,
        "hometownName": hometownName,
        "gujratiDate": gujaratiDate,
        "date": date,
        "day": day,
    };
}

class GroomInviter {
    GroomInviter({
        this.id,
        this.type,
        this.html,
        this.previewText,
        this.marriageOf,
        this.values,
    });

    String? id;
    String? type;
    String? html;
    String? previewText;
    String? marriageOf;
    GroomInviterValues? values;

    factory GroomInviter.fromJson(Map<String, dynamic> json) => GroomInviter(
        id: json["_id"],
        type: json["type"],
        html: json["html"],
        previewText: json["previewText"],
        marriageOf: json["marriageOf"],
        values: GroomInviterValues.fromJson(json["values"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "html": html,
        "previewText": previewText,
        "marriageOf": marriageOf,
        "values": values!.toJson(),
    };
}

class GroomInviterValues {
    GroomInviterValues({
        this.godName,
        this.motherName,
        this.fatherName,
        this.hometownName,
        this.gujaratiDate,
        this.date,
        this.day,
    });

    String? godName;
    String? motherName;
    String? fatherName;
    String? hometownName;
    String? gujaratiDate;
    String? date;
    String? day;

    factory GroomInviterValues.fromJson(Map<String, dynamic> json) => GroomInviterValues(
        godName: json["godName"],
        motherName: json["motherName"],
        fatherName: json["fatherName"],
        hometownName: json["hometownName"],
        gujaratiDate: json["gujratiDate"],
        date: json["date"],
        day: json["day"],
    );

    Map<String, dynamic> toJson() => {
        "godName": godName,
        "motherName": motherName,
        "fatherName": fatherName,
        "hometownName": hometownName,
        "gujratiDate": gujaratiDate,
        "date": date,
        "day": day,
    };
}

class InviterClass {
    InviterClass({
        this.name,
        this.address,
        this.mapLink,
        this.contactNo,
    });

    List<String>? name;
    List<String>? address;
    String? mapLink;
    List<String>? contactNo;

    factory InviterClass.fromJson(Map<String, dynamic> json) => InviterClass(
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

class Pair {
    Pair({
        this.bride,
        this.groom,
        this.marriageDate,
        this.enMarriageDate,
        this.marriageDay,
    });

    Bride? bride;
    Bride? groom;
    String? marriageDate;
    String? enMarriageDate;
    String? marriageDay;

    factory Pair.fromJson(Map<String, dynamic> json) => Pair(
        bride: Bride.fromJson(json["bride"]),
        groom: Bride.fromJson(json["groom"]),
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

class Bride {
    Bride({
        this.name,
        this.enName,
    });

    String? name;
    String? enName;

    factory Bride.fromJson(Map<String, dynamic> json) => Bride(
        name: json["name"],
        enName: json["enName"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "enName": enName,
    };
}





