///遇到的问题：
///问题1：如何全局引用context？
import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SABSingletonService.dart';
import 'package:yourlucky/src/3L_Business/DigitModel/SABEasyDigitBusiness.dart';
import 'package:yourlucky/src/3L_Business/EasyStrategyResult/Strategy/SABEasyStrategyInfoBusiness.dart';
import 'package:yourlucky/src/4L_Service/SABUserAuthService.dart';

void coLog(String strMsg) {
  print(strMsg);
}

class SACContext {
  final SABEasyDigitBusiness storeBusiness = SABEasyDigitBusiness();
  final SABUserAuthService userAuthService = SABUserAuthService();
  final SABEasyStrategyInfoBusiness categoryBusiness =
      SABEasyStrategyInfoBusiness();
  Future<void> initStep() async {
    await userAuthService.initFireAuth();
    await categoryBusiness.getsCategory();
  }

  static SABEasyStrategyInfoBusiness expertCategory() {
    SACContext businessContext = SABSingletonService.getObject('SACContext');
    return businessContext.categoryBusiness;
  }

  static SABEasyDigitBusiness easyStore() {
    SACContext businessContext = SABSingletonService.getObject('SACContext');
    return businessContext.storeBusiness;
  }

  static SABUserAuthService userAuth() {
    SACContext businessContext = SABSingletonService.getObject('SACContext');
    return businessContext.userAuthService;
  }

  static double screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static ButtonStyle textButtonStyle() {
    return ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.focused) &&
              !states.contains(MaterialState.pressed)) {
            //获取焦点时的颜色
            return Colors.lightGreen;
          } else if (states.contains(MaterialState.pressed)) {
            //按下时的颜色
            return Colors.grey;
          }
          //默认状态使用灰色
          return Colors.white;
        },
      ),
    );
  }
}
