import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

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
    required this.bMovement,
    required this.stringAnimal,
    required this.stringDiagrams,
    required this.desOfGoalOrLife,
  }) {
    SACContext.addBoard(toJson().toString());
  }
  final int intRow;
  final EasyTypeEnum easyType;
  final String symbolName;
  final String stringParent;
  final String stringEarth;
  final String stringElement;
  final String earlyPlace;
  final String latePlace;
  final bool bMovement;
  final String stringAnimal;
  final String stringDiagrams;
  final String desOfGoalOrLife;

  SABWordsSymbolModel.fromJson(Map<String, Object?> json)
      : this(
    intRow: json['intRow'] as int,
    easyType: json['easyType'] as EasyTypeEnum,
    symbolName: json['symbolName']! as String,
    stringParent: json['stringParent']! as String,
    stringEarth: json['stringEarth']! as String,
    stringElement: json['stringElement']! as String,
    earlyPlace: json['earlyPlace']! as String,
    latePlace: json['latePlace']! as String,
    bMovement: json['bMovement'] as bool,
    stringAnimal: json['stringAnimal']! as String,
    stringDiagrams: json['stringDiagrams']! as String,
    desOfGoalOrLife: json['desOfGoalOrLife']! as String,
  );

  @override Map<String, Object?> toJson() {
    return {
      'intRow': intRow,
      'easyType': easyType,
      'symbolName': symbolName,
      'stringParent': stringParent,
      'stringElement': stringElement,
      'earlyPlace': earlyPlace,
      'latePlace': latePlace,
      'bMovement': bMovement,
      'stringAnimal': stringAnimal,
      'stringDiagrams': stringDiagrams,
      'desOfGoalOrLife': desOfGoalOrLife,
    };
  }

  @override void check() {
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
