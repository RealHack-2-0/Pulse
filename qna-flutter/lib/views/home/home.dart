import 'package:flutter/material.dart';
import 'package:qna_flutter/logic/models/question_model.dart';
import 'package:qna_flutter/logic/questions.dart';
import 'package:qna_flutter/views/helpers/handled_builders.dart';
import 'package:qna_flutter/views/home/question.dart';
import 'package:qna_flutter/views/question/create.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack Overflow Demo"),
        actions: <Widget>[],
      ),
      drawer: Drawer(),
      body: Container(
        child: HandledFutureBuilder<List<QuestionModel>>(
          future: Questions.getQuestions(),
          builder: (context, questions) {
            return ListView.builder(
                itemBuilder: (_, i) => QuestionView(question: questions[i]),
                itemCount: questions.length);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => CreateQuestionView()));
          setState(() {});
        },
      ),
    );
  }
}
