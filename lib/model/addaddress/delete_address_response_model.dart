import 'dart:convert';

DeleteAddressResponse deleteAddressResponseFromJson(String str) => DeleteAddressResponse.fromJson(json.decode(str));

String deleteAddressResponseToJson(DeleteAddressResponse data) => json.encode(data.toJson());

class DeleteAddressResponse {
    bool? success;
    String? message;

    DeleteAddressResponse({
        this.success,
        this.message,
    });

    factory DeleteAddressResponse.fromJson(Map<String, dynamic> json) => DeleteAddressResponse(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}
