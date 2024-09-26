import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/A_Context/SACGlobal.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';

class SABWordsSymbolModel extends SABBaseModel {
  SABWordsSymbolModel({
    required this.intRow,
    required this.easyType,
    required this.symbolName,
    required this.stringParent,
    required this.stringEarth,
    required this.stringElement,
    required this.earlyPlace,
    required this.latePlace,
  });
  final int intRow;
  final EasyTypeEnum easyType;
  final String symbolName;
  final String stringParent;
  final String stringEarth;
  final String stringElement;
  final String earlyPlace;
  final String latePlace;

  void check() {
    if (symbolName.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "symbolName.isEmpty");
    }
    if (stringParent.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringParent.isEmpty");
    }
    if (stringEarth.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringEarth.isEmpty");
    }
    if (stringElement.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "stringElement.isEmpty");
    }
    if (earlyPlace.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "earlyPlace.isEmpty");
    }
    if (latePlace.isEmpty) {
      coLog(StackTrace.current, LogTypeEnum.check, "latePlace.isEmpty");
    }
    super.check();
  }
}
