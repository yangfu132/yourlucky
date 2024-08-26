import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_list_cell_model.dart';
import 'package:your_lucky/src/B_UI/EasyResult/sau_easy_result_route.dart';
import 'package:your_lucky/src/B_UI/EasyResult/sau_easy_result_route_store.dart';
import 'package:your_lucky/src/B_UI/EasyStrategy/sau_strategy_result_route.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';

class SACRelease extends SABBaseModel {
  static Widget getEasyResultWidget(Object? arguments){
    Widget widget = Container();
    final detailModel = arguments as SABEasyDetailModel?;
    if (null != detailModel) {
      if (AppType.develop == SACContext.getAppType()) {
        widget = SAUStrategyResultRoute(detailModel);
      } else {
        SAUEasyResultRouteStore store = SAUEasyResultRouteStore(detailModel: detailModel);
        widget = SAUEasyResultRoute(store:store);
      } // end if
    } // else do nothing
    return widget;
  }

  static List<String> getItemKeyList (){
    if (AppType.release == SACContext.getAppType()) {
      final List<String> itemKeyList = ['基本信息',
        '六神类象','地支类象',
        '六合','月将','日将','地支方位','所属八卦','调试信息','计算信息','文本描述','空白'];
      return itemKeyList;
    } else {
      final List<String> releaseList = ['基本信息',
        '六神类象','地支类象','地支方位','六十四卦信息','文本描述','所属八卦'];
      return releaseList;
    }
  }

  static SAUListCellModel fromEasyDigitModel(SABEasyDigitModel model) {
    if (AppType.release == SACContext.getAppType()) {
      return SAUListCellModel.fromReleaseEasyDigitModel(model);
    } else {
      return SAUListCellModel.fromDevelopEasyDigitModel(model);
    }
  }
}