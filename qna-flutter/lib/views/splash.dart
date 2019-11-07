import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qna_flutter/views/account/login.dart';
import 'package:qna_flutter/views/home/home.dart';

import 'helpers/app_navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userEmail;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  void _authenticate() async {
    String currentUserEmail = await _getCurrentEmail();
    setState(() {
      userEmail = currentUserEmail;
    });
    await Future.delayed(Duration(seconds: 1));

    if (mounted) {
      if (currentUserEmail == null) {
        AppNavigator.pushAsFirst(context, (_) => LoginView());
      } else {
        AppNavigator.pushAsFirst(context, (_) => HomePage());
      }
    }
  }

  Future<String> _getCurrentEmail() async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SpinKitChasingDots(
            color: Theme.of(context).accentColor,
            size: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
    );
  }
}