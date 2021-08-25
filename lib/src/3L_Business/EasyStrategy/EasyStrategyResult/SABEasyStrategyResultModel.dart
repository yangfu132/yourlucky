class SABEasyStrategyResultModel {
  SABEasyStrategyResultModel({
    required this.lifeDescription,
    required this.ghostDescription,
    required this.sonDescription,
    required this.enemyDescription,
    required this.relationAboutEnemy,
    required this.relationAboutParentOrSon,
  });
  final String lifeDescription;
  final String ghostDescription;
  final String sonDescription;
  final String enemyDescription;
  final String relationAboutEnemy;
  final String relationAboutParentOrSon;
  List resultList = [
    {'key': '持世', 'value': '持世'},
    {'key': '克世者', 'value': '持世'},
    {'key': '福神动静', 'value': '福神动静'},
    {'key': '克神发动', 'value': '克神发动'},
    {'key': '世在外，克在外宜于家居', 'value': '世在外，克在外宜于家居'},
    {'key': '避患于生世之方，趋吉于福神之地', 'value': '避患于生世之方，趋吉于福神之地'},
  ];
}
