import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_text_viewer/flutter_text_viewer.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/A_Context/sac_release.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Text/sau_text_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/Text/sau_text_route_store.dart';
import 'package:your_lucky/src/B_UI/EasyDetail/sau_easy_detail_route.dart';
import 'package:your_lucky/src/B_UI/EasyResult/sau_easy_result_route.dart';
import 'package:your_lucky/src/B_UI/EasyResult/sau_easy_result_route_store.dart';
import 'package:your_lucky/src/B_UI/EasyStrategy/sau_strategy_result_route.dart';
import 'package:your_lucky/src/B_UI/User/About/sau_about_route.dart';
import 'package:your_lucky/src/B_UI/User/Debug/sau_debug_route.dart';
import 'package:your_lucky/src/B_UI/User/Developer/sau_develop_list_route.dart';
import 'package:your_lucky/src/B_UI/User/EasyStrategy/sau_easy_strategy_route.dart';
import 'package:your_lucky/src/B_UI/User/Feedback/sau_feedback_route.dart';
import 'package:your_lucky/src/B_UI/User/History/sau_history_list_route.dart';
import 'package:your_lucky/src/B_UI/User/Setting/sau_setting_route.dart';
import 'package:your_lucky/src/B_UI/User/SignIn/sau_set_password_route.dart';
import 'package:your_lucky/src/B_UI/User/SignIn/sau_signin_route.dart';
import 'package:your_lucky/src/B_UI/User/SignIn/sau_signup_route.dart';
import 'package:your_lucky/src/B_UI/User/SignOut/sau_signout_route.dart';
import 'package:your_lucky/src/B_UI/User/sau_user_route.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_business.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';

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
  static const setPassword = 'setPassword';
  static const logOut = 'logOut';
  static const signUp = 'signUp';
  static const expertCategory = 'expertCategory';
  static const debug = 'debug';
  static const easyText = 'easyText';
  static const easyResult = 'easyResult';
  static const historyDetail = 'historyDetail';
  static const userRoute = 'userRoute';

  // native route，所有native页面route必须添加 "Native/" 前缀
  static const nativePageA = 'Native/somePageA';
  static const nativePageB = 'Native/somePageB';
}

Widget mapRouteToPage(String route, Object? arguments) {
  Widget widget = Container();
  switch (route) {
    case SACRouteUrl.easyResult:
      widget = SACRelease.getEasyResultWidget(arguments);
      break;
    case SACRouteUrl.userRoute:
      widget = const SAUUserRoute();
      break;
    case SACRouteUrl.feedback:
      widget = const SAUFeedbackRoute();
      break;
    case SACRouteUrl.developer:
      widget = const SAUDevelopListRoute();
      break;
    case SACRouteUrl.friends:
      widget = const SAUAboutRoute();
      break;
    case SACRouteUrl.about:
      widget = const SAUAboutRoute();
      break;
    case SACRouteUrl.setting:
      widget = const SAUSettingRoute();
      break;
    case SACRouteUrl.logIn:
      widget = const SAUSignInRoute();
      break;
    case SACRouteUrl.setPassword:
      widget = const SAUSetPasswordRoute();
      break;
    case SACRouteUrl.logOut:
      widget = const SAUSignOutRoute();
      break;
    case SACRouteUrl.signUp:
      widget = const SAUSignupRoute();
      break;
    case SACRouteUrl.debug:
      widget = const SAUDebugRoute();
      break;
    case SACRouteUrl.expertCategory:
      widget = const SAUEasyStrategyRoute();
      break;
    case SACRouteUrl.history:
      widget = SAUHistoryListRoute();
      break;
    case SACRouteUrl.detail:
      SAUTextRouteStore store = SAUTextRouteStore();
      widget = SAUTextRoute(store:store);
      break;
    case SACRouteUrl.easyText:
      //widget = const SAUTextRoute();
      const kDebugMode = true;
      widget = TextViewerPage(
        textViewer: TextViewer.asset(
          'assets/easy.txt',
          highLightColor: Colors.yellow,
          focusColor: Colors.orange,
          ignoreCase: true,
          onErrorCallback: (error) {
            // show error in your UI
            if (kDebugMode) {
              coLog(StackTrace.current, LogTypeEnum.error, "Error: $error");
            }
          },
        ),
        showSearchAppBar: true,
      );
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
