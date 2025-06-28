import 'dart:convert';

UpdateCartRequest updateCartRequestFromJson(String str) => UpdateCartRequest.fromJson(json.decode(str));

String updateCartRequestToJson(UpdateCartRequest data) => json.encode(data.toJson());

class UpdateCartRequest {
    String? userId;
    String? deliveryInstructions;
    String? addNotes;
    int? deliveryTip;
    int? deliveryFee;

    UpdateCartRequest({
        this.userId,
        this.deliveryInstructions,
        this.addNotes,
        this.deliveryTip,
        this.deliveryFee,
    });

    factory UpdateCartRequest.fromJson(Map<String, dynamic> json) => UpdateCartRequest(
        userId: json["userId"],
        deliveryInstructions: json["deliveryInstructions"],
        addNotes: json["addNotes"],
        deliveryTip: json["deliveryTip"],
        deliveryFee: json["deliveryFee"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "deliveryInstructions": deliveryInstructions,
        "addNotes": addNotes,
        "deliveryTip": deliveryTip,
        "deliveryFee": deliveryFee,
    };
}
