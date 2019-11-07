import 'dart:async';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qna_flutter/logic/answers.dart';
import 'package:qna_flutter/logic/server/server_endpoints.dart';
import 'package:qna_flutter/views/helpers/alert.dart';

class CreateAnswerView extends StatelessWidget {
  final String questionId;

  const CreateAnswerView({Key key, this.questionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Answer"),
        centerTitle: true,
      ),
      body: CreateAnswerForm(questionId),
    );
  }
}

class CreateAnswerForm extends StatefulWidget {
  final String questionId;

  CreateAnswerForm(this.questionId);

  @override
  _CreateAnswerFormState createState() => _CreateAnswerFormState();
}

class _CreateAnswerFormState extends State<CreateAnswerForm>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _isSaving;

  void _websocket() async {
    final manager = SocketIOManager();
    final socket = await manager.createInstance(SocketOptions(
        ServerEndpoints.EMULATOR_HOST_IP_ADDRESS,
        nameSpace: "/pulse",
        enableLogging: true,
        transports: [Transports.POLLING]));
    socket.on("answer-added", (data) {
      if (data == widget.questionId) {
        Flushbar(
          title: "Alert",
          message: "Answer was submitted just now for this question",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
    socket.connect();
  }

  @override
  void initState() {
    _isSaving = false;
    _websocket();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _isSaving
        ? Center(
            child: SpinKitChasingDots(color: Theme.of(context).accentColor),
          )
        : Center(
            child: FormBuilder(
              key: _fbKey,
              child: Theme(
                data: Theme.of(context)
                    .copyWith(primaryColor: Theme.of(context).accentColor),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildTitle("Content"),
                            _content,
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Colors.indigo,
                            textColor: Colors.white,
                            child: Text("CreateAnswer"),
                            onPressed: () => _handleFormSubmit(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget get _content => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          validators: [
            FormBuilderValidators.required(),
          ],
          keyboardType: TextInputType.phone,
          attribute: "content",
          decoration: InputDecoration(
              helperText: "Content",
              hintText: "Ask your Answer here...",
              border: OutlineInputBorder()),
        ),
      );

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, bottom: 0.0, top: 20.0),
      child: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _handleFormSubmit() async {
    _fbKey.currentState.save();
    if (_fbKey.currentState.validate()) {
      setState(() {
        _isSaving = true;
      });

      try {
        await Answers.create(
          widget.questionId,
          _fbKey.currentState.value['content'],
        );
        Navigator.pop(context);
      } catch (e) {
        Alert.showAlertBox(context, e);
      }

      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
