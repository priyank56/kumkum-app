import 'dart:convert';

LayoutDesignData layoutDesignDataFromJson(String str) => LayoutDesignData.fromJson(json.decode(str));

String layoutDesignDataToJson(LayoutDesignData data) => json.encode(data.toJson());

class LayoutDesignData {
    LayoutDesignData({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    List<ResultLayout>? result;

    factory LayoutDesignData.fromJson(Map<String, dynamic> json) => LayoutDesignData(
        status: json["status"],
        message: json["message"],
        result: List<ResultLayout>.from(json["result"].map((x) => ResultLayout.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class ResultLayout {
    ResultLayout({
        this.id,
        this.thumbnail,
        this.layoutDesignId,
        this.marriageInvitationCardType,
        this.isShow,
    });

    String? id;
    String? thumbnail;
    String? layoutDesignId;
    String? marriageInvitationCardType;
    bool? isShow;

    factory ResultLayout.fromJson(Map<String, dynamic> json) => ResultLayout(
        id: json["_id"],
        thumbnail: json["thumbnail"],
        layoutDesignId: json["layoutDesignId"],
        marriageInvitationCardType: json["marriageInvitationCardType"],
        isShow: json["isShow"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "thumbnail": thumbnail,
        "layoutDesignId": layoutDesignId,
        "marriageInvitationCardType": marriageInvitationCardType,
        "isShow": isShow,
    };
}
