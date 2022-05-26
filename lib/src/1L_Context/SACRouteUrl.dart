import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:yourlucky/src/2L_UI/EasyStrategy/SAUEasyStrategyRoute.dart';
import 'package:yourlucky/src/2L_UI/User/Debug/SAUDebugRoute.dart';
import 'package:yourlucky/src/2L_UI/User/History/SAUHistoryRoute.dart';
import 'package:yourlucky/src/2L_UI/User/SignIn/SAUSignInRoute.dart';
import 'package:yourlucky/src/2L_UI/User/SignIn/SAUSignupRoute.dart';

class SACRouteUrl {
  static const history = 'history';
  static const logIn = 'logIn';
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
    case SACRouteUrl.history:
      widget = SAUHistoryRoute();
      break;
    case SACRouteUrl.debug:
      widget = SAUDebugRoute();
      break;
    case SACRouteUrl.logIn:
      widget = SAUSignInRoute();
      break;
    case SACRouteUrl.signUp:
      widget = SAUSignupRoute();
      break;
    case SACRouteUrl.expertCategory:
      widget = SAUEasyStrategyRoute();
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
