import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String itemName;
  final IconData icon;
  final Function onpressed;
  DrawerItem(
      {@required this.itemName, @required this.icon,this.onpressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 50,
      child: FlatButton(
        onPressed: onpressed,
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(25),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(
                  itemName,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
