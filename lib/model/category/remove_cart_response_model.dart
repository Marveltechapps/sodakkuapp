import 'dart:convert';

RemoveCartResponse removeCartResponseFromJson(String str) => RemoveCartResponse.fromJson(json.decode(str));

String removeCartResponseToJson(RemoveCartResponse data) => json.encode(data.toJson());

class RemoveCartResponse {
    String? message;
    Cart? cart;

    RemoveCartResponse({
        this.message,
        this.cart,
    });

    factory RemoveCartResponse.fromJson(Map<String, dynamic> json) => RemoveCartResponse(
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
    BillSummary? billSummary;
    String? id;
    String? userId;
    List<Item>? items;
    String? createdAt;
    String? updatedAt;
    int? v;

    Cart({
        this.coupon,
        this.billSummary,
        this.id,
        this.userId,
        this.items,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
        billSummary: json["billSummary"] == null ? null : BillSummary.fromJson(json["billSummary"]),
        id: json["_id"],
        userId: json["userId"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "coupon": coupon?.toJson(),
        "billSummary": billSummary?.toJson(),
        "_id": id,
        "userId": userId,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
    };
}

class BillSummary {
    int? subTotal;
    int? gst;
    int? handlingCharges;
    int? deliveryTip;
    int? finalTotal;

    BillSummary({
        this.subTotal,
        this.gst,
        this.handlingCharges,
        this.deliveryTip,
        this.finalTotal,
    });

    factory BillSummary.fromJson(Map<String, dynamic> json) => BillSummary(
        subTotal: json["subTotal"],
        gst: json["gst"],
        handlingCharges: json["handlingCharges"],
        deliveryTip: json["deliveryTip"],
        finalTotal: json["finalTotal"],
    );

    Map<String, dynamic> toJson() => {
        "subTotal": subTotal,
        "gst": gst,
        "handlingCharges": handlingCharges,
        "deliveryTip": deliveryTip,
        "finalTotal": finalTotal,
    };
}

class Coupon {
    int? discountPercentage;

    Coupon({
        this.discountPercentage,
    });

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        discountPercentage: json["discountPercentage"],
    );

    Map<String, dynamic> toJson() => {
        "discountPercentage": discountPercentage,
    };
}

class Item {
    String? productId;
    String? variantLabel;
    int? quantity;
    int? price;
    int? discountPrice;
    int? total;
    String? id;

    Item({
        this.productId,
        this.variantLabel,
        this.quantity,
        this.price,
        this.discountPrice,
        this.total,
        this.id,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: json["productId"],
        variantLabel: json["variantLabel"],
        quantity: json["quantity"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        total: json["total"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "variantLabel": variantLabel,
        "quantity": quantity,
        "price": price,
        "discountPrice": discountPrice,
        "total": total,
        "_id": id,
    };
}
