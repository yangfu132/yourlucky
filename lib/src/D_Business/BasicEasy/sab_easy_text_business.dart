import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/D_Business/BasicEasy/sab_easy_info_model.dart';
import 'package:your_lucky/src/E_Service/sas_text_file_service.dart';

class SABEasyTextBusiness extends SABBaseBusiness {
  String fileContent = '';
  SABEasyInfoModel infoModel = SABEasyInfoModel();
  Future<void> _loadData(void Function(String content) finish) async {
    SASTextFileService.readAsset((content) {
      fileContent = content;
      finish(content);
    });
  }

  void getEasyText(String easyKey,void Function(String content) finish){
    _loadData((content) {
      Map data = infoModel.initEasyData();
      String name = data[easyKey]['name'];
      String next = data[easyKey]['next'];
      int beginIndex = findIndex(name,true);
      int endIndex = findIndex(next,true);
      String newText = content.substring(beginIndex, endIndex);
      finish(newText);
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
