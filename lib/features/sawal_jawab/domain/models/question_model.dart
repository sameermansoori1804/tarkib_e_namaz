class QuestionModel {
  int? id;
  int? userId;
  String? question;
  String? answer;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? ratingAverage;
  int? totalRating;
  bool? ratingMe;

  QuestionModel({
    this.id,
    this.userId,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.ratingAverage,
    this.totalRating,
    this.ratingMe,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      userId: json['user_id'],
      question: json['quetion'], // API typo handled
      answer: json['answer'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      ratingAverage: (json['rating_average'] ?? 0).toDouble(),
      totalRating: json['total_ratting'] ?? 0,
      ratingMe: json['rating_me'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "quetion": question,
      "answer": answer,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
      "rating_average": ratingAverage,
      "total_ratting": totalRating,
      "rating_me": ratingMe,
    };
  }
}
