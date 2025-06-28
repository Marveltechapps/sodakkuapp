// To parse this JSON data, do
//
//     final grabandEssential = grabandEssentialFromJson(jsonString);

import 'dart:convert';

GrabandEssential grabandEssentialFromJson(String str) => GrabandEssential.fromJson(json.decode(str));

String grabandEssentialToJson(GrabandEssential data) => json.encode(data.toJson());

class GrabandEssential {
    int? status;
    String? message;
    List<Datum>? data;

    GrabandEssential({
        this.status,
        this.message,
        this.data,
    });

    factory GrabandEssential.fromJson(Map<String, dynamic> json) => GrabandEssential(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? imageUrl;
    String? name;
    String? categoryId;
    String? createdAt;
    String? updatedAt;
    int? v;
    CategoryInfo? categoryInfo;

    Datum({
        this.id,
        this.imageUrl,
        this.name,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.categoryInfo,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        imageUrl: json["imageURL"],
        name: json["name"],
        categoryId: json["category_id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        categoryInfo: json["categoryInfo"] == null ? null : CategoryInfo.fromJson(json["categoryInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "imageURL": imageUrl,
        "name": name,
        "category_id": categoryId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "categoryInfo": categoryInfo?.toJson(),
    };
}

class CategoryInfo {
    String? categoryGroupTitle;
    Category? category;

    CategoryInfo({
        this.categoryGroupTitle,
        this.category,
    });

    factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
        categoryGroupTitle: json["categoryGroupTitle"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "categoryGroupTitle": categoryGroupTitle,
        "category": category?.toJson(),
    };
}

class Category {
    String? name;
    String? imageUrl;
    bool? isHighlight;
    int? index;
    String? id;
    String? createdAt;
    String? updatedAt;

    Category({
        this.name,
        this.imageUrl,
        this.isHighlight,
        this.index,
        this.id,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        imageUrl: json["imageUrl"],
        isHighlight: json["isHighlight"],
        index: json["index"],
        id: json["_id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "isHighlight": isHighlight,
        "index": index,
        "_id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}
