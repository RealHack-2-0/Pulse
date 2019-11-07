class QuestionModel {
  final String id;
  final List<String> upvotes;
  final List<String> downvotes;
  final String title;
  final String content;
  final String authorId;
  bool resolved;
  final String correctAnswerId;

  int get votes => upvotes.length - downvotes.length;

  QuestionModel(this.id, this.upvotes, this.downvotes, this.title, this.content,
      this.authorId, this.resolved, this.correctAnswerId);

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      map["id"],
      List<String>.from(map["upvotes"]),
      List<String>.from(map["downvotes"]),
      map["title"],
      map["content"],
      map["authorId"],
      map["resolved"],
      map["correctAnswerId"],
    );
  }

  static Map<String, dynamic> create(String title, String content) {
    return {
      "title": title,
      "content": content,
    };
  }
}
