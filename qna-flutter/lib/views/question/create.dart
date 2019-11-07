import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qna_flutter/logic/questions.dart';
import 'package:qna_flutter/views/helpers/alert.dart';

class CreateQuestionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        centerTitle: true,
      ),
      body: CreateQuestionForm(),
    );
  }
}

class CreateQuestionForm extends StatefulWidget {
  CreateQuestionForm();

  @override
  _CreateQuestionFormState createState() => _CreateQuestionFormState();
}

class _CreateQuestionFormState extends State<CreateQuestionForm>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _isSaving;

  @override
  void initState() {
    _isSaving = false;
    super.initState();
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
                            _buildTitle("Title"),
                            _title,
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
                            child: Text("CreateQuestion"),
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

  Widget get _title => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          validators: [
            FormBuilderValidators.required(),
          ],
          attribute: "title",
          maxLines: 1,
          decoration: InputDecoration(
              helperText: "Title",
              hintText: "Good title for your question",
              border: OutlineInputBorder()),
        ),
      );

  Widget get _content => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          validators: [
            FormBuilderValidators.required(),
          ],
          keyboardType: TextInputType.phone,
          attribute: "content",
          maxLines: 1,
          decoration: InputDecoration(
              helperText: "Content",
              hintText: "Ask your question here...",
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
        await Questions.create(
          _fbKey.currentState.value['title'],
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
