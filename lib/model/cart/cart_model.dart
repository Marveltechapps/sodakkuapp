import 'dart:convert';

CartResponse cartResponseFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  BillSummary? billSummary;
  String? id;
  String? userId;
  List<Item>? items;
  String? deliveryInstructions;
  String? addNotes;
  String? createdAt;
  String? updatedAt;
  int? v;

  CartResponse({
    this.billSummary,
    this.id,
    this.userId,
    this.items,
    this.deliveryInstructions,
    this.addNotes,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        billSummary: json["billSummary"] == null
            ? null
            : BillSummary.fromJson(json["billSummary"]),
        id: json["_id"],
        userId: json["userId"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        deliveryInstructions: json["deliveryInstructions"],
        addNotes: json["addNotes"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "billSummary": billSummary?.toJson(),
        "_id": id,
        "userId": userId,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "deliveryInstructions": deliveryInstructions,
        "addNotes": addNotes,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

class BillSummary {
  dynamic savings;
  dynamic itemTotal;
  dynamic gst;
  dynamic subtotalWithGst;
  dynamic deliveryFee;
  dynamic deliveryTip;
  dynamic handlingCharges;
  dynamic discountAmount;
  dynamic totalBill;

  BillSummary({
    this.savings,
    this.itemTotal,
    this.gst,
    this.subtotalWithGst,
    this.deliveryFee,
    this.deliveryTip,
    this.handlingCharges,
    this.discountAmount,
    this.totalBill,
  });

  factory BillSummary.fromJson(Map<String, dynamic> json) => BillSummary(
        savings: json["savings"],
        itemTotal: json["itemTotal"],
        gst: json["GST"],
        subtotalWithGst: json["subtotalWithGST"],
        deliveryFee: json["deliveryFee"],
        deliveryTip: json["deliveryTip"],
        handlingCharges: json["handlingCharges"],
        discountAmount: json["discountAmount"],
        totalBill: json["totalBill"],
      );

  Map<String, dynamic> toJson() => {
        "savings": savings,
        "itemTotal": itemTotal,
        "GST": gst,
        "subtotalWithGST": subtotalWithGst,
        "deliveryFee": deliveryFee,
        "deliveryTip": deliveryTip,
        "handlingCharges": handlingCharges,
        "discountAmount": discountAmount,
        "totalBill": totalBill,
      };
}

class Item {
  ProductId? productId;
  int? quantity;
  String? variantLabel;
  String? imageUrl;
  int? price;
  int? discountPrice;
  String? id;

  Item({
    this.productId,
    this.quantity,
    this.variantLabel,
    this.imageUrl,
    this.price,
    this.discountPrice,
    this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: json["productId"] == null
            ? null
            : ProductId.fromJson(json["productId"]),
        quantity: json["quantity"],
        variantLabel: json["variantLabel"],
        imageUrl: json["imageURL"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId?.toJson(),
        "quantity": quantity,
        "variantLabel": variantLabel,
        "imageURL": imageUrl,
        "price": price,
        "discountPrice": discountPrice,
        "_id": id,
      };
}

class ProductId {
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
  String? mainCategoryId;

  ProductId({
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

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        description: json["description"] == null
            ? null
            : Description.fromJson(json["description"]),
        id: json["_id"],
        skuCode: json["SKUCode"],
        skuName: json["SKUName"],
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
        skuClassification: json["SKUClassification"],
        skuClassification1: json["SKUClassification1"],
        subCategoryId: json["subCategory_id"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        offer: json["offer"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        mainCategoryId: json["main_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "description": description?.toJson(),
        "_id": id,
        "SKUCode": skuCode,
        "SKUName": skuName,
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "SKUClassification": skuClassification,
        "SKUClassification1": skuClassification1,
        "subCategory_id": subCategoryId,
        "price": price,
        "discountPrice": discountPrice,
        "offer": offer,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
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
