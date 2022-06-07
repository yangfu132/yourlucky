import 'package:yourlucky/src/1L_Context/SACGlobal.dart';
import 'package:yourlucky/src/4L_Business/Base/SABBaseModel.dart';

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
}
