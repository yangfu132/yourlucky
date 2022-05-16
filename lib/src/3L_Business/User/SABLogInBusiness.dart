import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';

typedef SignInCallback = void Function(String code, String message);
typedef SignUpCallback = void Function(String code, String message);
typedef SignOutCallback = void Function(String code, String message);

class SABLogInBusiness {
  final emailController = TextEditingController(text: 'yangfu132@163.com');
  final emailFocus = FocusNode();

  final nameController = TextEditingController(text: 'yangfu132');
  final nameFocus = FocusNode();

  final passwordController = TextEditingController(text: '123456@Zc');
  final passwordFocus = FocusNode();

  //注册
  void signUp(SignUpCallback callback) {
    // SACContext.userAuth().registerAccount(
    //     emailController.text, nameController.text, passwordController.text,
    //     (e) {
    //   callback(e.code, e.message ?? "成功");
    // });
  }

  //登录
  void signIn(SignInCallback callback) {
    // SACContext.userAuth().signInWithEmailAndPassword(
    //     emailController.text, passwordController.text, (e) {
    //   callback(e.code, e.message ?? "成功");
    // });
  }

  //重置密码
  void sendPasswordResetEmail() {
    // SACContext.userAuth().sendPasswordResetEmail(emailController.text);
  }

  void verifyPasswordResetCode(String code) {
    // SACContext.userAuth().verifyPasswordResetCode(code);
  }

  void signOut(SignOutCallback callback) {
    // SACContext.userAuth().signOut();
    // callback('', '成功');
  }

  String? displayName() {
    return SACContext.userAuth().displayName;
  }

  bool isLogged() {
    return false;
    // return ApplicationLoginState.loggedIn == SACContext.userAuth().loginState;
  }
}
