import 'dart:convert';

Banner bannerFromJson(String str) => Banner.fromJson(json.decode(str));

String bannerToJson(Banner data) => json.encode(data.toJson());

class Banner {
    int? status;
    String? message;
    int? count;
    List<BannerList>? data;

    Banner({
        this.status,
        this.message,
        this.count,
        this.data,
    });

    factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        data: json["data"] == null ? [] : List<BannerList>.from(json["data"]!.map((x) => BannerList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class BannerList {
    String? id;
    String? bannerType;
    String? imageUrl;
    String? createdAt;
    String? updatedAt;
    int? v;

    BannerList({
        this.id,
        this.bannerType,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
        id: json["_id"],
        bannerType: json["bannerType"],
        imageUrl: json["imageURL"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "bannerType": bannerType,
        "imageURL": imageUrl,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
    };
}
