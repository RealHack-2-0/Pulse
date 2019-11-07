import 'package:flutter/material.dart';
import 'package:qna_flutter/views/question/question_screen.dart';

class QuestionView extends StatelessWidget {
  final String title;
  final String subtitle;
  final int downVotes;
  final int upVotes;

  const QuestionView(
      {Key key, this.title, this.subtitle, this.upVotes, this.downVotes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
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
                          "$subtitle",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.thumb_up),
                    ),
                    Text("$upVotes"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.thumb_down),
                    ),
                    Text("$downVotes"),
                  ],
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey[100]),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => QuestionScreen()));
      },
    );
  }
}
