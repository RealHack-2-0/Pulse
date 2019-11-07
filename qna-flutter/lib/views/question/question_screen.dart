import 'package:flutter/material.dart';

class QuestionScreen extends StatelessWidget {
  final String title;
  final String content;
  final int downVotes;
  final int upVotes;
  final String author;

  const QuestionScreen(
      {Key key,
      this.title,
      this.content,
      this.upVotes,
      this.downVotes,
      this.author})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                title,
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
                "@" + author,
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Text(
                this.content,
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
                      color: Colors.grey[200],
                      icon: Icon(Icons.thumb_up),
                      label: Text("$upVotes"),
                      onPressed: () => {},
                    ),
                  ),
                ),
                Expanded(
                                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FlatButton.icon(
                      color: Colors.grey[200],
                      icon: Icon(Icons.thumb_down),
                      label: Text("$downVotes"),
                      onPressed: () => {},
                    ),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
