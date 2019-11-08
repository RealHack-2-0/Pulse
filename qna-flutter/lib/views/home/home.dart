import 'dart:async';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:qna_flutter/logic/authentication.dart';
import 'package:qna_flutter/logic/models/question_model.dart';
import 'package:qna_flutter/logic/questions.dart';
import 'package:qna_flutter/logic/server/server_endpoints.dart';
import 'package:qna_flutter/logic/server/server_manager.dart';
import 'package:qna_flutter/views/helpers/handled_builders.dart';
import 'package:qna_flutter/views/home/question.dart';
import 'package:qna_flutter/views/question/create.dart';
import 'package:qna_flutter/views/question/question_screen.dart';
import 'package:qna_flutter/views/splash.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<List<QuestionModel>> _streamController;

  void _websocketAuthor() async {
    final manager = SocketIOManager();
    final socket = await manager.createInstance(SocketOptions(
        ServerEndpoints.EMULATOR_HOST_IP_ADDRESS,
        nameSpace: "/pulse",
        enableLogging: true,
        transports: [Transports.POLLING]));
    socket.on("my-question-answered", (data) {
      Map<String, dynamic> map = Map<String, dynamic>.from(data);
      print(ServerManager().userId);
      if (map["authorId"] == ServerManager().userId) {
        Flushbar(
          title: "Answer Posted",
          message: "Answer was submitted just now for this question",
          duration: Duration(seconds: 10),
          mainButton: FlatButton(
            textColor: Colors.white,
            child: Text("Show"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuestionScreen(
                    questionId: map["questionId"],
                  ),
                ),
              );
            },
          ),
        )..show(context);
      }
    });
    socket.connect();
  }

  void _websocket() async {
    _streamController = StreamController<List<QuestionModel>>();
    final manager = SocketIOManager();
    final socket = await manager.createInstance(SocketOptions(
        ServerEndpoints.EMULATOR_HOST_IP_ADDRESS,
        nameSpace: "/pulse",
        enableLogging: true,
        transports: [Transports.POLLING]));
    socket.on("all-questions", (data) {
      List<Map<String, dynamic>> maps = List<Map<String, dynamic>>.from(data);
      _streamController.add(maps.map((v) => QuestionModel.fromMap(v)).toList());
    });
    socket.connect();
  }

  @override
  void initState() {
    _websocketAuthor();
    _websocket();
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QnA"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SplashScreen()));
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            HandledFutureBuilder<Map<String, dynamic>>(
                future: Authentication.getUserData(ServerManager().userId),
                builder: (context, user) {
                  return UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      child: Text(
                        "${user["firstName"][0]}",
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                    accountEmail: Text(user["email"]),
                    accountName:
                        Text("${user["firstName"]} ${user["lastName"]}"),
                  );
                }),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Question"),
              subtitle: Text("Add a new question"),
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CreateQuestionView()));
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              subtitle: Text("Exit from the app"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SplashScreen()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: HandledStreamBuilder<List<QuestionModel>>(
            stream: _streamController.stream,
            builder: (context, questions) {
              return ListView.builder(
                  itemBuilder: (_, i) => QuestionView(question: questions[i]),
                  itemCount: questions.length);
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Question"),
        icon: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => CreateQuestionView()));
          setState(() {});
        },
      ),
    );
  }
}
