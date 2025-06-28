// To parse this JSON data, do
//
//     final verifyOtpResponse = verifyOtpResponseFromJson(jsonString);

import 'dart:convert';

VerifyOtpResponse verifyOtpResponseFromJson(String str) => VerifyOtpResponse.fromJson(json.decode(str));

String verifyOtpResponseToJson(VerifyOtpResponse data) => json.encode(data.toJson());

class VerifyOtpResponse {
    String? message;
    String? userId;
    String? token;

    VerifyOtpResponse({
        this.message,
        this.userId,
        this.token,
    });

    factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) => VerifyOtpResponse(
        message: json["message"],
        userId: json["userId"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "userId": userId,
        "token": token,
    };
}
