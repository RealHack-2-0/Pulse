import 'package:flutter/material.dart';

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
        for (int i in [2,3,5,6,7,4,4,4,4,6])
          ListTile(
            title: Text("Answer"),
            subtitle: Text("Answer"),
            trailing: IconButton(
              icon: Icon(Icons.check),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
