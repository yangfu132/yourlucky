import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/BaseLogic/sab_easy_logic_business.dart';
import 'package:your_lucky/src/D_Business/EasyWords/sab_easy_words_model.dart';

import '../BaseLogic/sab_easy_logic_model.dart';

class SABOutRightBusiness extends SABBaseBusiness {
  SABOutRightBusiness(this._inputEasyModel);

  final SABEasyDigitModel _inputEasyModel;

  late final SABEasyLogicBusiness _logicBusiness =
      SABEasyLogicBusiness(_inputEasyModel);

  ///原函数名rowArrayAtLevel
  List<int> rowsAtOutRightLevel(OutRightEnum level) {
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
    OutRightEnum fResult = OutRightEnum.rightTypeNull;

    if (EasyTypeEnum.from == easyType) {
      fResult = fromBasicOutRightAtRow(nRow, easyType);
    } else if (EasyTypeEnum.to == easyType) {
      fResult = toOutRightAtRow(nRow, easyType);
    } else if (EasyTypeEnum.hide == easyType) {
      fResult = hideOutRightAtRow(hashCode, easyType);
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "error!");
    }
    return fResult;
  }

  OutRightEnum hideOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    return OutRightEnum.rightTypeHide;
  }

  OutRightEnum toOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    return OutRightEnum.rightTypeMoveTo;
  }

  OutRightEnum fromBasicOutRightAtRow(int nRow, EasyTypeEnum easyType) {
    /*
     7、旬空：无生克权
     6、休囚的静爻：无生克权
     5、旺相的静爻：可以生克休囚的静爻
     4、暗动：也叫半动，这个地方书籍不明确。我猜既然叫半动，必然不可以生克动爻，仅仅可以生克所有的静爻，比旺相静爻略强。
     3、动爻：可以生克所有的爻
     1、2代表日月：可以生克所有爻
     合是一种势，一种联系，日冲能打破这种势
     */
    OutRightEnum fResult = OutRightEnum.rightTypeNull;
    final symbolModel = logicModel().rowModelAtRow(nRow).symbolModel(easyType);
    if (null != symbolModel) {
      if (!symbolModel.isEmpty()) {
        fResult = basicOutRightUnEmpty(nRow,easyType);
      } else {
        fResult = OutRightEnum.rightTypeEmpty;
      }
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "symbolModel is null");
    }
    return fResult;
  }

  OutRightEnum basicOutRightUnEmpty(int nRow, EasyTypeEnum easyType){
    OutRightEnum fResult = OutRightEnum.rightTypeNull;
    final symbolModel = logicModel().rowModelAtRow(nRow).symbolModel(easyType);
    if (null != symbolModel) {
      bool bOnDay = symbolModel.isOnDay;
      bool bOnMonth = symbolModel.isOnMonth;
      bool bPairDay = symbolModel.isDayPair;
      bool bPairMonth = symbolModel.isMonthPair;
      if (bOnDay || bOnMonth || bPairDay || bPairMonth) {
        fResult = OutRightEnum.rightTypeMove;
      } else {
        bool bConflictDay = symbolModel.isConflictDay;
        bool bMove = wordsModel().isMovementAtRow(nRow);
        if (bMove) {
          fResult = OutRightEnum.rightTypeMove;
        } else if (bConflictDay) {
          fResult = OutRightEnum.rightTypeDayConflict;
        } else {
          fResult = OutRightEnum.rightTypeStatic;
        } //end if
      } //end if
    } else {
      coLog(StackTrace.current, LogTypeEnum.error, "symbolModel is null");
    }
    return fResult;
  }

  OutRightEnum updateDayConflictRight(OutRightEnum fResult, bool isStrong) {
    if (OutRightEnum.rightTypeDayConflict == fResult) {
      if (isStrong) {
        fResult = OutRightEnum.rightTypeMove;
      } else {
        fResult = OutRightEnum.rightTypeBroken;
      }
    }
    return fResult;
  }


  OutRightEnum OutRightUnEmpty(int nRow, EasyTypeEnum easyType,bool isStrong){
    OutRightEnum fResult = basicOutRightUnEmpty(nRow,easyType);
    fResult = updateDayConflictRight(fResult,isStrong);
    return fResult;
  }


  SABEasyLogicModel logicModel() {
    return _logicBusiness.outputLogicModel();
  }

  SABEasyWordsModel wordsModel() {
    return logicModel().inputWordsModel;
  }
}
