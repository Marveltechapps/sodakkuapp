import 'dart:convert';

UpdateDeliveryTipResponseModel updateDeliveryTipResponseModelFromJson(String str) => UpdateDeliveryTipResponseModel.fromJson(json.decode(str));

String updateDeliveryTipResponseModelToJson(UpdateDeliveryTipResponseModel data) => json.encode(data.toJson());

class UpdateDeliveryTipResponseModel {
    String? message;
    Cart? cart;

    UpdateDeliveryTipResponseModel({
        this.message,
        this.cart,
    });

    factory UpdateDeliveryTipResponseModel.fromJson(Map<String, dynamic> json) => UpdateDeliveryTipResponseModel(
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
    List<Item>? items;
    String? deliveryInstructions;
    String? addNotes;
    String? createdAt;
    String? updatedAt;
    int? v;

    Cart({
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

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        billSummary: json["billSummary"] == null ? null : BillSummary.fromJson(json["billSummary"]),
        id: json["_id"],
        userId: json["userId"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
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
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "deliveryInstructions": deliveryInstructions,
        "addNotes": addNotes,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
    };
}

class BillSummary {
    int? itemTotal;
    double? gst;
    double? subtotalWithGst;
    int? deliveryFee;
    int? deliveryTip;
    int? handlingCharges;
    int? discountAmount;
    double? totalBill;

    BillSummary({
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
        itemTotal: json["itemTotal"],
        gst: json["GST"]?.toDouble(),
        subtotalWithGst: json["subtotalWithGST"]?.toDouble(),
        deliveryFee: json["deliveryFee"],
        deliveryTip: json["deliveryTip"],
        handlingCharges: json["handlingCharges"],
        discountAmount: json["discountAmount"],
        totalBill: json["totalBill"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
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
    String? productId;
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
        productId: json["productId"],
        quantity: json["quantity"],
        variantLabel: json["variantLabel"],
        imageUrl: json["imageURL"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
        "variantLabel": variantLabel,
        "imageURL": imageUrl,
        "price": price,
        "discountPrice": discountPrice,
        "_id": id,
    };
}
