import 'dart:convert';

SaveProfileErrorResponse saveProfileErrorResponseFromJson(String str) => SaveProfileErrorResponse.fromJson(json.decode(str));

String saveProfileErrorResponseToJson(SaveProfileErrorResponse data) => json.encode(data.toJson());

class SaveProfileErrorResponse {
    String? error;

    SaveProfileErrorResponse({
        this.error,
    });

    factory SaveProfileErrorResponse.fromJson(Map<String, dynamic> json) => SaveProfileErrorResponse(
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
    };
}
