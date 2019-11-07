import 'package:flutter/material.dart';
import 'package:qna_flutter/views/drawer/drawer.dart';
import 'package:qna_flutter/views/home/question.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(),
      appBar: AppBar(title: Text("Stack Overflow Demo"),
      actions: <Widget>[

      ],),
      drawer: MyDrawer(),
      body: Container(
        child:ListView(
          children: <Widget>[
            QuestionView(title: "How to add a image to Firebase?", subtitle: "10 minutes ago", upVotes: 15,downVotes:3),
            QuestionView(title: "How to center a widget in Flutter?", subtitle: "5 seconds ago", upVotes: 9,downVotes:63),
            QuestionView(title: "Can it possible to have good life as a programmer?", subtitle: "10 hours ago", upVotes: 9,downVotes:3)
          ],
        )
      ),
    );  
  }
}