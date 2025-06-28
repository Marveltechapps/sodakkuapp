import 'dart:convert';

ProductErrorResponse productErrorResponseFromJson(String str) => ProductErrorResponse.fromJson(json.decode(str));

String productErrorResponseToJson(ProductErrorResponse data) => json.encode(data.toJson());

class ProductErrorResponse {
    int? status;
    String? message;

    ProductErrorResponse({
        this.status,
        this.message,
    });

    factory ProductErrorResponse.fromJson(Map<String, dynamic> json) => ProductErrorResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
