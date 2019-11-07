import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String name;
  final String content;
  Answer({@required this.name,@required this.content});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: ListTile(
            leading: CircleAvatar(
              child: Text("${name[0]}"),
            ),
            title: Text("$name"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(75, 0, 20, 5),
          child: Text("$content")),
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
