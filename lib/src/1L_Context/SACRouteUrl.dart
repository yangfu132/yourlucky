import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:yourlucky/src/2L_UI/Setting/History/SAUHistoryRoute.dart';
import 'package:yourlucky/src/2L_UI/Setting/LogIn/SAULoginRoute.dart';
import 'package:yourlucky/src/2L_UI/Setting/LogOut/SAULogOutRoute.dart';

class SACRouteUrl {
  static const history = 'history';
  static const logIn = 'logIn';
  static const logOut = 'logOut';

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
    case SACRouteUrl.logIn:
      widget = SAULoginRoute();
      break;
    case SACRouteUrl.logOut:
      widget = SAULogOutRoute();
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