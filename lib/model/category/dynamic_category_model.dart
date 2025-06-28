// To parse this JSON data, do
//
//     final dynamicCategories = dynamicCategoriesFromJson(jsonString);

import 'dart:convert';

DynamicCategories dynamicCategoriesFromJson(String str) => DynamicCategories.fromJson(json.decode(str));

String dynamicCategoriesToJson(DynamicCategories data) => json.encode(data.toJson());

class DynamicCategories {
    bool? success;
    List<Datum>? data;

    DynamicCategories({
        this.success,
        this.data,
    });

    factory DynamicCategories.fromJson(Map<String, dynamic> json) => DynamicCategories(
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? categoryTitleName;
    List<Category>? categories;
    String? createdAt;
    String? updatedAt;
    int? v;

    Datum({
        this.id,
        this.categoryTitleName,
        this.categories,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        categoryTitleName: json["category_title_name"],
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "category_title_name": categoryTitleName,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
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
