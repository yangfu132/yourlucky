import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/A_Context/sac_navigator.dart';
import 'package:your_lucky/src/A_Context/sac_release.dart';
import 'package:your_lucky/src/A_Context/sac_route_url.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/sau_toast_widget.dart';
import 'package:your_lucky/src/B_UI/User/SignIn/sau_set_password_route.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/D_Business/User/sab_login_model.dart';
import 'package:your_lucky/src/E_Service/FireBase/sas_fire_base_user_auth_service.dart';
import 'package:your_lucky/src/E_Service/Sqlite/sas_sqlite_service.dart';
import 'package:your_lucky/src/E_Service/sab_singleton_service.dart';

typedef SignInCallback = void Function(String code, String message);
typedef SignUpCallback = void Function(String code, String message);
typedef SignOutCallback = void Function(String code, String message);

class SABLogInBusiness extends SABBaseBusiness {
  SABLogInBusiness() {
    // _userAuthService.initFireAuth();
  }

  final SABLoginModel loginModel = SABLoginModel.empty();

  final SASSqliteService sqlite = SASSqliteService();

  // final SASFireBaseUserAuthService _userAuthService =
  //     SASFireBaseUserAuthService();

  final emailController = TextEditingController(text: '');
  final emailFocus = FocusNode();

  final nameController = TextEditingController(text: '');
  final nameFocus = FocusNode();

  final passwordController = TextEditingController(text: '');
  final passwordFocus = FocusNode();

  final confirmController = TextEditingController(text: '');
  final confirmFocus = FocusNode();

  //注册
  void signUp(SignUpCallback callback) {
    // _userAuthService.registerAccount(
    //     emailController.text, nameController.text, passwordController.text,
    //     (e) {
    //   callback(e.code, e.message ?? "成功");
    // });
  }

  void clearText(){
    emailController.text = '';
    passwordController.text = '';
    nameController.text = '';
    confirmController.text = '';
  }

  void setAppType(String name,String password) {
    var bytes = utf8.encode("$name+$password"); // data being hashed
    String digest = sha256.convert(bytes).toString();
    if ('cf7f0b89f407a4138411e23cb814cce38fb589ba7a76719a909a58c6cfa0a73f' == digest) {
      SACContext.setAppType(AppType.develop);
    } else {
      SACContext.setAppType(AppType.release);
    }
  }

  //登录
  void signIn(SignInCallback callback) {
    String email = emailController.text;
    String password = passwordController.text;
    load((dataList) {
      if (dataList.isNotEmpty) {
        if (email.isNotEmpty && password.isNotEmpty) {
          bool bFind = false;
          for (SABLoginModel model in dataList) {
            if (model.userMail == email && model.userPassword == password) {
              loginModel.setModel(model);
              bFind = true;
            }
          }
          if (bFind) {
            loginModel.isLogged = true;
            setAppType(email,password);
            callback('0','');
            clearText();
          } else {
            callback('-1','密码错误');
          }
        }
      };
    });

    // _userAuthService.signInWithEmailAndPassword(
    //     emailController.text, passwordController.text, (e) {
    //   callback(e.code, e.message ?? "成功");
    // });
  }

  //重置密码
  void sendPasswordResetEmail(BuildContext context) {
    // _userAuthService.sendPasswordResetEmail(emailController.text);
    SACNavigator.pushNamed(
        context,
        SACRouteUrl.setPassword,
        null
    );
  }

  //设置密码
  void setPassword(SignInCallback callback) {
    String userName = nameController.text;
    String userPassword = passwordController.text;
    String confirmPassword = confirmController.text;
    String userMail = emailController.text;
    if (userPassword == confirmPassword) {
      if (confirmPassword.isNotEmpty && userPassword.isNotEmpty && userMail.isNotEmpty) {
        load((dataList) {
          bool bFind = false;
          for (SABLoginModel model in dataList) {
            if (model.userMail == userMail) {
              loginModel.setModel(model);
              bFind = true;
            }
          }
          if (!bFind) {
            loginModel.setModel(SABLoginModel.empty());
          }
          loginModel.userName = userName;
          loginModel.userPassword = userPassword;
          loginModel.userMail = userMail;
          loginModel.loginType = LoginTypeEnum.textType;
          save(loginModel,callback);
        });
      } else {
        SAUToastWidget.show("信息不能为空");
      }
    } else {
      SAUToastWidget.show("密码输入不一致");
    }
  }

  void verifyPasswordResetCode(String code) {
    // _userAuthService.verifyPasswordResetCode(code);
  }

  void signOut(SignOutCallback callback) {
    clearText();
    loginModel.isLogged = false;
    callback('0', '成功');
    // _userAuthService.signOut();
    // callback('', '成功');
  }

  String displayName() {
    return loginModel.userName;
    // return _userAuthService.displayName;
  }

  bool isLogged() {
    return loginModel.isLogged;
    // return ApplicationLoginState.loggedIn == _userAuthService.loginState;
  }


  ///保存
  void save(SABLoginModel model, SignInCallback callback) {
    if (null == model.getModelId()) {
      sqlite.insertModel(model, (json) {
        if (json.isNotEmpty) {
          SABLoginModel savedModel = SABLoginModel.fromJson(json);
          printMsg('SABSettingModel:${SABLoginModel.fromJson(json)}');
          model.modelId = savedModel.modelId;
          callback('0','设置成功');
        } else {
          callback('-1','设置失败');
        }
      });
    } else {
      sqlite.updateModel(model,(int count){
        if (count > 0) {
          callback('0','设置成功');
        } else {
          callback('-1','设置失败');
        }
      });
    }
  }

  ///加载
  Future<void> load(void Function(List<SABLoginModel> dataList) refresh) async {
    List<SABLoginModel> dataList = <SABLoginModel>[];
    await sqlite.query('user_sign', (json) {
      dataList.add(SABLoginModel.fromJson(json));
    }, () {
      refresh(dataList);
    });
  }
}
