import 'dart:convert';

FunctionUploadData functionUploadDataFromJson(String str) => FunctionUploadData.fromJson(json.decode(str));

String functionUploadDataToJson(FunctionUploadData data) => json.encode(data.toJson());

class FunctionUploadData {
    FunctionUploadData({
        this.functions,
    });

    List<FunctionPreview>? functions;

    factory FunctionUploadData.fromJson(Map<String, dynamic> json) => FunctionUploadData(
        functions: List<FunctionPreview>.from(json["functions"].map((x) => FunctionPreview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "functions": List<dynamic>.from(functions!.map((x) => x.toJson())),
    };
}

class FunctionPreview {
    FunctionPreview({
        this.functionId,
        this.banquetPerson,
    });

    String? functionId;
    String? banquetPerson;

    factory FunctionPreview.fromJson(Map<String, dynamic> json) => FunctionPreview(
        functionId: json["functionId"],
        banquetPerson: json["banquetPerson"],
    );

    Map<String, dynamic> toJson() => {
        "functionId": functionId,
        "banquetPerson": banquetPerson,
    };
}
