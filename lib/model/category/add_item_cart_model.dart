import 'dart:convert';

AddItemToCartRequest addItemToCartRequestFromJson(String str) => AddItemToCartRequest.fromJson(json.decode(str));

String addItemToCartRequestToJson(AddItemToCartRequest data) => json.encode(data.toJson());

class AddItemToCartRequest {
    String? userId;
    String? productId;
    int? quantity;
    String? variantLabel;
    String? imageUrl;
    int? price;
    int? discountPrice;
    String? deliveryInstructions;
    String? addNotes;

    AddItemToCartRequest({
        this.userId,
        this.productId,
        this.quantity,
        this.variantLabel,
        this.imageUrl,
        this.price,
        this.discountPrice,
        this.deliveryInstructions,
        this.addNotes,
    });

    factory AddItemToCartRequest.fromJson(Map<String, dynamic> json) => AddItemToCartRequest(
        userId: json["userId"],
        productId: json["productId"],
        quantity: json["quantity"],
        variantLabel: json["variantLabel"],
        imageUrl: json["imageURL"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        deliveryInstructions: json["deliveryInstructions"],
        addNotes: json["addNotes"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "productId": productId,
        "quantity": quantity,
        "variantLabel": variantLabel,
        "imageURL": imageUrl,
        "price": price,
        "discountPrice": discountPrice,
        "deliveryInstructions": deliveryInstructions,
        "addNotes": addNotes,
    };
}
