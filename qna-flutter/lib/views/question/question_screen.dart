import 'package:flutter/material.dart';
import 'package:qna_flutter/logic/answers.dart';
import 'package:qna_flutter/logic/models/answer_model.dart';
import 'package:qna_flutter/logic/models/question_model.dart';
import 'package:qna_flutter/logic/questions.dart';
import 'package:qna_flutter/logic/server/server_manager.dart';
import 'package:qna_flutter/views/helpers/handled_builders.dart';
import 'package:qna_flutter/views/question/create_answer.dart';

class QuestionScreen extends StatefulWidget {
  final String questionId;

  const QuestionScreen({Key key, @required this.questionId}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return HandledFutureBuilder<QuestionModel>(
        future: Questions.getQuestion(widget.questionId),
        builder: (context, question) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Question"),
            ),
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    question.title,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    question.content,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Divider(),
                HandledFutureBuilder<List<AnswerModel>>(
                    future: Answers.getAnswers(question.id),
                    builder: (context, answers) {
                      return Column(
                        children: <Widget>[
                          for (AnswerModel answer in answers)
                            ListTile(
                              leading: CircleAvatar(
                                child: answer.isCorrect
                                    ? Icon(Icons.check)
                                    : Icon(Icons.hourglass_empty),
                              ),
                              title: Text(answer.content),
                              subtitle: Text(answer.authorId),
                              trailing: answer.authorId ==
                                          ServerManager().userId &&
                                      !question.resolved
                                  ? IconButton(
                                      icon: Icon(Icons.check),
                                      onPressed: () async {
                                        await Answers.verifyAnswer(answer.id);
                                        setState(() {
                                          question.resolved = true;
                                        });
                                      },
                                    )
                                  : null,
                            ),
                        ],
                      );
                    })
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.question_answer),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateAnswerView(
                      questionId: question.id,
                    ),
                  ),
                );
                setState(() {
                  question.resolved = true;
                });
              },
            ),
          );
        });
  }
}
