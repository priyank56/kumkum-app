import 'dart:convert';

SendPdfWpData sendPdfWpDataFromJson(String str) => SendPdfWpData.fromJson(json.decode(str));

String sendPdfWpDataToJson(SendPdfWpData data) => json.encode(data.toJson());

class SendPdfWpData {
    SendPdfWpData({
        this.name,
        this.number,
        this.functions,
    });

    String? name;
    String? number;
    List<SendPdfWpFunction>? functions;

    factory SendPdfWpData.fromJson(Map<String, dynamic> json) => SendPdfWpData(
        name: json["name"],
        number: json["number"],
        functions: List<SendPdfWpFunction>.from(json["functions"].map((x) => SendPdfWpFunction.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "functions": List<dynamic>.from(functions!.map((x) => x.toJson())),
    };
}

class SendPdfWpFunction {
    SendPdfWpFunction({
        this.functionId,
        this.banquetPerson,
    });

    String? functionId;
    String? banquetPerson;

    factory SendPdfWpFunction.fromJson(Map<String, dynamic> json) => SendPdfWpFunction(
        functionId: json["functionId"],
        banquetPerson: json["banquetPerson"],
    );

    Map<String, dynamic> toJson() => {
        "functionId": functionId,
        "banquetPerson": banquetPerson,
    };
}
