class AnswerModel {
  final String id;
  final String questionId;
  final String content;
  final String authorId;
  final bool isCorrect;

  AnswerModel(
      this.id, this.questionId, this.content, this.authorId, this.isCorrect);

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      map["id"],
      map["questionId"],
      map["content"],
      map["authorId"],
      map["isCorrect"],
    );
  }

  static Map<String, dynamic> create(String questionId, String content) {
    return {
      "questionId": questionId,
      "content": content,
    };
  }
}
