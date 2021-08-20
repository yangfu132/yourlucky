import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';

typedef LoginCallback = void Function(String code, String message);

class SABLogInBusiness {
  final emailController = TextEditingController();
  final emailFocus = FocusNode();

  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();

  void logIn(LoginCallback callback) {
    SACContext.userAuth().signInWithEmailAndPassword(
        emailController.text, passwordController.text, (e) {
      callback(e.code, e.message ?? "");
    });
  }
}
