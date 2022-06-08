import 'package:yourlucky/src/D_Business/Base/SABBaseModel.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABDigitDiagramsModel.dart';

class SABLogicDiagramsModel extends SABBaseModel {
  SABLogicDiagramsModel({
    required this.digitModel,
    required this.bStaticEasy,
    required this.bFromEasySixPair,
    required this.bToEasySixPair,
    required this.bHideEasySixPair,
    required this.bFromEasySixConflict,
    required this.bToEasySixConflict,
    required this.bHideEasySixConflict,
    required this.stringEmptyBranch,
    required this.stringEasyParent,
    required this.isEasyRepeatedGroan,
    required this.isEasyInPartRepeated,
    required this.isEasyOutPartRepeated,
    required this.isEasyRestrictsGroan,
    required this.isEasyInPartRestricts,
    required this.isEasyOutPartRestricts,
  });
  SABDigitDiagramsModel digitModel;
  final bool bStaticEasy;

  final bool bFromEasySixPair;
  final bool bToEasySixPair;
  final bool bHideEasySixPair;

  final bool bFromEasySixConflict;
  final bool bToEasySixConflict;
  final bool bHideEasySixConflict;

  final String stringEmptyBranch;

  ///卦变生克墓绝章第二十四
  final String stringEasyParent;

  ///反伏章第二十五
  ///伏吟
  final bool isEasyRepeatedGroan;

  final bool isEasyInPartRepeated;

  final bool isEasyOutPartRepeated;

  final bool isEasyRestrictsGroan;

  final bool isEasyInPartRestricts;

  final bool isEasyOutPartRestricts;
}
