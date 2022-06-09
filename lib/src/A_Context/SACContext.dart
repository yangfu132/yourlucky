///遇到的问题：
///问题1：如何全局引用context？
import 'package:flutter/material.dart';
import 'package:yourlucky/src/C_ViewModel/Strategy/SABEasyStrategyInfoBusiness.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitBusiness.dart';
import 'package:yourlucky/src/E_Service/SABSingletonService.dart';

void coLog(String strMsg) {
  print(strMsg);
}

class SACContext {
  final SABEasyDigitBusiness _storeBusiness = SABEasyDigitBusiness();
  final SABEasyStrategyInfoBusiness _categoryBusiness =
      SABEasyStrategyInfoBusiness();
  Future<void> initStep() async {
    await _categoryBusiness.getsCategory();
  }

  static SABEasyStrategyInfoBusiness expertCategory() {
    SACContext businessContext = SABSingletonService.getObject('SACContext');
    return businessContext._categoryBusiness;
  }

  static SABEasyDigitBusiness easyStore() {
    SACContext businessContext = SABSingletonService.getObject('SACContext');
    return businessContext._storeBusiness;
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
