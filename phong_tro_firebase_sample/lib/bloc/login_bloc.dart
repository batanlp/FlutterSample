import 'package:firebase_auth/firebase_auth.dart';
import 'package:phong_tro/models/fb_user_info.dart';
import 'package:phong_tro/utils/fire_base_auth.dart';
import 'package:phong_tro/utils/network_connection.dart';
import 'dart:convert';

class LoginBloc {
  FirebaseUtils _firebaseUtils = FirebaseUtils();
  NetworkConnection _networkConnection = NetworkConnection();

  void doLogin(
      String user, String pass, Function onSuccess, Function(String) onError) {
    _firebaseUtils.loginUser(user, pass, onSuccess, onError);
  }

  void doLoginWithFB(AuthCredential credential, String token,
      Function onSuccess, Function(String) onError) {
    _networkConnection.getFacebookUserInfo(token, (fbUserInfo) {
      // Create firebase User
      //print(fbUserInfo);
      _firebaseUtils.loginByFBUser(credential, token,
          FBUserInfo.fromJson(json.decode(fbUserInfo)), onSuccess, onError);
    }, onError);
  }

  void dispose() {

  }
}
