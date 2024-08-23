import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_navigator.dart';
import 'package:your_lucky/src/A_Context/sac_route_url.dart';
import 'package:your_lucky/src/B_UI/User/SignIn/sau_set_password_route.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/D_Business/User/sab_login_model.dart';
import 'package:your_lucky/src/E_Service/FireBase/sas_fire_base_user_auth_service.dart';
import 'package:your_lucky/src/E_Service/Sqlite/sas_sqlite_service.dart';

typedef SignInCallback = void Function(String code, String message);
typedef SignUpCallback = void Function(String code, String message);
typedef SignOutCallback = void Function(String code, String message);

class SABLogInBusiness extends SABBaseBusiness {
  SABLogInBusiness() {
    // _userAuthService.initFireAuth();
  }

  late final SABLoginModel loginModel;

  final SASSqliteService sqlite = SASSqliteService();

  // final SASFireBaseUserAuthService _userAuthService =
  //     SASFireBaseUserAuthService();

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
    String name = nameController.text;
    String password = passwordController.text;
    load((dataList) {
      if (dataList.isNotEmpty) {
        if (name.isNotEmpty && password.isNotEmpty) {
          loginModel = dataList[0];
          if (loginModel.userName == name && loginModel.userPassword == password) {
            loginModel.isLogged = true;
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

  //登录
  void setPassword(SignInCallback callback) {
    String userName = nameController.text;
    String userPassword = passwordController.text;
    String userMail = passwordController.text;
    if (userName.isNotEmpty && userPassword.isNotEmpty && userMail.isNotEmpty) {
      load((dataList) {
        if (dataList.isNotEmpty) {
          loginModel = dataList[0];
        } else {
          loginModel = SABLoginModel(modelId: null,
              userName: userName,
              userPassword: userPassword,
              userMail: userMail,
              loginType: LoginTypeEnum.textType,
              dataJson: '',
              isLogged: false);
        }

        save(loginModel);
        callback('0','');
      });
    }
  }

  void verifyPasswordResetCode(String code) {
    // _userAuthService.verifyPasswordResetCode(code);
  }

  void signOut(SignOutCallback callback) {
    loginModel.isLogged = false;
    // _userAuthService.signOut();
    // callback('', '成功');
  }

  String? displayName() {
    return loginModel.userName;
    // return _userAuthService.displayName;
  }

  bool isLogged() {
    return loginModel.isLogged;
    // return ApplicationLoginState.loggedIn == _userAuthService.loginState;
  }


  ///保存
  void save(SABLoginModel model) {
    if (null == model.getModelId()) {
      sqlite.insertModel(model, (json) {
        SABLoginModel savedModel = SABLoginModel.fromJson(json);
        printMsg('SABSettingModel:${SABLoginModel.fromJson(json)}');
        model.modelId = savedModel.modelId;
      });
    } else {
      sqlite.updateModel(model);
    }
  }

  ///加载
  Future<void> load(void Function(List<SABLoginModel> dataList) refresh) async {
    List<SABLoginModel> dataList = <SABLoginModel>[];
    await sqlite.query('setting', (json) {
      dataList.add(SABLoginModel.fromJson(json));
    }, () {
      refresh(dataList);
    });
  }
}
