import 'package:yourlucky/src/3L_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/3L_Business/BasicEasy/SABDiagramsInfoModel.dart';

class SABDiagramsModel extends SABBaseModel {
  SABDiagramsModel({
    required this.fromEasyKey,
    required this.toEasyKey,
  }) {
    this.stringFromName = _fromEasyName();
    this.stringToName = _toEasyName();
    this.stringFromElement = _eightDiagrams.elementOfEasy(_fromEasyName());
    this.stringToElement = _eightDiagrams.elementOfEasy(_toEasyName());
    this.stringFromPlace = _eightDiagrams.easyPlaceByName(_fromEasyName());
    this.stringToPlace = _eightDiagrams.easyPlaceByName(_toEasyName());
    this.mapFromEasy = _fromEasyDictionary();
    this.mapToEasy = _toEasyDictionary();
    this.mapHideEasy = _placeFirstEasy();
    this.bFromPureEasy = 0 == _lifeIndexAtEasy(_fromEasyDictionary());
    this.bToPureEasy = 0 == _lifeIndexAtEasy(_toEasyDictionary());
    this.lifeIndex = _lifeIndex();
    this.goalIndex = _goalIndex();
  }
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

  ///纯卦
  late final bool bFromPureEasy;
  late final bool bToPureEasy;

  ///
  final String fromEasyKey;
  final String toEasyKey;

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
