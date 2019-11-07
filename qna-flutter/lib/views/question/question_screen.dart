import 'package:flutter/material.dart';
import 'package:qna_flutter/views/question/answer.dart';

class QuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Question Title",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Question Content",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Divider(),
        Answer(),
        ],
      ),
    );
  }
}
