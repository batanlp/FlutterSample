import 'package:flutter/material.dart';
import 'package:phong_tro/bloc/register_bloc.dart';
import 'package:phong_tro/screens/dialog/loading_dialog.dart';
import 'package:phong_tro/screens/dialog/message_dialog.dart';
import 'package:phong_tro/screens/home_page.dart';
import 'package:phong_tro/models/global.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc registerBloc = RegisterBloc();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmpassController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    registerBloc.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    _confirmpassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(Global.register),
        elevation: 0,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text(
                  Global.registerWelcome,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: StreamBuilder(
                    stream: registerBloc.nameStream,
                    builder: (context, snapshot) => TextField(
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          controller: _nameController,
                          decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            labelText: Global.name,
                            prefixIcon: Container(
                              width: 50,
                              child: Icon(Icons.people),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                          ),
                        )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder(
                  stream: registerBloc.phoneStream,
                  builder: (context, snapshot) => TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        decoration: InputDecoration(
                          errorText: snapshot.hasError ? snapshot.error : null,
                          labelText: Global.phone,
                          prefixIcon: Container(
                            width: 50,
                            child: Icon(Icons.phone),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder(
                    stream: registerBloc.emailStream,
                    builder: (context, snapshot) => TextField(
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          controller: _emailController,
                          decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            labelText: Global.email,
                            prefixIcon: Container(
                              width: 50,
                              child: Icon(Icons.email),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                          ),
                        )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder(
                    stream: registerBloc.passStream,
                    builder: (context, snapshot) => TextField(
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          controller: _passController,
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            labelText: Global.password,
                            prefixIcon: Container(
                              width: 50,
                              child: Icon(Icons.security),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                          ),
                        )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                child: StreamBuilder(
                    stream: registerBloc.confirmpassStream,
                    builder: (context, snapshot) => TextField(
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          controller: _confirmpassController,
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            labelText: Global.confirmPassword,
                            prefixIcon: Container(
                              width: 50,
                              child: Icon(Icons.security),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                          ),
                        )),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  onPressed: onClickSignUp,
                  child: Text(
                    Global.signUp,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClickSignUp() {
    if (registerBloc.isValidInfo(
        _nameController.text,
        _emailController.text,
        _phoneController.text,
        _passController.text,
        _confirmpassController.text)) {
      
      LoadingDialog.showLoadingDialog(context, Global.alertLoading);
      registerBloc.registerUser(_nameController.text, _emailController.text, _phoneController.text, _passController.text, (user) {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user)));
      }, (errMsg) {
        // show message dialog
        LoadingDialog.hideLoadingDialog(context);
        MessageDialog.showMessageDialog(context, Global.alertLoading, errMsg);
      });
    }
  }
}
