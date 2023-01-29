import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';

class SABCommonWordsBusiness extends SABBaseBusiness {
  String symbolEarth(String stringSymbol) {
    String stringResult = "";
    if (stringSymbol.length >= 2)
      stringResult = stringSymbol.substring(
          stringSymbol.length - 2, stringSymbol.length - 1);
    else
      stringResult =
          "卦中用神未现"; //coLog(StackTrace.current,LogTypeEnum.error, "error!");

    return stringResult;
  }
}
