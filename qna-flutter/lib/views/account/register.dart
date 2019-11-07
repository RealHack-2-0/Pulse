import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qna_flutter/logic/authentication.dart';
import 'package:qna_flutter/views/helpers/alert.dart';
import 'package:qna_flutter/views/helpers/app_navigator.dart';

import '../splash.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        centerTitle: true,
      ),
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  RegisterForm();

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
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
                            _buildTitle("Username"),
                            _username,
                            _buildTitle("Phone"),
                            _phone,
                            _buildTitle("Email"),
                            _email,
                            _buildTitle("Password"),
                            _password,
                            _buildTitle("Confirm Password"),
                            _confirmPassword,
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
                            child: Text("Register"),
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

  Widget get _username => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(4),
          ],
          attribute: "username",
          maxLines: 1,
          decoration: InputDecoration(
              helperText: "Username",
              hintText: "Your Name",
              border: OutlineInputBorder()),
        ),
      );

  Widget get _email => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ],
          keyboardType: TextInputType.emailAddress,
          attribute: "email",
          maxLines: 1,
          decoration: InputDecoration(
              helperText: "Email",
              hintText: "email@website.com",
              border: OutlineInputBorder()),
        ),
      );

  Widget get _phone => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.pattern(r"^\d{10}$"),
          ],
          keyboardType: TextInputType.phone,
          attribute: "phone",
          maxLines: 1,
          decoration: InputDecoration(
              helperText: "Phone Number",
              hintText: "0771234567",
              border: OutlineInputBorder()),
        ),
      );

  Widget get _password => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          validators: [
            FormBuilderValidators.required(),
          ],
          obscureText: true,
          attribute: "password",
          maxLines: 1,
          decoration: InputDecoration(
              helperText: "Password",
              hintText: "Password",
              border: OutlineInputBorder()),
        ),
      );

  Widget get _confirmPassword => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          validators: [
            FormBuilderValidators.required(),
          ],
          obscureText: true,
          maxLines: 1,
          attribute: "confirm_password",
          decoration: InputDecoration(
              helperText: "Confirm Password",
              hintText: "Confirm Password",
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

      bool isLoggedIn = await Authentication.signup(
          _fbKey.currentState.value['name'],
          _fbKey.currentState.value['email'],
          _fbKey.currentState.value['password'],
          _fbKey.currentState.value['confirm_password'], (e) {
        if (mounted) {
          Alert.showAlertBox(context, e);
        }
      });

      if (mounted) {
        setState(() {
          _isSaving = false;
        });
        if (isLoggedIn) {
          AppNavigator.pushAsFirst(context, (_) => SplashScreen());
        }
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}