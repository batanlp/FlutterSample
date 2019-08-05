import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:phong_tro/models/fb_user_info.dart';
import 'package:phong_tro/models/global.dart';

class FirebaseUtils {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginUser(String user, String pass, Function(FirebaseUser) onSuccess, Function(String) onError) {
    _firebaseAuth.signInWithEmailAndPassword(email: user, password: pass).then((user) {
      onSuccess(user);
    }).catchError((error) {
      onError(error.code);
    });
  }

  void registerUser(String name, String email, String phone, String pass,
      Function(FirebaseUser) onSuccess, Function(String) onRegisterError) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      _createUser(user, user.uid, name, phone, onSuccess, onRegisterError);
      //print(user);
    }).catchError((error) {
      _onRegisterError(error.code, onRegisterError);
    });
  }

  void loginByFBUser(AuthCredential credential, String token, FBUserInfo fbUserInfo, Function(FirebaseUser) onSuccess, Function(String) onError) {
    _firebaseAuth.signInWithCredential(credential).then((user) {
      //print('==========');
      //print(user);
      onSuccess(user);
    }).catchError((error) {
      print(error.code);
      onError(Global.msgLoginfail);
    });
  }

  _createUser(FirebaseUser firebaseUser, String userId, String name, String phone, Function(FirebaseUser) onSuccess,
      Function(String) onRegisterError) {
    var user = {Global.tableFieldName: name, Global.tableFieldPhone: phone};
    var ref = FirebaseDatabase.instance.reference().child(Global.firebaseTableUser);

    ref.child(userId).set(user).then((user) {
      onSuccess(firebaseUser);
    }).catchError((error) {
      onRegisterError(Global.msgSinupfail);
    });
  }

  void _onRegisterError(String code, Function(String) onRegisterError) {
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError(Global.msgInvalidEmail);
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError(Global.msgExistEmail);
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError(Global.msgWeakPass);
        break;
      default:
        onRegisterError(Global.msgSinupfail);
        break;
    }
  }
}
