import 'dart:convert';

UpdateCartResponse updateCartResponseFromJson(String str) => UpdateCartResponse.fromJson(json.decode(str));

String updateCartResponseToJson(UpdateCartResponse data) => json.encode(data.toJson());

class UpdateCartResponse {
    String? message;
    Cart? cart;

    UpdateCartResponse({
        this.message,
        this.cart,
    });

    factory UpdateCartResponse.fromJson(Map<String, dynamic> json) => UpdateCartResponse(
        message: json["message"],
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "cart": cart?.toJson(),
    };
}

class Cart {
    BillSummary? billSummary;
    String? id;
    String? userId;
    List<dynamic>? items;
    String? deliveryInstructions;
    String? addNotes;
    int? v;
    String? updatedAt;

    Cart({
        this.billSummary,
        this.id,
        this.userId,
        this.items,
        this.deliveryInstructions,
        this.addNotes,
        this.v,
        this.updatedAt,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        billSummary: json["billSummary"] == null ? null : BillSummary.fromJson(json["billSummary"]),
        id: json["_id"],
        userId: json["userId"],
        items: json["items"] == null ? [] : List<dynamic>.from(json["items"]!.map((x) => x)),
        deliveryInstructions: json["deliveryInstructions"],
        addNotes: json["addNotes"],
        v: json["__v"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "billSummary": billSummary?.toJson(),
        "_id": id,
        "userId": userId,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x)),
        "deliveryInstructions": deliveryInstructions,
        "addNotes": addNotes,
        "__v": v,
        "updatedAt": updatedAt,
    };
}

class BillSummary {
    int? itemTotal;
    int? gst;
    int? deliveryFee;
    int? deliveryTip;
    int? handlingCharges;
    int? discountAmount;
    int? totalBill;

    BillSummary({
        this.itemTotal,
        this.gst,
        this.deliveryFee,
        this.deliveryTip,
        this.handlingCharges,
        this.discountAmount,
        this.totalBill,
    });

    factory BillSummary.fromJson(Map<String, dynamic> json) => BillSummary(
        itemTotal: json["itemTotal"],
        gst: json["GST"],
        deliveryFee: json["deliveryFee"],
        deliveryTip: json["deliveryTip"],
        handlingCharges: json["handlingCharges"],
        discountAmount: json["discountAmount"],
        totalBill: json["totalBill"],
    );

    Map<String, dynamic> toJson() => {
        "itemTotal": itemTotal,
        "GST": gst,
        "deliveryFee": deliveryFee,
        "deliveryTip": deliveryTip,
        "handlingCharges": handlingCharges,
        "discountAmount": discountAmount,
        "totalBill": totalBill,
    };
}
