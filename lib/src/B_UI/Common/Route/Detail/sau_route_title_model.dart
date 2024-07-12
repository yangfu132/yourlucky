import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_model.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_row_detail_model.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

typedef ContextCallback = void Function(BuildContext context,VoidCallback refreshAction);
class SAURouteTitleModel extends SABBaseModel {
  SAURouteTitleModel({required this.title,required this.actionTitle, required this.tapTitle});
  final String title;
  final String actionTitle;
  final ContextCallback tapTitle;


  static SAURouteTitleModel titleFromDetailModel(
      SABEasyDetailModel inputDetailModel,
      int intIndex,
      EasyTypeEnum easyType,
      ContextCallback tapTitle){

    SAURouteTitleModel titleModel = SAURouteTitleModel(
        title:resultTitle(inputDetailModel,intIndex,easyType),
        actionTitle: resultActionTitle(intIndex),
        tapTitle:tapTitle);
    return titleModel;
  }


  static String resultActionTitle(int intIndex) {
    if (0 == intIndex) {
      return '备注';
    } else {
      return '切换';
    }
  }

  static String resultTitle(SABEasyDetailModel inputDetailModel,int intIndex,EasyTypeEnum easyType) {
    if (0 == intIndex) {
      return inputDetailModel.digitModel().strStrategy;
    } else if (globalRowDay == intIndex) {
      return inputDetailModel.dayModel.strSymbolName;
    } else if (globalRowMonth == intIndex) {
      return inputDetailModel.monthModel.strSymbolName;
    } else {
      int nRow = intIndex -1;
      SABRowDetailModel rowModel =
      inputDetailModel.rowModelAtRow(intIndex - 1);
      String result = 'type：';
      switch (easyType) {
        case EasyTypeEnum.from:
          result = '本$nRow：';
          break;
        case EasyTypeEnum.to:
          result = '变$nRow：';
          break;
        case EasyTypeEnum.hide:
          result = '伏$nRow：';
          break;
        default:
          break;
      }
      return result + rowModel.getSymbolName(easyType);
    }
  }
}
