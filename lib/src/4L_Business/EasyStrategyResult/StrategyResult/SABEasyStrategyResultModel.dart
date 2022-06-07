import 'package:yourlucky/src/4L_Business/Base/SABBaseModel.dart';

class SABEasyStrategyResultModel extends SABBaseModel {
  SABEasyStrategyResultModel({
    required this.strategy,
    required this.lifeKey,
    required this.lifeDescription,
    required this.enemyDescription,
    required this.sonState,
    required this.enemyState,
    required this.relationAboutEnemy,
    required this.relationAboutParentOrSon,
  });
  final String lifeKey;
  final String lifeDescription;
  final String enemyDescription;
  final String sonState;
  final String enemyState;
  final String relationAboutEnemy;
  final String relationAboutParentOrSon;
  final String strategy;
  List resultList() {
    return [
      {'key': lifeKey, 'value': lifeDescription},
      {'key': '克世者皆不为吉，独鬼爻克世更凶', 'value': enemyDescription},
      {'key': '福神动静', 'value': sonState},
      {'key': '克神发动', 'value': enemyState},
      {'key': '世爻与克爻', 'value': relationAboutEnemy},
      {'key': '避患于生世之方，趋吉于福神之地', 'value': relationAboutParentOrSon},
    ];
  }

  SABEasyStrategyResultModel.empty()
      : strategy = '',
        lifeKey = '持世',
        lifeDescription = '',
        enemyDescription = '',
        sonState = '',
        enemyState = '',
        relationAboutEnemy = '',
        relationAboutParentOrSon = '' {
    print('');
  }
}
