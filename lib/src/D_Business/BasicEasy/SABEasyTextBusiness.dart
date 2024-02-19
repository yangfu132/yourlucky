import 'package:flutter/services.dart' show rootBundle;
import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';

class SABEasyTextBusiness extends SABBaseBusiness {
  Future<void> _loadData(void finish(String content)) async {
    final _loadedData = await rootBundle.loadString('assets/easy_text.txt');
    finish(_loadedData);
  }

  String getSymbolText(String key, int index) {
    String name = "name";
    String content = "content";
    content.inde
    return "";
  }

  String getEasyText(String key) {
    return "";
  }

  String getEasyAllText(String key) {
    return "";
  }
}
