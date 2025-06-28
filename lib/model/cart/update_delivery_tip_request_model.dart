import 'dart:convert';

UpdateDeliveryTipRequestModel updateDeliveryTipRequestModelFromJson(String str) => UpdateDeliveryTipRequestModel.fromJson(json.decode(str));

String updateDeliveryTipRequestModelToJson(UpdateDeliveryTipRequestModel data) => json.encode(data.toJson());

class UpdateDeliveryTipRequestModel {
    String? userId;
    int? deliveryTip;

    UpdateDeliveryTipRequestModel({
        this.userId,
        this.deliveryTip,
    });

    factory UpdateDeliveryTipRequestModel.fromJson(Map<String, dynamic> json) => UpdateDeliveryTipRequestModel(
        userId: json["userId"],
        deliveryTip: json["deliveryTip"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "deliveryTip": deliveryTip,
    };
}
