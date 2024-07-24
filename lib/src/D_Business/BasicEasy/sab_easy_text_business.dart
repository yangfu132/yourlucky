import 'package:flutter/services.dart' show rootBundle;
import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/E_Service/sas_text_file_service.dart';

class SABEasyTextBusiness extends SABBaseBusiness {
  String fileContent = '';
  Future<void> _loadData(void Function(String content) finish) async {
    SASTextFileService.readAsset((content) {
      fileContent = content;
      finish(content);
    });
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

  String getEasyText(String beginValue,String endValue,void Function(String content) finish) {
    _loadData((content) {
      int beginIndex = findIndex(beginValue,true);
      int endIndex = findIndex(endValue,true);
      String newText = content.substring(beginIndex, endIndex);
      finish(newText);
    });
    return "";
  }

  int findIndex(String searchValue,bool ignoreCase) {
    int initialIndex = 0;
    List<String> listResult = <String>[];
    if (searchValue.isNotEmpty) {
      if (ignoreCase) {
        listResult = fileContent.toLowerCase().split(searchValue.toLowerCase());
      } else {
        listResult = fileContent.split(searchValue);
      }
    }
    if (listResult.length == 2) {
      String firstContent = listResult[0];
      initialIndex = firstContent.length;
    }
    return initialIndex;
  }

  String getEasyAllText(String key) {
    return "";
  }
}
