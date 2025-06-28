import 'dart:convert';

BannerProductResponse bannerProductResponseFromJson(String str) => BannerProductResponse.fromJson(json.decode(str));

String bannerProductResponseToJson(BannerProductResponse data) => json.encode(data.toJson());

class BannerProductResponse {
    int? status;
    String? message;
    List<Datum>? data;

    BannerProductResponse({
        this.status,
        this.message,
        this.data,
    });

    factory BannerProductResponse.fromJson(Map<String, dynamic> json) => BannerProductResponse(
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
    String? productId;
    String? mainCategoryId;
    String? mainCategoryName;
    dynamic categoryId;
    dynamic categoryName;
    String? subCategoryId;
    String? subCategoryName;
    String? skucode;
    String? skuName;
    String? offer;
    int? discountPrice;
    List<Variant>? variants;

    Datum({
        this.productId,
        this.mainCategoryId,
        this.mainCategoryName,
        this.categoryId,
        this.categoryName,
        this.subCategoryId,
        this.subCategoryName,
        this.skucode,
        this.skuName,
        this.offer,
        this.discountPrice,
        this.variants,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["productId"],
        mainCategoryId: json["main_category_id"],
        mainCategoryName: json["mainCategoryName"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        subCategoryId: json["subCategoryId"],
        subCategoryName: json["subCategoryName"],
        skucode: json["skucode"],
        skuName: json["skuName"],
        offer: json["offer"],
        discountPrice: json["discountPrice"],
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "main_category_id": mainCategoryId,
        "mainCategoryName": mainCategoryName,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "subCategoryId": subCategoryId,
        "subCategoryName": subCategoryName,
        "skucode": skucode,
        "skuName": skuName,
        "offer": offer,
        "discountPrice": discountPrice,
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
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
