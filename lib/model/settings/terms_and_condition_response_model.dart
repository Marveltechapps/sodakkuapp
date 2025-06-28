import 'dart:convert';

List<TermsAndConditionResponse> termsAndConditionResponseFromJson(String str) => List<TermsAndConditionResponse>.from(json.decode(str).map((x) => TermsAndConditionResponse.fromJson(x)));

String termsAndConditionResponseToJson(List<TermsAndConditionResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TermsAndConditionResponse {
    String? id;
    String? title;
    String? content;
    int? v;

    TermsAndConditionResponse({
        this.id,
        this.title,
        this.content,
        this.v,
    });

    factory TermsAndConditionResponse.fromJson(Map<String, dynamic> json) => TermsAndConditionResponse(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "__v": v,
    };
}
