import 'dart:convert';

List<FaqsResponse> faqsResponseFromJson(String str) => List<FaqsResponse>.from(json.decode(str).map((x) => FaqsResponse.fromJson(x)));

String faqsResponseToJson(List<FaqsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
