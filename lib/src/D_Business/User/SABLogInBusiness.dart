import 'package:flutter/material.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/E_Service/FireBase/SASFireBaseUserAuthService.dart';

typedef SignInCallback = void Function(String code, String message);
typedef SignUpCallback = void Function(String code, String message);
typedef SignOutCallback = void Function(String code, String message);

class SABLogInBusiness extends SABBaseBusiness {
  SABLogInBusiness() {
    _userAuthService.initFireAuth();
  }
  final SASFireBaseUserAuthService _userAuthService =
      SASFireBaseUserAuthService();

  final emailController = TextEditingController(text: 'yangfu132@163.com');
  final emailFocus = FocusNode();

  final nameController = TextEditingController(text: 'yangfu132');
  final nameFocus = FocusNode();

  final passwordController = TextEditingController(text: '123456@Zc');
  final passwordFocus = FocusNode();

  //注册
  void signUp(SignUpCallback callback) {
    // _userAuthService.registerAccount(
    //     emailController.text, nameController.text, passwordController.text,
    //     (e) {
    //   callback(e.code, e.message ?? "成功");
    // });
  }

  //登录
  void signIn(SignInCallback callback) {
    // _userAuthService.signInWithEmailAndPassword(
    //     emailController.text, passwordController.text, (e) {
    //   callback(e.code, e.message ?? "成功");
    // });
  }

  //重置密码
  void sendPasswordResetEmail() {
    // _userAuthService.sendPasswordResetEmail(emailController.text);
  }

  void verifyPasswordResetCode(String code) {
    // _userAuthService.verifyPasswordResetCode(code);
  }

  void signOut(SignOutCallback callback) {
    // _userAuthService.signOut();
    // callback('', '成功');
  }

  String? displayName() {
    return _userAuthService.displayName;
  }

  bool isLogged() {
    return false;
    // return ApplicationLoginState.loggedIn == _userAuthService.loginState;
  }
}
