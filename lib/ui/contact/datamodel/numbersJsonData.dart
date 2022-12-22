import 'dart:convert';

NumbersJsonData numbersDataFromJson(String str) => NumbersJsonData.fromJson(json.decode(str));

String numbersDataToJson(NumbersJsonData data) => json.encode(data.toJson());

class NumbersJsonData {
    NumbersJsonData({
        this.numberList,
    });

    List<NumberList>? numberList;

    factory NumbersJsonData.fromJson(Map<String, dynamic> json) => NumbersJsonData(
        numberList: List<NumberList>.from(json["numberList"].map((x) => NumberList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "numberList": List<dynamic>.from(numberList!.map((x) => x.toJson())),
    };
}

class NumberList {
    NumberList({
        this.name,
        this.number,
        this.banquetPerson,
    });

    String? name;
    int? number;
    String? banquetPerson;

    factory NumberList.fromJson(Map<String, dynamic> json) => NumberList(
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
