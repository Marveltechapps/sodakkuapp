import 'dart:convert';

ProductStyleError productStyleErrorFromJson(String str) => ProductStyleError.fromJson(json.decode(str));

String productStyleErrorToJson(ProductStyleError data) => json.encode(data.toJson());

class ProductStyleError {
    int? status;
    String? message;

    ProductStyleError({
        this.status,
        this.message,
    });

    factory ProductStyleError.fromJson(Map<String, dynamic> json) => ProductStyleError(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
