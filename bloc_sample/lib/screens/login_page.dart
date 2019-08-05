import 'package:bloc_sample/bloc/login_bloc.dart';
import 'package:bloc_sample/screens/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc = new LoginBloc();
  bool _showPass = false;
  TextEditingController _userController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.green,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: FlutterLogo()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Text(
                  'Hello batanlp\nWelcome Back',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                  stream: loginBloc.userStream,
                  builder: (context, snapshot) => TextField(
                        controller: _userController,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Username",
                          errorText: snapshot.hasError ? snapshot.error : null,
                          labelStyle: TextStyle(
                            color: Colors.amber,
                            fontSize: 15,
                          ),
                        ),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    StreamBuilder(
                      stream: loginBloc.passStream,
                      builder: (context, snapshot) => TextField(
                            controller: _passController,
                            obscureText: !_showPass,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Password",
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelStyle: TextStyle(
                                color: Colors.amber,
                                fontSize: 15,
                              ),
                            ),
                          ),
                    ),
                    GestureDetector(
                      onTap: onToggleShowHide,
                      child: Text(
                        _showPass ? "HIDE" : "SHOW",
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    onPressed: onSignInClick,
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "New user? Signup",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onToggleShowHide() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onSignInClick() {
    setState(() {
      if (loginBloc.isValidInfo(_userController.text, _passController.text)) {
        //Navigator.push(context, MaterialPageRoute(builder: gotoHomePage));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }
}