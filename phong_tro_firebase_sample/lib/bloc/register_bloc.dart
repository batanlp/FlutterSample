import 'dart:async';
import 'package:phong_tro/utils/fire_base_auth.dart';
import 'package:phong_tro/models/global.dart';

class RegisterBloc {
  FirebaseUtils _firebaseUtils = FirebaseUtils();
  StreamController _nameController = StreamController();
  StreamController _emailController = StreamController();
  StreamController _phoneController = StreamController();
  StreamController _passController = StreamController();
  StreamController _confirmpassController = StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get passStream => _passController.stream;
  Stream get confirmpassStream => _confirmpassController.stream;

  bool isValidInfo(String name, String email, String phone, String pass, String confirmpass) {
    if (name == null || name.length == 0) {
      _nameController.sink.addError(Global.invalidName);
      return false;
    }
    _nameController.sink.add('OK');

    if (phone == null || phone.length <= 9) {
      _phoneController.sink.addError(Global.invalidPhone);
      return false;
    }
    _phoneController.sink.add('OK');

    if (email == null || email.length == 0 || !email.contains('@')) {
      _emailController.sink.addError(Global.invalidEmail);
      return false;
    }
    _emailController.sink.add('OK');
    
    if (pass == null || pass.length < 6) {
      _passController.sink.addError(Global.msgWeakPass);
      return false;
    }
    _passController.sink.add('OK');

    if (confirmpass == null || confirmpass != pass) {
      _confirmpassController.sink.addError(Global.invalidConfirmpass);
      return false;
    }
    _confirmpassController.sink.add('OK');
    return true;
  }

  void registerUser(String name, String email, String phone, String pass, Function onSuccess, Function(String) onRegisterError) {
    _firebaseUtils.registerUser(name, email, phone, pass, onSuccess, onRegisterError);
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _phoneController.close();
    _passController.close();
    _confirmpassController.close();
  }
}