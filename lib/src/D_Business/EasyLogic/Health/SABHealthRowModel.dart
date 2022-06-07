import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/Health/SABHealthSymbolModel.dart';

import '../BaseLogic/SABLogicRowModel.dart';

class SABHealthRowModel extends SABBaseModel {
  SABHealthRowModel({
    required this.inputLogicRow,
    required this.fromSymbol,
    required this.toSymbol,
    required this.hideSymbol,
  });
  final SABLogicRowModel inputLogicRow;

  final SABHealthSymbolModel fromSymbol;
  final SABHealthSymbolModel toSymbol;
  final SABHealthSymbolModel hideSymbol;

  double healthForEasyType(EasyTypeEnum easyType) {
    double fHealth = 0.0;

    if (EasyTypeEnum.from == easyType) {
      fHealth = fromSymbol.doubleHealth;
    } else if (EasyTypeEnum.to == easyType) {
      fHealth = toSymbol.doubleHealth;
    } else if (EasyTypeEnum.hide == easyType) {
      fHealth = hideSymbol.doubleHealth;
    } else
      coLog("error!");

    return fHealth;
  }

  void setHealthForEasyType(EasyTypeEnum easyType, double fHealth) {
    if (EasyTypeEnum.from == easyType) {
      fromSymbol.doubleHealth = fHealth;
    } else if (EasyTypeEnum.to == easyType) {
      toSymbol.doubleHealth = fHealth;
    } else if (EasyTypeEnum.hide == easyType) {
      hideSymbol.doubleHealth = fHealth;
    } else
      coLog("error!");
  }

  void setHealthDesForEasyType(EasyTypeEnum easyType, String stringHealth) {
    if (EasyTypeEnum.from == easyType) {
      fromSymbol.stringHealth = stringHealth;
    } else if (EasyTypeEnum.to == easyType) {
      toSymbol.stringHealth = stringHealth;
    } else if (EasyTypeEnum.hide == easyType) {
      hideSymbol.stringHealth = stringHealth;
    } else
      coLog("error!");
  }
}
