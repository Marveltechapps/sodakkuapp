  // To parse this JSON data, do
  //
  //     final subCategory = subCategoryFromJson(jsonString);

  import 'dart:convert';

  SubCategory subCategoryFromJson(String str) => SubCategory.fromJson(json.decode(str));

  String subCategoryToJson(SubCategory data) => json.encode(data.toJson());

  class SubCategory {
      String? message;
      List<Datum>? data;

      SubCategory({
          this.message,
          this.data,
      });

      factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
          message: json["message"],
          data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

      Map<String, dynamic> toJson() => {
          "message": message,
          "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
  }

  class Datum {
      String? id;
      String? name;
      String? imageUrl;
      String? categoryId;
      String? categoryName;

      Datum({
          this.id,
          this.name,
          this.imageUrl,
          this.categoryId,
          this.categoryName,
      });

      factory Datum.fromJson(Map<String, dynamic> json) => Datum(
          id: json["_id"],
          name: json["name"],
          imageUrl: json["imageUrl"],
          categoryId: json["category_id"],
          categoryName: json["category_name"],
      );

      Map<String, dynamic> toJson() => {
          "_id": id,
          "name": name,
          "imageUrl": imageUrl,
          "category_id": categoryId,
          "category_name": categoryName,
      };
  }
