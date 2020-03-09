import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:uds_app/app/pages/PasswordReset/password_reset_controller.dart';
import 'package:uds_app/data/repositories/data_users_repository.dart';

class PasswordReset extends View{

  final _email = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return _PasswordResetState();
  }
}

class _PasswordResetState extends ViewState<PasswordReset, PasswordResetController> {
  _PasswordResetState() : super(PasswordResetController(DataUsersRepository()));

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
          RaisedButton(
            onPressed: (){
              controller.resetPassword(widget._email.text);
            },
            child: Text("Reset"),
          ),
        ],
      ),
    );
  }
}