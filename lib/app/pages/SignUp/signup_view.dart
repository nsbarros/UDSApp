import 'package:flutter/cupertino.dart';
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
        key: globalKey,
        appBar: AppBar(
          title: Text("UDS TECNOLOGIA",
            style: TextStyle(color: Colors.white)),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 60,
              left: 40,
              right: 40,
            ),
            child: ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    //color: Colors.white,
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape:BoxShape.rectangle,
                      image: DecorationImage(
                          image: AssetImage("images/logo.png")),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: widget._name,
                  style: new TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.black38),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: widget._email,
                  style: new TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    labelStyle: TextStyle(color: Colors.black38),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  controller: widget._password,
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black38),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                         Color.fromARGB(0, 72, 118, 255),
                          Colors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Signup",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            child: SizedBox(
                              child: Icon(Icons.arrow_forward),
                              height: 28,
                              width: 28,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        controller.signUp(widget._email.text, widget._password.text, widget._name.text);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}