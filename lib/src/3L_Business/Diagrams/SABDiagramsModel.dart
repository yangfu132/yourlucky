class SABDiagramsModel {
  SABDiagramsModel({
    required this.stringFromName,
    required this.stringFromPlace,
    required this.stringFromElement,
    required this.stringToName,
    required this.stringToPlace,
    required this.stringToElement,
    required this.mapFromEasy,
    required this.mapToEasy,
    required this.mapHideEasy,
    required this.bFromPureEasy,
    required this.bToPureEasy,
  });

  ///卦
  final String stringFromName;
  final String stringFromPlace;
  final String stringFromElement;
  final String stringToName;
  final String stringToPlace;
  final String stringToElement;
  final Map mapFromEasy;
  final Map mapToEasy;
  final Map mapHideEasy;

  ///纯卦
  final bool bFromPureEasy;
  final bool bToPureEasy;
}
