import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/app/pages/PasswordReset/password_reset_view.dart';
import 'package:uds_app/app/pages/SignUp/signup_view.dart';
import 'package:uds_app/data/repositories/data_users_repository.dart';

import 'home_controller.dart';

class Home extends View{

  final _password = TextEditingController();
  final _email = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }

}

class _HomeState extends ViewState<Home, HomeController>{
  _HomeState() : super(HomeController(DataUsersRepository()));

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
              controller.logIn(widget._email.text, widget._password.text);
            },
            child: Text("Log-in"),
          ),
          RaisedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              );
            },
            child: Text("SignUp"),
          ),
          RaisedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PasswordReset()),
              );
            },
            child: Text("Password Reset"),
          )
        ],
      ),
    );
  }

}