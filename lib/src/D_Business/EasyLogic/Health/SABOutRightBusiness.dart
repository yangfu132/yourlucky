import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABEasyLogicBusiness.dart';
import 'package:yourlucky/src/D_Business/EasyWords/SABEasyWordsModel.dart';

import '../BaseLogic/SABEasyLogicModel.dart';

class SABOutRightBusiness extends SABBaseBusiness {
  SABOutRightBusiness(this._inputEasyModel);

  final SABEasyDigitModel _inputEasyModel;

  late final SABEasyLogicBusiness _logicBusiness =
      SABEasyLogicBusiness(_inputEasyModel);

  ///原函数名rowArrayAtLevel
  List<int> rowArrayAtOutRightLevel(OutRightEnum level) {
    final array = <int>[];

    for (int nRow = 0; nRow < 6; nRow++) {
      if (level == symbolOutRightAtRow(nRow, EasyTypeEnum.from)) {
        array.add(nRow);
      }
      //else cont.
    } //end for
    return array;
  }

  ///`输出值与输出权`//////////////////////////////////////////////////////

  OutRightEnum symbolOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    OutRightEnum fResult = OutRightEnum.RIGHT_NULL;

    if (EasyTypeEnum.from == easyType) {
      fResult = fromOutRightAtRow(nRow, easyType);
    } else if (EasyTypeEnum.to == easyType) {
      fResult = toOutRightAtRow(nRow, easyType);
    } else if (EasyTypeEnum.hide == easyType) {
      fResult = hideOutRightAtRow(hashCode, easyType);
    } else
      coLog(StackTrace.current, LogTypeEnum.error, "error!");

    return fResult;
  }

  OutRightEnum hideOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    return OutRightEnum.RIGHT_HIDE;
  }

  OutRightEnum toOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    OutRightEnum fResult = OutRightEnum.RIGHT_NULL;

    return fResult;
  }

  OutRightEnum fromOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    /*
     7、旬空：无生克权
     6、休囚的静爻：无生克权
     5、旺相的静爻：可以生克休囚的静爻
     4、暗动：也叫半动，这个地方书籍不明确。我猜既然叫半动，必然不可以生克动爻，仅仅可以生克所有的静爻，比旺相静爻略强。
     3、动爻：可以生克所有的爻
     1、2代表日月：可以生克所有爻
     合是一种势，一种联系，日冲能打破这种势
     */
    OutRightEnum fResult = OutRightEnum.RIGHT_NULL;
    final symbolModel = logicModel().rowModelAtRow(nRow).symbolModel(easyType);
    if (null != symbolModel) {
      if (!symbolModel.isEmpty()) {
        bool bPairDay = symbolModel.isDayPair;
        bool bPairMonth = symbolModel.isMonthPair;
        if (bPairDay || bPairMonth) {
          fResult = OutRightEnum.RIGHT_MOVE;
        } else {
          bool bConflictDay = symbolModel.isConflictDay;
          bool bMove = wordsModel().rowModelAtRow(nRow).bMovement;
          if (bMove)
            fResult = OutRightEnum.RIGHT_MOVE;
          else if (bConflictDay)
            fResult = OutRightEnum.RIGHT_Day_Conflict;
          else
            fResult = OutRightEnum.RIGHT_STATIC;
        } //end if
      } else {
        fResult = OutRightEnum.RIGHT_EMPTY;
      }
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "symbolModel is null");
    }

    return fResult;
  }

  SABEasyLogicModel logicModel() {
    return _logicBusiness.outputLogicModel();
  }

  SABEasyWordsModel wordsModel() {
    return logicModel().inputWordsModel;
  }
}
