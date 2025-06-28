// To parse this JSON data, do
//
//     final dynamicProductStyleResponse = dynamicProductStyleResponseFromJson(jsonString);

import 'dart:convert';

DynamicProductStyleResponse dynamicProductStyleResponseFromJson(String str) => DynamicProductStyleResponse.fromJson(json.decode(str));

String dynamicProductStyleResponseToJson(DynamicProductStyleResponse data) => json.encode(data.toJson());

class DynamicProductStyleResponse {
    bool? success;
    List<Datum>? data;

    DynamicProductStyleResponse({
        this.success,
        this.data,
    });

    factory DynamicProductStyleResponse.fromJson(Map<String, dynamic> json) => DynamicProductStyleResponse(
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
    String? displayName;
    List<Product>? products;
    String? createdAt;
    String? updatedAt;
    int? v;

    Datum({
        this.id,
        this.displayName,
        this.products,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        displayName: json["display_name"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "display_name": displayName,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
    };
}

class Product {
    Description? description;
    String? id;
    String? skuCode;
    String? skuName;
    List<Variant>? variants;
    String? skuClassification;
    String? skuClassification1;
    String? subCategoryId;
    int? price;
    int? discountPrice;
    String? offer;
    String? createdAt;
    String? updatedAt;
    int? v;
    String? categoryId;
    CartSummary? cartSummary;
    String? imageUrl;

    Product({
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
        this.categoryId,
        this.cartSummary,
        this.imageUrl,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        description: json["description"] == null ? null : Description.fromJson(json["description"]),
        id: json["_id"],
        skuCode: json["SKUCode"],
        skuName: json["SKUName"],
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
        skuClassification: json["SKUClassification"],
        skuClassification1: json["SKUClassification1"],
        subCategoryId: json["subCategory_id"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        offer: json["offer"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        categoryId: json["category_id"],
        cartSummary: json["cartSummary"] == null ? null : CartSummary.fromJson(json["cartSummary"]),
        imageUrl: json["imageURL"],
    );

    Map<String, dynamic> toJson() => {
        "description": description?.toJson(),
        "_id": id,
        "SKUCode": skuCode,
        "SKUName": skuName,
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "SKUClassification": skuClassification,
        "SKUClassification1": skuClassification1,
        "subCategory_id": subCategoryId,
        "price": price,
        "discountPrice": discountPrice,
        "offer": offer,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "category_id": categoryId,
        "cartSummary": cartSummary?.toJson(),
        "imageURL": imageUrl,
    };
}

class CartSummary {
    int? totalQuantity;
    int? totalPrice;
    List<ProductQuantity>? productQuantities;

    CartSummary({
        this.totalQuantity,
        this.totalPrice,
        this.productQuantities,
    });

    factory CartSummary.fromJson(Map<String, dynamic> json) => CartSummary(
        totalQuantity: json["totalQuantity"],
        totalPrice: json["totalPrice"],
        productQuantities: json["productQuantities"] == null ? [] : List<ProductQuantity>.from(json["productQuantities"]!.map((x) => ProductQuantity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalQuantity": totalQuantity,
        "totalPrice": totalPrice,
        "productQuantities": productQuantities == null ? [] : List<dynamic>.from(productQuantities!.map((x) => x.toJson())),
    };
}

class ProductQuantity {
    String? productId;
    String? variantLabel;
    int? variantQuantity;
    int? variantPrice;

    ProductQuantity({
        this.productId,
        this.variantLabel,
        this.variantQuantity,
        this.variantPrice,
    });

    factory ProductQuantity.fromJson(Map<String, dynamic> json) => ProductQuantity(
        productId: json["productId"],
        variantLabel: json["variantLabel"],
        variantQuantity: json["variantQuantity"],
        variantPrice: json["variantPrice"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "variantLabel": variantLabel,
        "variantQuantity": variantQuantity,
        "variantPrice": variantPrice,
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
    int? userCartQuantity;

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
        this.userCartQuantity,
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
        userCartQuantity: json["userCartQuantity"],
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
        "userCartQuantity": userCartQuantity,
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
