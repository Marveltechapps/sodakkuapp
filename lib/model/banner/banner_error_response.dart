import 'dart:convert';

BannerProductErrorResponse bannerProductErrorResponseFromJson(String str) => BannerProductErrorResponse.fromJson(json.decode(str));

String bannerProductErrorResponseToJson(BannerProductErrorResponse data) => json.encode(data.toJson());

class BannerProductErrorResponse {
    String? msg;

    BannerProductErrorResponse({
        this.msg,
    });

    factory BannerProductErrorResponse.fromJson(Map<String, dynamic> json) => BannerProductErrorResponse(
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
    };
}
