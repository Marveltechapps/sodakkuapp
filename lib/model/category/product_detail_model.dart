// To parse this JSON data, do
//
//     final productDetailResponse = productDetailResponseFromJson(jsonString);

import 'dart:convert';

ProductDetailResponse productDetailResponseFromJson(String str) => ProductDetailResponse.fromJson(json.decode(str));

String productDetailResponseToJson(ProductDetailResponse data) => json.encode(data.toJson());

class ProductDetailResponse {
    int? status;
    String? message;
    Data? data;
    CartSummary? cartSummary;

    ProductDetailResponse({
        this.status,
        this.message,
        this.data,
        this.cartSummary,
    });

    factory ProductDetailResponse.fromJson(Map<String, dynamic> json) => ProductDetailResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        cartSummary: json["cartSummary"] == null ? null : CartSummary.fromJson(json["cartSummary"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "cartSummary": cartSummary?.toJson(),
    };
}

class CartSummary {
    int? overallProductQuantity;
    int? overallProductPrice;
    List<ProductDetail>? productDetails;

    CartSummary({
        this.overallProductQuantity,
        this.overallProductPrice,
        this.productDetails,
    });

    factory CartSummary.fromJson(Map<String, dynamic> json) => CartSummary(
        overallProductQuantity: json["overallProductQuantity"],
        overallProductPrice: json["overallProductPrice"],
        productDetails: json["productDetails"] == null ? [] : List<ProductDetail>.from(json["productDetails"]!.map((x) => ProductDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "overallProductQuantity": overallProductQuantity,
        "overallProductPrice": overallProductPrice,
        "productDetails": productDetails == null ? [] : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
    };
}

class ProductDetail {
    String? productId;
    String? variantLabel;
    int? variantQuantity;
    int? variantPrice;

    ProductDetail({
        this.productId,
        this.variantLabel,
        this.variantQuantity,
        this.variantPrice,
    });

    factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
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

class Data {
    Product? product;
    Category? category;
    SubCategory? subCategory;

    Data({
        this.product,
        this.category,
        this.subCategory,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        subCategory: json["subCategory"] == null ? null : SubCategory.fromJson(json["subCategory"]),
    );

    Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "category": category?.toJson(),
        "subCategory": subCategory?.toJson(),
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

class Product {
    Description? description;
    String? id;
    String? skuCode;
    String? skuName;
    List<Variant>? variants;
    String? skuClassification;
    String? skuClassification1;
    dynamic categoryId;
    SubCategory? subCategoryId;
    int? price;
    int? discountPrice;
    String? offer;
    String? createdAt;
    String? updatedAt;
    int? v;

    Product({
        this.description,
        this.id,
        this.skuCode,
        this.skuName,
        this.variants,
        this.skuClassification,
        this.skuClassification1,
        this.categoryId,
        this.subCategoryId,
        this.price,
        this.discountPrice,
        this.offer,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        description: json["description"] == null ? null : Description.fromJson(json["description"]),
        id: json["_id"],
        skuCode: json["SKUCode"],
        skuName: json["SKUName"],
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
        skuClassification: json["SKUClassification"],
        skuClassification1: json["SKUClassification1"],
        categoryId: json["category_id"],
        subCategoryId: json["subCategory_id"] == null ? null : SubCategory.fromJson(json["subCategory_id"]),
        price: json["price"],
        discountPrice: json["discountPrice"],
        offer: json["offer"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "description": description?.toJson(),
        "_id": id,
        "SKUCode": skuCode,
        "SKUName": skuName,
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "SKUClassification": skuClassification,
        "SKUClassification1": skuClassification1,
        "category_id": categoryId,
        "subCategory_id": subCategoryId?.toJson(),
        "price": price,
        "discountPrice": discountPrice,
        "offer": offer,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
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

class SubCategory {
    String? id;
    String? name;
    String? imageUrl;
    String? categoryId;
    String? createdAt;
    String? updatedAt;
    int? v;

    SubCategory({
        this.id,
        this.name,
        this.imageUrl,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["_id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        categoryId: json["category_id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "imageUrl": imageUrl,
        "category_id": categoryId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
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
    String? imageUrl;
    int? cartQuantity;
    String? id;
    int? userCartQuantity;
    bool? isOutOfStock;

    Variant({
        this.comboDetails,
        this.label,
        this.price,
        this.discountPrice,
        this.offer,
        this.isComboPack,
        this.isMultiPack,
        this.stockQuantity,
        this.imageUrl,
        this.cartQuantity,
        this.id,
        this.userCartQuantity,
        this.isOutOfStock,
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
        imageUrl: json["imageURL"],
        cartQuantity: json["cartQuantity"],
        id: json["_id"],
        userCartQuantity: json["userCartQuantity"],
        isOutOfStock: json["isOutOfStock"],
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
        "imageURL": imageUrl,
        "cartQuantity": cartQuantity,
        "_id": id,
        "userCartQuantity": userCartQuantity,
        "isOutOfStock": isOutOfStock,
    };
}

class ComboDetails {
    List<dynamic>? productNames;
    List<dynamic>? childSkuCodes;

    ComboDetails({
        this.productNames,
        this.childSkuCodes,
    });

    factory ComboDetails.fromJson(Map<String, dynamic> json) => ComboDetails(
        productNames: json["productNames"] == null ? [] : List<dynamic>.from(json["productNames"]!.map((x) => x)),
        childSkuCodes: json["childSkuCodes"] == null ? [] : List<dynamic>.from(json["childSkuCodes"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "productNames": productNames == null ? [] : List<dynamic>.from(productNames!.map((x) => x)),
        "childSkuCodes": childSkuCodes == null ? [] : List<dynamic>.from(childSkuCodes!.map((x) => x)),
    };
}
