import 'dart:convert';

FaqsResponse faqsResponseFromJson(String str) => FaqsResponse.fromJson(json.decode(str));

String faqsResponseToJson(FaqsResponse data) => json.encode(data.toJson());

class FaqsResponse {
    String? id;
    String? question;
    String? answer;
    int? v;

    FaqsResponse({
        this.id,
        this.question,
        this.answer,
        this.v,
    });

    factory FaqsResponse.fromJson(Map<String, dynamic> json) => FaqsResponse(
        id: json["_id"],
        question: json["question"],
        answer: json["answer"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "question": question,
        "answer": answer,
        "__v": v,
    };
}
