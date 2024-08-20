///遇到的问题：
///问题1：如何全局引用context？
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_lucky/src/C_ViewModel/Strategy/sab_easy_strategy_info_business.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_business.dart';
import 'package:your_lucky/src/D_Business/User/sab_setting_business.dart';
import 'package:your_lucky/src/E_Service/sab_singleton_service.dart';

import '../D_Business/Develop/sab_develop_business.dart';
import 'sac_global.dart';
void testLog(String strMsg) {
  debugPrint(strMsg);
}

void coPrint(String strMsg) {
  coLog(StackTrace.current, LogTypeEnum.print, strMsg);
}

void coLog(StackTrace trace, LogTypeEnum logType, String strMsg) {
  if (LogTypeEnum.error == logType) {
    debugPrint('error');
  }
  debugPrint(strMsg);
}

class SACContext {
  final SABEasyDigitBusiness _storeBusiness = SABEasyDigitBusiness();
  final SABEasyStrategyInfoBusiness _categoryBusiness =
      SABEasyStrategyInfoBusiness();

  final SABSettingBusiness _settingBusiness = SABSettingBusiness();

  final SABDevelopBusiness _developBusiness = SABDevelopBusiness();

  final AppType appType = AppType.develop;

  static AppType getAppType() {
    SACContext businessContext = SABSingletonService.getObject('SACContext');
    if (1 == SACContext.setting().appType.intValue) {
      return AppType.release;
    } else {
      return businessContext.appType;
    }
  }

  static bool simulator() {
    return true;
  }

  ///SA 服务目录
  Future<void> initStep() async {
    await _categoryBusiness.getsCategory();
  }

  /// UI 服务目录
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

  ///拷贝到剪切板
  static void copyInfoToClipboard(String detail) {
    Clipboard.setData(ClipboardData(text: detail));
  }

  ///Business 服务目录
  static SABEasyStrategyInfoBusiness expertCategory() {
    SACContext businessContext = SABSingletonService.getObject('SACContext');
    return businessContext._categoryBusiness;
  }

  static SABEasyDigitBusiness easyStore() {
    SACContext businessContext = SABSingletonService.getObject('SACContext');
    return businessContext._storeBusiness;
  }

  static SABSettingBusiness setting() {
    SACContext businessContext = SABSingletonService.getObject('SACContext');
    return businessContext._settingBusiness;
  }

  static SABDevelopBusiness develop() {
    SACContext businessContext = SABSingletonService.getObject('SACContext');
    return businessContext._developBusiness;
  }

  static int uiRowToSymbolRow(int uiRow){
    return uiRow - 1;
  }
}
