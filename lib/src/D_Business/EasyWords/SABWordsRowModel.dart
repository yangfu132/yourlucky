﻿import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABWordsSymbolModel.dart';

import '../../A_Context/SACGlobal.dart';

class SABWordsRowModel extends SABBaseModel {
  SABWordsRowModel({
    required this.intDigit,
    required this.fromSymbol,
    required this.toSymbol,
    required this.hideSymbol,
    required this.bMovement,
    required this.stringAnimal,
    required this.desOfGoalOrLife,
    required this.stringDiagrams,
  });
  final int intDigit;
  final bool bMovement;
  final String stringAnimal;
  final String stringDiagrams;
  final String desOfGoalOrLife;
  final SABWordsSymbolModel fromSymbol;
  final SABWordsSymbolModel toSymbol;
  final SABWordsSymbolModel hideSymbol;

  void check() {
    if (stringAnimal.isEmpty) {
      coLog("stringAnimal.isEmpty");
    }
    if (stringDiagrams.isEmpty) {
      coLog("stringDiagrams.isEmpty");
    }
    if (desOfGoalOrLife.isEmpty) {
      coLog("desOfGoalOrLife.isEmpty");
    }
    fromSymbol.check();
    toSymbol.check();
    hideSymbol.check();
    super.check();
  }

  String getEarlyPlace(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.earlyPlace;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.earlyPlace;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.earlyPlace;
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getLatePlace(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.latePlace;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.latePlace;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.latePlace;
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSymbolName(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.symbolName;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.symbolName;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.symbolName;
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSymbolParent(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.stringParent;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.stringParent;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.stringParent;
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSymbolEarth(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.stringEarth;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.stringEarth;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.stringEarth;
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }

  String getSymbolElement(EasyTypeEnum easyTypeEnum) {
    if (easyTypeEnum == EasyTypeEnum.from) {
      return fromSymbol.stringElement;
    } else if (easyTypeEnum == EasyTypeEnum.to) {
      return toSymbol.stringElement;
    } else if (easyTypeEnum == EasyTypeEnum.hide) {
      return hideSymbol.stringElement;
    } else
      return 'easyTypeEnum:$easyTypeEnum';
  }
}
