import 'dart:convert';

AddItemToCartResponse addItemToCartResponseFromJson(String str) => AddItemToCartResponse.fromJson(json.decode(str));

String addItemToCartResponseToJson(AddItemToCartResponse data) => json.encode(data.toJson());

class AddItemToCartResponse {
    String? message;
    Cart? cart;

    AddItemToCartResponse({
        this.message,
        this.cart,
    });

    factory AddItemToCartResponse.fromJson(Map<String, dynamic> json) => AddItemToCartResponse(
        message: json["message"],
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "cart": cart?.toJson(),
    };
}

class Cart {
    Coupon? coupon;
    String? id;
    String? userId;
    List<Item>? items;
    int? totalItems;
    double? totalPrice;
    int? riderTip;
    String? updatedAt;
    int? v;
    double? gst;
    int? deliveryFees;
    String? deliveryInstructions;
    int? handlingCharges;
    double? totalBill;
    String? addNotes;
    Summary? summary;

    Cart({
        this.coupon,
        this.id,
        this.userId,
        this.items,
        this.totalItems,
        this.totalPrice,
        this.riderTip,
        this.updatedAt,
        this.v,
        this.gst,
        this.deliveryFees,
        this.deliveryInstructions,
        this.handlingCharges,
        this.totalBill,
        this.addNotes,
        this.summary,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
        id: json["_id"],
        userId: json["userId"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        totalItems: json["totalItems"],
        totalPrice: json["totalPrice"]?.toDouble(),
        riderTip: json["riderTip"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        gst: json["GST"]?.toDouble(),
        deliveryFees: json["deliveryFees"],
        deliveryInstructions: json["deliveryInstructions"],
        handlingCharges: json["handlingCharges"],
        totalBill: json["totalBill"]?.toDouble(),
        addNotes: json["addNotes"],
        summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    );

    Map<String, dynamic> toJson() => {
        "coupon": coupon?.toJson(),
        "_id": id,
        "userId": userId,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalItems": totalItems,
        "totalPrice": totalPrice,
        "riderTip": riderTip,
        "updatedAt": updatedAt,
        "__v": v,
        "GST": gst,
        "deliveryFees": deliveryFees,
        "deliveryInstructions": deliveryInstructions,
        "handlingCharges": handlingCharges,
        "totalBill": totalBill,
        "addNotes": addNotes,
        "summary": summary?.toJson(),
    };
}

class Coupon {
    String? code;
    int? discountPercentage;

    Coupon({
        this.code,
        this.discountPercentage,
    });

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        code: json["code"],
        discountPercentage: json["discountPercentage"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "discountPercentage": discountPercentage,
    };
}

class Item {
    String? skuCode;
    String? skuName;
    String? variantLabel;
    int? price;
    double? discountPrice;
    int? offer;
    int? cartQuantity;
    int? totalPrice;
    String? imageUrl;
    String? category;
    String? id;

    Item({
        this.skuCode,
        this.skuName,
        this.variantLabel,
        this.price,
        this.discountPrice,
        this.offer,
        this.cartQuantity,
        this.totalPrice,
        this.imageUrl,
        this.category,
        this.id,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        skuCode: json["SKUCode"],
        skuName: json["SKUName"],
        variantLabel: json["variantLabel"],
        price: json["price"],
        discountPrice: json["discountPrice"]?.toDouble(),
        offer: json["offer"],
        cartQuantity: json["cartQuantity"],
        totalPrice: json["totalPrice"],
        imageUrl: json["imageURL"],
        category: json["category"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "SKUCode": skuCode,
        "SKUName": skuName,
        "variantLabel": variantLabel,
        "price": price,
        "discountPrice": discountPrice,
        "offer": offer,
        "cartQuantity": cartQuantity,
        "totalPrice": totalPrice,
        "imageURL": imageUrl,
        "category": category,
        "_id": id,
    };
}

class Summary {
    int? totalItems;
    String? totalPrice;
    String? gst;
    String? handlingCharges;
    String? deliveryFees;
    String? riderTip;
    String? totalBill;
    Coupon? coupon;

    Summary({
        this.totalItems,
        this.totalPrice,
        this.gst,
        this.handlingCharges,
        this.deliveryFees,
        this.riderTip,
        this.totalBill,
        this.coupon,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        totalItems: json["totalItems"],
        totalPrice: json["totalPrice"],
        gst: json["GST"],
        handlingCharges: json["handlingCharges"],
        deliveryFees: json["deliveryFees"],
        riderTip: json["riderTip"],
        totalBill: json["totalBill"],
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
    );

    Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "totalPrice": totalPrice,
        "GST": gst,
        "handlingCharges": handlingCharges,
        "deliveryFees": deliveryFees,
        "riderTip": riderTip,
        "totalBill": totalBill,
        "coupon": coupon?.toJson(),
    };
}
