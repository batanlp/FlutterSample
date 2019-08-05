import 'dart:async';
import 'package:bloc_sample/utils/validation.dart';

class LoginBloc {
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();

  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;

  bool isValidInfo(String user, String pass) {
    if (!Validation.isValidUser(user)) {
      _userController.sink.addError('User invalid');
      return false;
    }
    _userController.sink.add('OK');
    if (!Validation.isValidPass(pass)) {
      _passController.sink.addError('Password invalid');
      return false;
    }
    _passController.sink.add('OK');
    return true;
  }

  void dispose() {
    _userController.close();
    _passController.close();
  }
}
