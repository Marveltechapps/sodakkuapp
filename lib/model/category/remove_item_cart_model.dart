import 'dart:convert';

RemoveItemToCartRequest removeItemToCartRequestFromJson(String str) =>
    RemoveItemToCartRequest.fromJson(json.decode(str));

String removeItemToCartRequestToJson(RemoveItemToCartRequest data) =>
    json.encode(data.toJson());

class RemoveItemToCartRequest {
  String? userId;
  String? productId;
  int? quantity;
  String? variantLabel;
  int? deliveryTip;
  int? handlingCharges;

  RemoveItemToCartRequest({
    this.userId,
    this.productId,
    this.quantity,
    this.variantLabel,
    this.deliveryTip,
    this.handlingCharges,
  });

  factory RemoveItemToCartRequest.fromJson(Map<String, dynamic> json) =>
      RemoveItemToCartRequest(
        userId: json["userId"],
        productId: json["productId"],
        quantity: json["quantity"],
        variantLabel: json["variantLabel"],
        deliveryTip: json["deliveryTip"],
        handlingCharges: json["handlingCharges"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "productId": productId,
        "quantity": quantity,
        "variantLabel": variantLabel,
        "deliveryTip": deliveryTip,
        "handlingCharges": handlingCharges,
      };
}
