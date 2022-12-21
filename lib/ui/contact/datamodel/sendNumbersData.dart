import 'dart:convert';

SendNumbersData sendNumbersDataFromJson(String str) => SendNumbersData.fromJson(json.decode(str));

String sendNumbersDataToJson(SendNumbersData data) => json.encode(data.toJson());

class SendNumbersData {
    SendNumbersData({
        this.invitationCardId,
        this.layoutDesignId,
        this.numberList,
    });

    String? invitationCardId;
    String? layoutDesignId;
    List<SendNumberList>? numberList;

    factory SendNumbersData.fromJson(Map<String, dynamic> json) => SendNumbersData(
        invitationCardId: json["invitationCardId"],
        layoutDesignId: json["layoutDesignId"],
        numberList: List<SendNumberList>.from(json["numberList"].map((x) => SendNumberList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "invitationCardId": invitationCardId,
        "layoutDesignId": layoutDesignId,
        "numberList": List<dynamic>.from(numberList!.map((x) => x.toJson())),
    };
}

class SendNumberList {
    SendNumberList({
        this.name,
        this.number,
        this.banquetPerson,
    });

    String? name;
    int? number;
    String? banquetPerson;

    factory SendNumberList.fromJson(Map<String, dynamic> json) => SendNumberList(
        name: json["name"],
        number: json["number"],
        banquetPerson: json["banquetPerson"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "banquetPerson": banquetPerson,
    };
}
