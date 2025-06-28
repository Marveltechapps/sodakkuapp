import 'dart:convert';

SaveProfileModel saveProfileModelFromJson(String str) => SaveProfileModel.fromJson(json.decode(str));

String saveProfileModelToJson(SaveProfileModel data) => json.encode(data.toJson());

class SaveProfileModel {
    String? mobileNumber;
    String? name;
    String? email;

    SaveProfileModel({
        this.mobileNumber,
        this.name,
        this.email,
    });

    factory SaveProfileModel.fromJson(Map<String, dynamic> json) => SaveProfileModel(
        mobileNumber: json["mobileNumber"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "mobileNumber": mobileNumber,
        "name": name,
        "email": email,
    };
}
