
import 'package:flutter/material.dart';
import 'package:qna_flutter/views/drawer/drawerItem.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Anju Chamantha"),
            accountEmail: Text("chamantha97anju@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(
                "A",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          DrawerItem(itemName: "Account", icon: Icons.account_circle),
          DrawerItem(itemName: "Notifications", icon: Icons.notifications),
          DrawerItem(itemName: "Settings", icon: Icons.settings),
          DrawerItem(itemName: "Help", icon: Icons.help),
          DrawerItem(itemName: "About", icon: Icons.info),
          Divider(),
          DrawerItem(
            itemName: "Sign Out",
            icon: Icons.exit_to_app,
            onpressed: () async {
            },
          ),
        ],
      ),
    );
  }
}
