import 'package:flutter/material.dart';
import 'package:qna_flutter/logic/models/question_model.dart';
import 'package:qna_flutter/views/question/question_screen.dart';

class QuestionView extends StatelessWidget {
  final QuestionModel question;

  const QuestionView({Key key, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text("${question.votes}"),
      ),
      title: Text(question.title),
      subtitle: Text(question.content),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuestionScreen(
              questionId: question.id,
            ),
          ),
        );
      },
      // trailing: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: <Widget>[
      //   IconButton(icon: Icon(Icons.arrow_upward), onPressed: (){},),
      //   IconButton(icon: Icon(Icons.arrow_downward), onPressed: (){},)
      // ],),
    );
  }
}
