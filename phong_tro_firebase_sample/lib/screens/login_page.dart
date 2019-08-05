import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phong_tro/bloc/login_bloc.dart';
import 'package:phong_tro/models/global.dart';
import 'package:phong_tro/screens/dialog/loading_dialog.dart';
import 'package:phong_tro/screens/dialog/message_dialog.dart';
import 'package:phong_tro/screens/home_page.dart';
import 'package:phong_tro/screens/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc = LoginBloc();
  TextEditingController _userController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userController.dispose();
    _passController.dispose();
    _loginBloc.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text(
                  Global.welcome,
                  style: TextStyle(fontSize: 25, color: Colors.blue),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  Global.loginWelcome,
                  style: TextStyle(fontSize: 15, color: Colors.red),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: TextField(
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  controller: _userController,
                  decoration: InputDecoration(
                    labelText: Global.email,
                    prefixIcon: Container(
                      width: 50,
                      child: Icon(Icons.email),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextField(
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  obscureText: true,
                  controller: _passController,
                  decoration: InputDecoration(
                    labelText: Global.password,
                    prefixIcon: Container(
                      width: 50,
                      child: Icon(Icons.security),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints.loose(Size(double.infinity, 40)),
                alignment: Alignment.center,
                child: Text(
                  Global.forgotPassword,
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  onPressed: onClickSignIn,
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    onPressed: onClickSignInFB,
                    child: Text(
                      Global.signInFB,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: RichText(
                  text: TextSpan(
                    text: Global.newUser,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = onClickResgister,
                        text: Global.registerNewAccount,
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClickSignIn() {
    LoadingDialog.showLoadingDialog(context, Global.login);
    _loginBloc.doLogin(_userController.text, _passController.text, (user) {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage(user)));
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MessageDialog.showMessageDialog(context, Global.alertFail, msg);
    });
  }

  Future onClickSignInFB() async {
    final facebookLogin = FacebookLogin();
    // await facebookLogin.logOut();
    // facebookLogin.loginBehavior = FacebookLoginBehavior.webOnly;
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _processFBLogin(result.accessToken);
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        MessageDialog.showMessageDialog(context, Global.alertFail, result.errorMessage);
        break;
    }
  }

  void _processFBLogin(FacebookAccessToken fbAccessToken) {
    AuthCredential credential =
    FacebookAuthProvider.getCredential(accessToken: fbAccessToken.token);
    // print(fbAccessToken.token);
    LoadingDialog.showLoadingDialog(context, Global.alertLoading);
    _loginBloc.doLoginWithFB(credential, fbAccessToken.token, (user) {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage(user)));
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MessageDialog.showMessageDialog(context, Global.alertFail, msg);
    });
  }

  void onClickResgister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }
}