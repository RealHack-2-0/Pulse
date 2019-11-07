import 'package:dio/dio.dart';
import 'package:qna_flutter/logic/models/question_model.dart';
import 'package:qna_flutter/logic/server/server_manager.dart';

class Questions {
  static Future<List<QuestionModel>> getQuestions() async {
    Response r = await ServerManager().get('questions/list/');
    List<Map<String, dynamic>> maps = List<Map<String, dynamic>>.from(r.data);
    return maps.map((v) => QuestionModel.fromMap(v)).toList();
  }

  static Future<void> create(String title, String content) async {
    await ServerManager()
        .post('questions/add/', QuestionModel.create(title, content));
  }

  static Future<QuestionModel> getQuestion(String id) async {
    Response r = await ServerManager().get('question/$id/');
    Map<String, dynamic> map = Map<String, dynamic>.from(r.data);
    return QuestionModel.fromMap(map);
  }
}
