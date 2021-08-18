import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';

class SABLogInBusiness {
  final emailController = TextEditingController();
  final emailFocus = FocusNode();

  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();

  void logIn() {
    SACContext.userAuth().signInWithEmailAndPassword(
        emailController.text, passwordController.text, (e) {
      print('111');
    });
  }
}
