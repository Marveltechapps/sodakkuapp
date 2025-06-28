import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
    String? message;
    User? user;

    UpdateProfileModel({
        this.message,
        this.user,
    });

    factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user": user?.toJson(),
    };
}

class User {
    String? id;
    String? mobileNumber;
    String? name;
    String? email;
    bool? isVerified;
    String? createdAt;
    String? updatedAt;
    int? v;

    User({
        this.id,
        this.mobileNumber,
        this.name,
        this.email,
        this.isVerified,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        mobileNumber: json["mobileNumber"],
        name: json["name"],
        email: json["email"],
        isVerified: json["isVerified"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
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
    };
}
