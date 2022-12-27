import 'dart:convert';

SendNumbersJsonData sendNumbersDataFromJson(String str) => SendNumbersJsonData.fromJson(json.decode(str));

String sendNumbersDataToJson(SendNumbersJsonData data) => json.encode(data.toJson());

class SendNumbersJsonData {
    SendNumbersJsonData({
        this.numberList,
    });

    List<SendNumberList>? numberList;

    factory SendNumbersJsonData.fromJson(Map<String, dynamic> json) => SendNumbersJsonData(
        numberList: List<SendNumberList>.from(json["numberList"].map((x) => SendNumberList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
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
    String? number;
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
