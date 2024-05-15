import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
import 'package:your_lucky/src/D_Business/BasicEasy/sab_diagrams_info_model.dart';
import 'package:your_lucky/src/D_Business/BasicEasy/sab_element_info_model.dart';

class SABDigitDiagramsModel extends SABBaseModel {
  SABDigitDiagramsModel({
    required this.fromEasyKey,
    required this.toEasyKey,
    required this.strUsefulDeity,
  }) {
     stringFromName = _fromEasyName();
     stringToName = _toEasyName();
     stringFromElement = _eightDiagrams.elementOfEasy(_fromEasyName());
     stringToElement = _eightDiagrams.elementOfEasy(_toEasyName());
     stringFromPlace = _eightDiagrams.easyPlaceByName(_fromEasyName());
     stringToPlace = _eightDiagrams.easyPlaceByName(_toEasyName());
     mapFromEasy = _fromEasyDictionary();
     mapToEasy = _toEasyDictionary();
     mapHideEasy = _placeFirstEasy();
     bFromPureEasy = 0 == _lifeIndexAtEasy(_fromEasyDictionary());
     bToPureEasy = 0 == _lifeIndexAtEasy(_toEasyDictionary());
     lifeIndex = _lifeIndex();
     goalIndex = _goalIndex();
     deityElement = SABElementInfoModel.elementByRelative(
         stringFromElement, strUsefulDeity);
  }

  //属性：实例的用神
  final String strUsefulDeity;
  final String fromEasyKey;
  final String toEasyKey;
  late final SABDiagramsInfoModel _eightDiagrams = SABDiagramsInfoModel();

  ///卦
  late final String stringFromName;
  late final String stringFromPlace;
  late final String stringFromElement;
  late final String stringToName;
  late final String stringToPlace;
  late final String stringToElement;
  late final Map mapFromEasy;
  late final Map mapToEasy;
  late final Map mapHideEasy;
  late final int lifeIndex;
  late final int goalIndex;
  late final String deityElement;

  ///纯卦
  late final bool bFromPureEasy;
  late final bool bToPureEasy;

  @override void check() {
    _eightDiagrams.check();
    if (fromEasyKey.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "fromEasyKey.isEmpty");
    }
    if (toEasyKey.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "toEasyKey.isEmpty");
    }
    if (strUsefulDeity.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "strUsefulDeity.isEmpty");
    }
    if (stringFromName.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringFromName.isEmpty");
    }
    if (stringFromPlace.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringFromPlace.isEmpty");
    }

    if (stringFromElement.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringFromElement.isEmpty");
    }
    if (stringToName.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringToName.isEmpty");
    }
    if (stringToPlace.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringToPlace.isEmpty");
    }

    if (stringToElement.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringToElement.isEmpty");
    }
    if (deityElement.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "deityElement.isEmpty");
    }
    if (mapFromEasy.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "mapFromEasy.isEmpty");
    }
    if (mapToEasy.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "mapToEasy.isEmpty");
    }
    if (mapHideEasy.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "mapHideEasy.isEmpty");
    }
    super.check();
  }

  ///此方法获取本卦的卦名
  String _fromEasyName() {
    String stringResult = "";
    Map fromDict = _fromEasyDictionary();
    if (fromDict.isNotEmpty) {
      stringResult = fromDict["name"];
    }
    //else cont.

    return stringResult;
  }

  ///此方法获取变卦的卦名
  String _toEasyName() {
    String stringResult = "";
    Map toDict = _toEasyDictionary();
    if (toDict.isNotEmpty) {
      stringResult = toDict["name"];
    }
    //else cont.
    return stringResult;
  }

  ///此方法获取本卦在八宫中的信息
  Map _fromEasyDictionary() {
    Map result = _eightDiagrams.getEasyDictionaryForKey(fromEasyKey);
    return result;
  }

  ///此方法获取变卦在八宫中的信息
  Map _toEasyDictionary() {
    Map result = _eightDiagrams.getEasyDictionaryForKey(toEasyKey);
    return result;
  }

  ///方法注释：获取本卦所在八宫的第一卦
  Map _placeFirstEasy() {
    String firstKey = _eightDiagrams
        .firstEasyKeyInDiagram(_eightDiagrams.easyPlaceByName(_fromEasyName()));
    Map firstEasy = _eightDiagrams.getEasyDictionaryForKey(firstKey);
    return firstEasy;
  }

  //在本卦中，获得世的索引号；
  int _lifeIndex() {
    Map fromDict = _fromEasyDictionary();
    int shiIndex = fromDict["世"];
    return 6 - shiIndex;
  }

  //在指定卦中，获得世的索引号；
  int _lifeIndexAtEasy(Map easyDict) {
    int shiIndex = easyDict["世"];
    return 6 - shiIndex;
  }

  int _goalIndex() {
    Map fromDict = _fromEasyDictionary();
    int yingIndex = fromDict["应"];
    return 6 - yingIndex;
  }
}
