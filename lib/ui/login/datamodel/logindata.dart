// To parse this JSON data, do
//
//     final aboutData = aboutDataFromJson(jsonString);

import 'dart:convert';

LoginData aboutDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String aboutDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
    LoginData({
        this.message,
        this.success,
        this.statusCode,
        this.data,
    });

    String? message;
    bool? success;
    int? statusCode;
    List<Datum>? data;

    factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        message: json["message"],
        success: json["success"],
        statusCode: json["status_code"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "status_code": statusCode,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.order,
        this.translations,
        this.images,
    });

    int? id;
    int? order;
    Translations? translations;
    List<AboutUsImage>? images;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        order: json["order"],
        translations: json["translations"] == null ? null : Translations.fromJson(json["translations"]),
        images: json["images"] == null ? null : List<AboutUsImage>.from(json["images"].map((x) => AboutUsImage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order": order,
        "translations": translations == null ? null : translations!.toJson(),
        "images": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
    };
}

class AboutUsImage {
    AboutUsImage({
        this.type,
        this.imageUrl,
    });

    String? type;
    String? imageUrl;

    factory AboutUsImage.fromJson(Map<String, dynamic> json) => AboutUsImage(
        type: json["type"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "image_url": imageUrl,
    };
}

class Translations {
    Translations({
        this.en,
        this.ch,
    });

    Ch? en;
    Ch? ch;

    factory Translations.fromJson(Map<String, dynamic> json) => Translations(
        en: json["en"] == null ? null : Ch.fromJson(json["en"]),
        ch: json["ch"] == null ? null : Ch.fromJson(json["ch"]),
    );

    Map<String, dynamic> toJson() => {
        "en": en == null ? null : en!.toJson(),
        "ch": ch == null ? null : ch!.toJson(),
    };
}

class Ch {
    Ch({
        this.title,
        this.description,
    });

    String? title;
    String? description;

    factory Ch.fromJson(Map<String, dynamic> json) => Ch(
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
    };
}
