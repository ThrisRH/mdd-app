class FaqResponse {
  final FaqData data;

  FaqResponse({required this.data});

  factory FaqResponse.fromJson(Map<String, dynamic> json) {
    return FaqResponse(data: FaqData.fromJson(json['data']));
  }
}

class FaqData {
  final int id;
  final String documentId;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final List<QuestionAnswer> questionAnswers;

  FaqData({
    required this.id,
    required this.documentId,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.questionAnswers,
  });

  factory FaqData.fromJson(Map<String, dynamic> json) {
    return FaqData(
      id: json['id'],
      documentId: json['documentId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
      questionAnswers:
          (json['questionAnswer'] as List)
              .map((e) => QuestionAnswer.fromJson(e))
              .toList(),
    );
  }
}

class QuestionAnswer {
  final int id;
  final String question;
  final String answer;

  QuestionAnswer({
    required this.id,
    required this.answer,
    required this.question,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) {
    return QuestionAnswer(
      id: json['id'],
      answer: json['answer'],
      question: json['question'],
    );
  }
}
