import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SASLocalizationsService {
  SASLocalizationsService(this.isZh);
  //是否为中文
  bool isZh = false;

  static String localizationsString(
      BuildContext context, String stringZh, String stringEn) {
    SASLocalizationsService? service =
        Localizations.of<SASLocalizationsService>(
            context, SASLocalizationsService);

    if (null != service) {
      return service.isZh ? stringZh : stringEn;
    } else {
      return stringZh;
    }
  }

  static String homeEasy(BuildContext context) {
    return localizationsString(context, "开始", "Easy");
  }

  static String homeUser(BuildContext context) {
    return localizationsString(context, "用户", "User");
  }

  static String userFeedback(BuildContext context) {
    return localizationsString(context, "意见反馈", "Feedback");
  }

  static String userDevelopTask(BuildContext context) {
    return localizationsString(context, "开发计划", "Develop Task");
  }

  static String userFriends(BuildContext context) {
    return localizationsString(context, "好友列表", "Friends");
  }

  static String userAbout(BuildContext context) {
    return localizationsString(context, "关于App", "About");
  }

  static String userRateAndReview(BuildContext context) {
    return localizationsString(context, "评分鼓励", "Rate And Review");
  }

  static String userSetting(BuildContext context) {
    return localizationsString(context, "设置", "Setting");
  }

  static String userSignUp(BuildContext context) {
    return localizationsString(context, "注册", "Sign Up");
  }

  static String userLogIn(BuildContext context) {
    return localizationsString(context, "登录", "Sign In");
  }

  static String userForget(BuildContext context) {
    return localizationsString(context, "重置密码", "Forget");
  }

  static String userSignOut(BuildContext context) {
    return localizationsString(context, "退出登录", "Sign Out");
  }

  static String userDebug(BuildContext context) {
    return localizationsString(context, "调试", "Debug");
  }

  static String userHistory(BuildContext context) {
    return localizationsString(context, "历史", "History");
  }

  static String userCategory(BuildContext context) {
    return localizationsString(context, "门类", "Category");
  }
}

//Locale代理类
class SASLocalizationsDelegate
    extends LocalizationsDelegate<SASLocalizationsService> {
  const SASLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<SASLocalizationsService> load(Locale locale) {
    print("$locale");
    return SynchronousFuture<SASLocalizationsService>(
        SASLocalizationsService(locale.languageCode == "zh"));
  }

  @override
  bool shouldReload(SASLocalizationsDelegate old) => false;
}
