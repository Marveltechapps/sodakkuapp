// To parse this JSON data, do
//
//     final productStyleResponse = productStyleResponseFromJson(jsonString);

import 'dart:convert';

ProductStyleResponse productStyleResponseFromJson(String str) => ProductStyleResponse.fromJson(json.decode(str));

String productStyleResponseToJson(ProductStyleResponse data) => json.encode(data.toJson());

class ProductStyleResponse {
    int? status;
    String? message;
    List<ProductList>? data;
    Pagination? pagination;

    ProductStyleResponse({
        this.status,
        this.message,
        this.data,
        this.pagination,
    });

    factory ProductStyleResponse.fromJson(Map<String, dynamic> json) => ProductStyleResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<ProductList>.from(json["data"]!.map((x) => ProductList.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
    };
}

class ProductList {
    String? productId;
    String? categoryId;
    String? categoryName;
    String? subCategoryId;
    String? subCategoryName;
    String? skucode;
    String? skuName;
    List<Variant>? variants;
    String? offer;
    int? discountPrice;
    CartSummary? cartSummary;

    ProductList({
        this.productId,
        this.categoryId,
        this.categoryName,
        this.subCategoryId,
        this.subCategoryName,
        this.skucode,
        this.skuName,
        this.variants,
        this.offer,
        this.discountPrice,
        this.cartSummary,
    });

    factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        productId: json["productId"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        subCategoryId: json["subCategoryId"],
        subCategoryName: json["subCategoryName"],
        skucode: json["skucode"],
        skuName: json["skuName"],
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
        offer: json["offer"],
        discountPrice: json["discountPrice"],
        cartSummary: json["cartSummary"] == null ? null : CartSummary.fromJson(json["cartSummary"]),
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "subCategoryId": subCategoryId,
        "subCategoryName": subCategoryName,
        "skucode": skucode,
        "skuName": skuName,
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "offer": offer,
        "discountPrice": discountPrice,
        "cartSummary": cartSummary?.toJson(),
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

class Pagination {
    int? currentPage;
    int? totalPages;
    int? totalDocuments;

    Pagination({
        this.currentPage,
        this.totalPages,
        this.totalDocuments,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        totalDocuments: json["totalDocuments"],
    );

    Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "totalPages": totalPages,
        "totalDocuments": totalDocuments,
    };
}
