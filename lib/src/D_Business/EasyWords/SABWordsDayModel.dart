class SABWordsDayModel {
  SABWordsDayModel({
    required this.stringSky,
    required this.stringEarth,
    required this.stringElement,
  });

  ///日
  final String stringEarth;
  final String stringSky;
  final String stringElement;

  String skyEarth() {
    return stringSky + stringEarth + "日";
  }
}
