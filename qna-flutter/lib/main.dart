import 'package:flutter/material.dart';
import 'package:qna_flutter/views/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'qna_flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.indigo,
          appBarTheme: AppBarTheme(elevation: 0)),
      home: SplashScreen(),
    );
  }
}
