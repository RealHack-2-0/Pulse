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
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      question.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 25, 10),
                    child: Text(
                      "@" + question.authorId,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Text(
                      question.content,
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.blueGrey),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FlatButton.icon(
                            color: question.hasUpvoted
                                ? Colors.amber
                                : Colors.grey[200],
                            icon: Icon(Icons.thumb_up),
                            label: Text("${question.upvotes.length}"),
                            onPressed: () async {
                              await Answers.upvote(question.id);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FlatButton.icon(
                            color: question.hasDownvoted
                                ? Colors.amber
                                : Colors.grey[200],
                            icon: Icon(Icons.thumb_down),
                            label: Text("${question.downvotes.length}"),
                            onPressed: () async {
                              await Answers.downvote(question.id);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                HandledFutureBuilder<List<AnswerModel>>(
                    future: Answers.getAnswers(question.id),
                    builder: (context, answers) {
                      return Column(
                        children: <Widget>[
                          Text("${answers.length} Answers",
                              textAlign: TextAlign.center),
                          for (AnswerModel answer in answers)
                            ListTile(
                              leading: CircleAvatar(
                                child: answer.isCorrect
                                    ? Icon(Icons.check)
                                    : Icon(Icons.hourglass_empty),
                              ),
                              title: Text(answer.content),
                              subtitle: Text(answer.authorId),
                              trailing: question.authorId ==
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

// class Answer extends StatelessWidget {
//   final String name;
//   final String content;
//   Answer({@required this.name, @required this.content});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//           child: ListTile(
//             leading: CircleAvatar(
//               child: Text("${name[0]}"),
//             ),
//             title: Text("$name"),
//           ),
//         ),
//         Padding(
//             padding: const EdgeInsets.fromLTRB(75, 0, 20, 5),
//             child: Text("$content")),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             FlatButton.icon(
//               icon: Icon(Icons.check),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadiusDirectional.circular(20),
//               ),
//               color: Colors.grey[200],
//               label: Text("Mark as correct"),
//               onPressed: () {},
//             ),
//           ],
//         ),
//         Divider(),
//       ],
//     );
//   }
// }
