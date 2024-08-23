import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/B_UI/EasyDetail/sau_easy_text_route_store.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SABSymbolDetailModel extends SABBaseModel {
  SABSymbolDetailModel({
    required this.strSymbolName,
    required this.baseInfo,
    required this.animalDes,
    required this.earthDes,
    required this.sixPairDes,
    required this.monthRelation,
    required this.dayRelation,
    required this.earthDirection,
    required this.diagramsPlace,
    required this.debugInfo,
    required this.stringHealth,
    required this.easyKey,
  });

  final String strSymbolName;

  final String baseInfo;

  final String animalDes;

  final String earthDes;

  final String sixPairDes;

  final String easyKey;

  late String symbolHealthDes = getSymbolHealthDes();

  final String monthRelation;

  final String dayRelation;

  final String earthDirection;

  final String diagramsPlace;

  final String debugInfo;

  final String stringHealth;

  final List<String> itemKeyList = ['基本信息',
    '六神类象','地支类象',
    '六合','月将','日将','地支方位','所属八卦','调试信息','计算信息','文本描述','空白'];

  List<String> getItemKeyList (){
    if (AppType.release == SACContext.getAppType()) {
      return itemKeyList;
    } else {
      final List<String> releaseList = ['基本信息',
        '六神类象','地支类象','地支方位','六十四卦信息','文本描述','所属八卦'];
      return releaseList;
    }
  }

  String getSymbolName() {
    return strSymbolName;
    //return inputAnalysisSymbol.inputHealthLogicSymbol.inputHealthSymbol.inputLogicSymbol.inputWordsSymbol.symbolName;
  }


  String getSymbolHealthDes() {
    String stringResult = "";
    //final stringHealth = inputAnalysisSymbol.inputHealthLogicSymbol.inputHealthSymbol.healthDescription();
    stringResult = '${getSymbolName()}[$stringHealth]';
    return stringResult;
  }

  String itemValue(String itemKey) {
    String resultValue = '';
    switch (itemKey) {
      case '基本信息':
        resultValue = baseInfo;
        break;
      case '六神类象':
        resultValue = animalDes;
        break;
      case '地支类象':
        resultValue = earthDes;
        break;
      case '六合':
        resultValue = sixPairDes;
        break;
      case '月将':
        resultValue = monthRelation;
        break;
      case '日将':
        resultValue = dayRelation;
        break;
      case '地支方位':
        resultValue = earthDirection;
        break;
      case '所属八卦':
        resultValue = diagramsPlace;
        break;
      case '调试信息':
        resultValue = debugInfo;
        break;
      case '计算信息':
        resultValue = 'ActionList';
        break;
      case '六十四卦信息':
        resultValue = easyKey;
        break;
      case '空白':
        resultValue = '空白';
      case '文本描述':
      resultValue = '点击查看详情';
      default:
        resultValue = '$itemKey 未找到值 ';
        break;
    }
    return resultValue;
  }

  List<Map> resultList() {
    var result = List<Map>.empty(growable: true);
    for (String itemKey in itemKeyList) {
      result.add({'key':itemKey,'value':itemValue(itemKey)});
    }
    return result;
  }

  @override void check() {
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
