import 'package:flutter/material.dart';
import 'package:qna_flutter/logic/answers.dart';
import 'package:qna_flutter/logic/models/answer_model.dart';
import 'package:qna_flutter/logic/models/question_model.dart';
import 'package:qna_flutter/views/helpers/handled_builders.dart';
import 'package:qna_flutter/views/question/create_answer.dart';

class QuestionScreen extends StatefulWidget {
  final QuestionModel question;

  const QuestionScreen({Key key, @required this.question}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question"),
      ),
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.question.title,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.question.content,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Divider(),
                HandledFutureBuilder<List<AnswerModel>>(
                    future: Answers.getAnswers(widget.question.id),
                    builder: (context, answers) {
                      return Column(
                        children: <Widget>[
                          for (AnswerModel answer in answers)
                            ListTile(
                              title: Text(answer.content),
                              subtitle: Text(answer.authorId),
                              trailing: IconButton(
                                icon: Icon(Icons.check),
                                onPressed: () {},
                              ),
                            ),
                        ],
                      );
                    })
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.question_answer),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateAnswerView(
                questionId: widget.question.id,
              ),
            ),
          );
          setState(() {});
        },
      ),
    );
  }
}
