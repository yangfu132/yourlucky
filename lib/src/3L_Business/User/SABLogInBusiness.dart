import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/4L_Service/SABUserAuthService.dart';

typedef LoginCallback = void Function(String code, String message);

class SABLogInBusiness {
  final emailController = TextEditingController(text: 'yangfu132@163.com');

  final emailFocus = FocusNode();

  final passwordController = TextEditingController(text: '123456@Zc');
  final passwordFocus = FocusNode();

  void logIn(LoginCallback callback) {
    SACContext.userAuth().signInWithEmailAndPassword(
        emailController.text, passwordController.text, (e) {
      callback(e.code, e.message ?? "");
    });
  }

  bool isLogged() {
    return ApplicationLoginState.loggedIn == SACContext.userAuth().loginState;
  }
}
