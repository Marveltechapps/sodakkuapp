import 'dart:convert';

SaveProfileErrorModel saveProfileErrorModelFromJson(String str) => SaveProfileErrorModel.fromJson(json.decode(str));

String saveProfileErrorModelToJson(SaveProfileErrorModel data) => json.encode(data.toJson());

class SaveProfileErrorModel {
    String? message;

    SaveProfileErrorModel({
        this.message,
    });

    factory SaveProfileErrorModel.fromJson(Map<String, dynamic> json) => SaveProfileErrorModel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
