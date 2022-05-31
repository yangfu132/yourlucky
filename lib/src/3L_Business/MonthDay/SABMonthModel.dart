class SABMonthModel {
  SABMonthModel({
    required this.stringSky,
    required this.stringEarth,
    required this.stringElement,
  });
  final String stringSky;
  final String stringEarth;
  final String stringElement;

  String skyEarth() {
    return stringSky + stringEarth + "月";
  }
}
