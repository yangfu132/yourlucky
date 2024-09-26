import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:yourlucky/src/B_UI/Common/Route/SAUDetailRoute.dart';
import 'package:yourlucky/src/B_UI/User/About/SAUAboutRoute.dart';
import 'package:yourlucky/src/B_UI/User/Debug/SAUDebugRoute.dart';
import 'package:yourlucky/src/B_UI/User/EasyStrategy/SAUEasyStrategyRoute.dart';
import 'package:yourlucky/src/B_UI/User/Feedback/SAUFeedbackRoute.dart';
import 'package:yourlucky/src/B_UI/User/History/SAUHistoryListRoute.dart';
import 'package:yourlucky/src/B_UI/User/History/SAUHistoryRoute.dart';
import 'package:yourlucky/src/B_UI/User/Setting/SAUSettingRoute.dart';
import 'package:yourlucky/src/B_UI/User/SignIn/SAUSignInRoute.dart';
import 'package:yourlucky/src/B_UI/User/SignIn/SAUSignupRoute.dart';
import 'package:yourlucky/src/B_UI/User/SignOut/SAUSignOutRoute.dart';

class SACRouteUrl {
  static const feedback = 'feedback';
  static const developer = 'developer';
  static const friends = 'friends';
  static const about = 'about';
  static const rateAndReview = 'rateAndReview';
  static const setting = 'setting';
  static const history = 'history';
  static const detail = 'detail';
  static const logIn = 'logIn';
  static const logOut = 'logOut';
  static const signUp = 'signUp';
  static const expertCategory = 'expertCategory';
  static const debug = 'debug';

  // native route，所有native页面route必须添加 "Native/" 前缀
  static const nativePageA = 'Native/somePageA';
  static const nativePageB = 'Native/somePageB';
}

Widget mapRouteToPage(String route, Object? arguments) {
  Widget widget = Container();
  switch (route) {
    case SACRouteUrl.feedback:
      widget = SAUFeedbackRoute();
      break;
    case SACRouteUrl.developer:
      widget = SAUAboutRoute();
      break;
    case SACRouteUrl.friends:
      widget = SAUAboutRoute();
      break;
    case SACRouteUrl.about:
      widget = SAUAboutRoute();
      break;
    case SACRouteUrl.setting:
      widget = SAUSettingRoute();
      break;
    case SACRouteUrl.logIn:
      widget = SAUSignInRoute();
      break;
    case SACRouteUrl.logOut:
      widget = SAUSignOutRoute();
      break;
    case SACRouteUrl.signUp:
      widget = SAUSignupRoute();
      break;
    case SACRouteUrl.debug:
      widget = SAUDebugRoute();
      break;
    case SACRouteUrl.expertCategory:
      widget = SAUEasyStrategyRoute();
      break;
    case SACRouteUrl.history:
      widget = SAUHistoryListRoute();
      break;
    case SACRouteUrl.detail:
      widget = SAUDetailRoute();
      break;
    default:
      break;
  }
  return widget;
}

const _nativeRouteMap = {
  SACRouteUrl.nativePageA: {
    // 使用 iOS Native 实际路由名
    'ios': 'iOSPageARoute',
    // 使用 Android Native 实际路由名
    'android': 'AndroidPageARoute',
  },
  SACRouteUrl.nativePageB: {
    'ios': 'iOSPageBRoute',
    'android': 'AndroidPageBRoute',
  },
};

String mapNativeRoute(String routeName) {
  if (Platform.isAndroid) {
    return _nativeRouteMap[routeName]!['android']!;
  } else {
    return _nativeRouteMap[routeName]!['ios']!;
  }
}
