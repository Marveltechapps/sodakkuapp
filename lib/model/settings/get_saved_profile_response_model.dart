import 'dart:convert';

GetSavedProfileModel getSavedProfileModelFromJson(String str) => GetSavedProfileModel.fromJson(json.decode(str));

String getSavedProfileModelToJson(GetSavedProfileModel data) => json.encode(data.toJson());

class GetSavedProfileModel {
    String? id;
    String? mobileNumber;
    String? name;
    String? email;
    bool? isVerified;
    String? createdAt;
    String? updatedAt;
    int? v;
    String? otp;

    GetSavedProfileModel({
        this.id,
        this.mobileNumber,
        this.name,
        this.email,
        this.isVerified,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.otp,
    });

    factory GetSavedProfileModel.fromJson(Map<String, dynamic> json) => GetSavedProfileModel(
        id: json["_id"],
        mobileNumber: json["mobileNumber"],
        name: json["name"],
        email: json["email"],
        isVerified: json["isVerified"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "mobileNumber": mobileNumber,
        "name": name,
        "email": email,
        "isVerified": isVerified,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "otp": otp,
    };
}
