import 'dart:convert';

SimilarProductDetailResponse similarProductDetailResponseFromJson(String str) =>
    SimilarProductDetailResponse.fromJson(json.decode(str));

String similarProductDetailResponseToJson(SimilarProductDetailResponse data) =>
    json.encode(data.toJson());

class SimilarProductDetailResponse {
  int? status;
  String? message;
  Data? data;

  SimilarProductDetailResponse({
    this.status,
    this.message,
    this.data,
  });

  factory SimilarProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      SimilarProductDetailResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Description? description;
  String? id;
  Data? productId;
  String? skuCode;
  String? skuName;
  String? label;
  int? price;
  int? discountPrice;
  String? offer;
  String? imageUrl;
  String? skuClassification;
  String? skuClassification1;
  String? createdAt;
  String? updatedAt;
  int? v;
  List<Variant>? variants;
  String? subCategoryId;
  String? mainCategoryId;

  Data({
    this.description,
    this.id,
    this.productId,
    this.skuCode,
    this.skuName,
    this.label,
    this.price,
    this.discountPrice,
    this.offer,
    this.imageUrl,
    this.skuClassification,
    this.skuClassification1,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.variants,
    this.subCategoryId,
    this.mainCategoryId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        description: json["description"] == null
            ? null
            : Description.fromJson(json["description"]),
        id: json["_id"],
        productId: json["product_id"] == null
            ? null
            : Data.fromJson(json["product_id"]),
        skuCode: json["SKUCode"],
        skuName: json["SKUName"],
        label: json["label"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        offer: json["offer"],
        imageUrl: json["imageURL"],
        skuClassification: json["SKUClassification"],
        skuClassification1: json["SKUClassification1"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
        subCategoryId: json["subCategory_id"],
        mainCategoryId: json["main_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "description": description?.toJson(),
        "_id": id,
        "product_id": productId?.toJson(),
        "SKUCode": skuCode,
        "SKUName": skuName,
        "label": label,
        "price": price,
        "discountPrice": discountPrice,
        "offer": offer,
        "imageURL": imageUrl,
        "SKUClassification": skuClassification,
        "SKUClassification1": skuClassification1,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "subCategory_id": subCategoryId,
        "main_category_id": mainCategoryId,
      };
}

class Description {
  String? about;
  String? healthBenefits;
  String? nutrition;
  String? origin;

  Description({
    this.about,
    this.healthBenefits,
    this.nutrition,
    this.origin,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        about: json["about"],
        healthBenefits: json["healthBenefits"],
        nutrition: json["nutrition"],
        origin: json["origin"],
      );

  Map<String, dynamic> toJson() => {
        "about": about,
        "healthBenefits": healthBenefits,
        "nutrition": nutrition,
        "origin": origin,
      };
}

class Variant {
  ComboDetails? comboDetails;
  String? label;
  int? price;
  int? discountPrice;
  String? offer;
  bool? isComboPack;
  bool? isMultiPack;
  int? stockQuantity;
  bool? isOutOfStock;
  String? imageUrl;
  int? cartQuantity;
  String? id;

  Variant({
    this.comboDetails,
    this.label,
    this.price,
    this.discountPrice,
    this.offer,
    this.isComboPack,
    this.isMultiPack,
    this.stockQuantity,
    this.isOutOfStock,
    this.imageUrl,
    this.cartQuantity,
    this.id,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        comboDetails: json["comboDetails"] == null
            ? null
            : ComboDetails.fromJson(json["comboDetails"]),
        label: json["label"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        offer: json["offer"],
        isComboPack: json["isComboPack"],
        isMultiPack: json["isMultiPack"],
        stockQuantity: json["stockQuantity"],
        isOutOfStock: json["isOutOfStock"],
        imageUrl: json["imageURL"],
        cartQuantity: json["cartQuantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "comboDetails": comboDetails?.toJson(),
        "label": label,
        "price": price,
        "discountPrice": discountPrice,
        "offer": offer,
        "isComboPack": isComboPack,
        "isMultiPack": isMultiPack,
        "stockQuantity": stockQuantity,
        "isOutOfStock": isOutOfStock,
        "imageURL": imageUrl,
        "cartQuantity": cartQuantity,
        "_id": id,
      };
}

class ComboDetails {
  List<String>? productNames;
  List<String>? childSkuCodes;
  String? comboName;
  String? comboImageUrl;

  ComboDetails({
    this.productNames,
    this.childSkuCodes,
    this.comboName,
    this.comboImageUrl,
  });

  factory ComboDetails.fromJson(Map<String, dynamic> json) => ComboDetails(
        productNames: json["productNames"] == null
            ? []
            : List<String>.from(json["productNames"]!.map((x) => x)),
        childSkuCodes: json["childSkuCodes"] == null
            ? []
            : List<String>.from(json["childSkuCodes"]!.map((x) => x)),
        comboName: json["comboName"],
        comboImageUrl: json["comboImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "productNames": productNames == null
            ? []
            : List<dynamic>.from(productNames!.map((x) => x)),
        "childSkuCodes": childSkuCodes == null
            ? []
            : List<dynamic>.from(childSkuCodes!.map((x) => x)),
        "comboName": comboName,
        "comboImageURL": comboImageUrl,
      };
}
