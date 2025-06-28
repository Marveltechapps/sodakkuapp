import 'dart:convert';

CartErrorResponse cartErrorResponseFromJson(String str) => CartErrorResponse.fromJson(json.decode(str));

String cartErrorResponseToJson(CartErrorResponse data) => json.encode(data.toJson());

class CartErrorResponse {
    String? message;

    CartErrorResponse({
        this.message,
    });

    factory CartErrorResponse.fromJson(Map<String, dynamic> json) => CartErrorResponse(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
