import 'package:dio/dio.dart';
import 'package:qna_flutter/logic/server/server_manager.dart';

import 'models/answer_model.dart';

class Answers {
  static Future<List<AnswerModel>> getAnswers(String questionId) async {
    Response r = await ServerManager().get('answers/$questionId');
    List<Map<String, dynamic>> maps = List<Map<String, dynamic>>.from(r.data);
    return maps.map((v) => AnswerModel.fromMap(v)).toList();
  }

  static Future<void> create(String questionId, String content) async {
    await ServerManager()
        .post('answer/add/', AnswerModel.create(questionId, content));
  }

  static Future<void> verifyAnswer(String questionId) async {
    await ServerManager().post('answer/verify/', {"id": questionId});
  }
}
