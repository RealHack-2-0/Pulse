import 'package:flutter/material.dart';
import 'package:qna_flutter/logic/models/question_model.dart';
import 'package:qna_flutter/views/question/question_screen.dart';

class QuestionView extends StatelessWidget {
  final QuestionModel question;

  const QuestionView({Key key, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      question.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${question.content}",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.thumb_up,
                          color: question.hasUpvoted ? Colors.green : null,
                        ),
                      ),
                      Text("${question.upvotes.length}"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.thumb_down,
                          color: question.hasDownvoted ? Colors.red : null,
                        ),
                      ),
                      Text("${question.downvotes.length}"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: question.resolved ? Colors.green : Colors.black,
              width: double.infinity,
              height: 5,
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => QuestionScreen(
                      questionId: question.id,
                    )));
      },
    );

    //  ListTile(
    //   leading: CircleAvatar(
    //     child: Text("${question.votes}"),
    //   ),
    //   title: Text(question.title),
    //   subtitle: Text(question.content),
    //   onTap: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (_) => QuestionScreen(
    //           questionId: question.id,
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
