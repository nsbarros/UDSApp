import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/app/pages/SignUp/signup_controller.dart';
import 'package:uds_app/data/repositories/data_users_repository.dart';

class SignUp extends View{

  final _password = TextEditingController();
  final _email = TextEditingController();
  final _name = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends ViewState<SignUp, SignUpController>{
  _SignUpState() : super(SignUpController(DataUsersRepository()));

  @override
  Widget buildPage() {
    return Scaffold(
      key:
      globalKey,
      appBar: AppBar(
        title: Text("UDS TECNOLOGIA",
          style: Theme.of(context).textTheme.subtitle,),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: widget._name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name:',
            ),
          ),
          TextField(
            controller: widget._email,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'E-mail',
            ),
          ),
          TextField(
            controller: widget._password,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          RaisedButton(
            onPressed: (){
              controller.signUp(widget._email.text, widget._password.text, widget._name.text);
            },
            child: Text("Sign-Up"),
          ),
        ],
      ),
    );
  }
}