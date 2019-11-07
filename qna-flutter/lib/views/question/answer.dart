import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: ListTile(
            leading: CircleAvatar(
              child: Text("A"),
            ),
            title: Text("Anju Chamantha"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(75, 0, 20, 5),
          child: Text(
              "My answer for this question is unknown. My answer for this question is unknown. My answer for this question is unknown. My answer for this question is unknown. My answer for this question is unknown. My answer for this question is unknown"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.check),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(20),
              ),
              color: Colors.grey[200],
              label: Text("Mark as correct"),
              onPressed: () {},
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
