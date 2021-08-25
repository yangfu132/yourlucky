class SABEasyStrategyResultModel {
  SABEasyStrategyResultModel({
    required this.lifeDescription,
    required this.enemyDescription,
    required this.sonState,
    required this.enemyState,
    required this.relationAboutEnemy,
    required this.relationAboutParentOrSon,
  });
  final String lifeDescription;
  final String enemyDescription;
  final String sonState;
  final String enemyState;
  final String relationAboutEnemy;
  final String relationAboutParentOrSon;
  List resultList() {
    return [
      {'key': '持世', 'value': lifeDescription},
      {'key': '克世者', 'value': enemyDescription},
      {'key': '福神动静', 'value': sonState},
      {'key': '克神发动', 'value': enemyState},
      {'key': '世在外，克在外宜于家居', 'value': relationAboutEnemy},
      {'key': '避患于生世之方，趋吉于福神之地', 'value': relationAboutParentOrSon},
    ];
  }
}
