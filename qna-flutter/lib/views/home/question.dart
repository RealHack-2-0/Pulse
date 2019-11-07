import 'package:flutter/material.dart';
import 'package:qna_flutter/views/question/question_screen.dart';

class QuestionView extends StatelessWidget {
  final String title;
  final String subtitle;
  final int votes;

  const QuestionView({Key key, this.title, this.subtitle, this.votes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text("$votes"),),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => QuestionScreen()));
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