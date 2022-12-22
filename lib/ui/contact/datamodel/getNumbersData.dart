import 'dart:convert';

GetNumbersData getNumbersDataFromJson(String str) => GetNumbersData.fromJson(json.decode(str));

String getNumbersDataToJson(GetNumbersData data) => json.encode(data.toJson());

class GetNumbersData {
    GetNumbersData({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    Result? result;

    factory GetNumbersData.fromJson(Map<String, dynamic> json) => GetNumbersData(
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
        this.id,
        this.userId,
        this.numberList,
    });

    String? id;
    String? userId;
    List<SelectedNumberList>? numberList;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        userId: json["userId"],
        numberList: List<SelectedNumberList>.from(json["numberList"].map((x) => SelectedNumberList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "numberList": List<dynamic>.from(numberList!.map((x) => x.toJson())),
    };
}

class SelectedNumberList {
    SelectedNumberList({
        this.name,
        this.number,
        this.banquetPerson,
        this.id,
    });

    String? name;
    int? number;
    String? banquetPerson;
    String? id;

    factory SelectedNumberList.fromJson(Map<String, dynamic> json) => SelectedNumberList(
        name: json["name"],
        number: json["number"],
        banquetPerson: json["banquetPerson"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "banquetPerson": banquetPerson,
        "_id": id,
    };
}
