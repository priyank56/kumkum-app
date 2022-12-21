import 'dart:convert';

NumbersData numbersDataFromJson(String str) => NumbersData.fromJson(json.decode(str));

String numbersDataToJson(NumbersData data) => json.encode(data.toJson());

class NumbersData {
    NumbersData({
        this.numberList,
    });

    List<NumberList>? numberList;

    factory NumbersData.fromJson(Map<String, dynamic> json) => NumbersData(
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
