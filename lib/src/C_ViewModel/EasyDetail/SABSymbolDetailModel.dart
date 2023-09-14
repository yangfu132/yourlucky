import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/C_ViewModel/EasyAnalysis/SABEasyAnalysisSymbolModel.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABSymbolDetailModel extends SABBaseModel {
  SABSymbolDetailModel(
      {required this.inputAnalysisSymbol,
        required this.baseInfo,
        required this.animalDes,
        required this.earthDes,
        required this.sixPairDes,
        required this.symbolHealthDes,
        required this.monthRelation,
        required this.dayRelation,
        required this.earthDirection,
        required this.diagramsPlace,
        required this.debugInfo});

  final SABEasyAnalysisSymbolModel inputAnalysisSymbol;

  final String baseInfo;

  final String animalDes;

  final String earthDes;

  final String sixPairDes;

  final String symbolHealthDes;

  final String monthRelation;

  final String dayRelation;

  final String earthDirection;

  final String diagramsPlace;

  final String debugInfo;

  final List<String> itemKeyList = ['基本信息','六神类象','地支类象', '六合','月将','日将','地支方位','所属八卦','调试信息'];

  String getSymbolName() {
    return this.inputAnalysisSymbol.inputHealthLogicSymbol.inputHealthSymbol.inputLogicSymbol.inputWordsSymbol.symbolName;
  }
  String itemValue(String itemKey) {
    String resultValue = '';
    switch (itemKey) {
      case '基本信息':
        resultValue = this.baseInfo;
        break;
      case '六神类象':
        resultValue = this.animalDes;
        break;
      case '地支类象':
        resultValue = this.earthDes;
        break;
      case '六合':
        resultValue = this.sixPairDes;
        break;
      case '月将':
        resultValue = this.monthRelation;
        break;
      case '日将':
        resultValue = this.dayRelation;
        break;
      case '地支方位':
        resultValue = this.earthDirection;
        break;
      case '所属八卦':
        resultValue = this.diagramsPlace;
        break;
      case '调试信息':
        resultValue = this.debugInfo;
        break;
      default:
        resultValue = itemKey + ' 未找到值 ';
        break;
    }
    return resultValue;
  }

  List<Map> resultList() {
    var result = List<Map>.empty(growable: true);
    for (String itemKey in this.itemKeyList) {
      result.add({'key':itemKey,'value':this.itemValue(itemKey)});
    }
    return result;
  }

  void check() {
    if (symbolHealthDes.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "symbolHealthDes.isEmpty");
    }
    if (monthRelation.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "monthRelation.isEmpty");
    }
    if (dayRelation.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "dayRelation.isEmpty");
    }
    super.check();
  }
}
