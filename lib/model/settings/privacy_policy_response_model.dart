// To parse this JSON data, do
//
//     final privacyPolicyResponse = privacyPolicyResponseFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyResponse privacyPolicyResponseFromJson(String str) => PrivacyPolicyResponse.fromJson(json.decode(str));

String privacyPolicyResponseToJson(PrivacyPolicyResponse data) => json.encode(data.toJson());

class PrivacyPolicyResponse {
    String? id;
    String? effectiveDate;
    String? title;
    String? content;
    String? lastUpdated;
    String? createdAt;
    String? updatedAt;
    int? v;

    PrivacyPolicyResponse({
        this.id,
        this.effectiveDate,
        this.title,
        this.content,
        this.lastUpdated,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) => PrivacyPolicyResponse(
        id: json["_id"],
        effectiveDate: json["effectiveDate"],
        title: json["title"],
        content: json["content"],
        lastUpdated: json["lastUpdated"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "effectiveDate": effectiveDate,
        "title": title,
        "content": content,
        "lastUpdated": lastUpdated,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
    };
}
