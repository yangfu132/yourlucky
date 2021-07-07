import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/3L_Business/EasyLogic/Health/SABSymbolHealthModel.dart';

import '../BaseLogic/SABRowLogicModel.dart';

class SABRowHealthModel {
  SABRowHealthModel({
    required this.inputLogicRow,
    required this.fromSymbol,
    required this.toSymbol,
    required this.hideSymbol,
  });
  final SABRowLogicModel inputLogicRow;

  final SABSymbolHealthModel fromSymbol;
  final SABSymbolHealthModel toSymbol;
  final SABSymbolHealthModel hideSymbol;

  double healthForEasyType(EasyTypeEnum easyType) {
    double fHealth = 0.0;

    if (EasyTypeEnum.from == easyType) {
      fHealth = fromSymbol.doubleHealth;
    } else if (EasyTypeEnum.to == easyType) {
      fHealth = toSymbol.doubleHealth;
    } else if (EasyTypeEnum.hide == easyType) {
      fHealth = hideSymbol.doubleHealth;
    } else
      colog("error!");

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
      colog("error!");
  }

  void setHealthDesForEasyType(EasyTypeEnum easyType, String stringHealth) {
    if (EasyTypeEnum.from == easyType) {
      fromSymbol.stringHealth = stringHealth;
    } else if (EasyTypeEnum.to == easyType) {
      toSymbol.stringHealth = stringHealth;
    } else if (EasyTypeEnum.hide == easyType) {
      hideSymbol.stringHealth = stringHealth;
    } else
      colog("error!");
  }
}
