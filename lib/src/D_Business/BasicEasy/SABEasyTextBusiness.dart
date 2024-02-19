import 'package:flutter/services.dart' show rootBundle;
import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';

class SABEasyTextBusiness extends SABBaseBusiness {
  Future<void> _loadData(void finish(String content)) async {
    final _loadedData = await rootBundle.loadString('assets/easy_text.txt');
    finish(_loadedData);
  }

  String getSymbolText(String key, int index) {
    String result = "";
    String name = "name";
    String nextName = "name";
    String content = "content";
    int start = content.indexOf(name);
    if (-1 != start) {
      int end = content.indexOf(nextName);
      if (-1 != end) {
        result = content.substring(start,end);
      } // end if
    } // end if
    return result;
  }

  String getEasyText(String key) {
    return "";
  }

  String getEasyAllText(String key) {
    return "";
  }
}
