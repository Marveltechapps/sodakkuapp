import 'dart:convert';

SearchResponse searchResponseFromJson(String str) => SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
    int? status;
    String? message;
    List<Datum>? data;

    SearchResponse({
        this.status,
        this.message,
        this.data,
    });

    factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
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
    Description? description;
    String? id;
    String? skuCode;
    String? skuName;
    List<Variant>? variants;
    String? skuClassification;
    String? skuClassification1;
    CategoryId? subCategoryId;
    int? price;
    int? discountPrice;
    String? offer;
    String? createdAt;
    String? updatedAt;
    int? v;
    CategoryId? mainCategoryId;

    Datum({
        this.description,
        this.id,
        this.skuCode,
        this.skuName,
        this.variants,
        this.skuClassification,
        this.skuClassification1,
        this.subCategoryId,
        this.price,
        this.discountPrice,
        this.offer,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.mainCategoryId,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        description: json["description"] == null ? null : Description.fromJson(json["description"]),
        id: json["_id"],
        skuCode: json["SKUCode"],
        skuName: json["SKUName"],
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
        skuClassification: json["SKUClassification"],
        skuClassification1: json["SKUClassification1"],
        subCategoryId: json["subCategory_id"] == null ? null : CategoryId.fromJson(json["subCategory_id"]),
        price: json["price"],
        discountPrice: json["discountPrice"],
        offer: json["offer"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        mainCategoryId: json["main_category_id"] == null ? null : CategoryId.fromJson(json["main_category_id"]),
    );

    Map<String, dynamic> toJson() => {
        "description": description?.toJson(),
        "_id": id,
        "SKUCode": skuCode,
        "SKUName": skuName,
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "SKUClassification": skuClassification,
        "SKUClassification1": skuClassification1,
        "subCategory_id": subCategoryId?.toJson(),
        "price": price,
        "discountPrice": discountPrice,
        "offer": offer,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "main_category_id": mainCategoryId?.toJson(),
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

class CategoryId {
    String? id;
    String? name;
    String? imageUrl;
    String? createdAt;
    String? updatedAt;
    int? v;
    String? mainCategoryId;

    CategoryId({
        this.id,
        this.name,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.mainCategoryId,
    });

    factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["_id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        mainCategoryId: json["main_category_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "imageUrl": imageUrl,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "main_category_id": mainCategoryId,
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
        comboDetails: json["comboDetails"] == null ? null : ComboDetails.fromJson(json["comboDetails"]),
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
        productNames: json["productNames"] == null ? [] : List<String>.from(json["productNames"]!.map((x) => x)),
        childSkuCodes: json["childSkuCodes"] == null ? [] : List<String>.from(json["childSkuCodes"]!.map((x) => x)),
        comboName: json["comboName"],
        comboImageUrl: json["comboImageURL"],
    );

    Map<String, dynamic> toJson() => {
        "productNames": productNames == null ? [] : List<dynamic>.from(productNames!.map((x) => x)),
        "childSkuCodes": childSkuCodes == null ? [] : List<dynamic>.from(childSkuCodes!.map((x) => x)),
        "comboName": comboName,
        "comboImageURL": comboImageUrl,
    };
}
