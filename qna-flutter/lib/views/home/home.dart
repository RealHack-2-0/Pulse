import 'package:flutter/material.dart';
import 'package:qna_flutter/views/home/question.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stack Overflow Demo"),
      actions: <Widget>[

      ],),
      drawer: Drawer(
        
      ),
      body: Container(
        child:ListView(
          children: <Widget>[
            QuestionView(title: "How to add a image to Firebase?", subtitle: "10 minutes ago", votes: 43),
            QuestionView(title: "How to center a widget in Flutter?", subtitle: "5 seconds ago", votes: 8),
            QuestionView(title: "Wauestion", subtitle: "10 hours ago", votes: 9)
          ],
        )
      ),
    );  
  }
}