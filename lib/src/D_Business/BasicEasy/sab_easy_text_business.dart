import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/D_Business/BasicEasy/sab_easy_info_model.dart';
import 'package:your_lucky/src/E_Service/sas_text_file_service.dart';

class SABEasyTextBusiness extends SABBaseBusiness {
  String fileContent = '';
  String easyContent = '';
  SABEasyInfoModel infoModel = SABEasyInfoModel();
  Future<void> _loadData(void Function(String content) finish) async {
    if (fileContent.isEmpty) {
      SASTextFileService.readAsset((content) {
        fileContent = content;
        finish(content);
      });
    } else {
      finish(fileContent);
    }
  }

  void getEasyText(String easyKey,void Function(String content) finish){
    if (easyContent.isEmpty) {
      _loadData((content) {
        Map data = infoModel.initEasyData();
        String name = data[easyKey]['name'];
        String next = data[easyKey]['next'];
        int beginIndex = findIndex(fileContent,name,true);

        if (next != '无') {
          int endIndex = findIndex(fileContent,next,true);
          if (-1 != beginIndex && -1 != endIndex) {
            easyContent = content.substring(beginIndex, endIndex);
          }
        } else {
          easyContent = content.substring(beginIndex);
        }
        finish(easyContent);
      });
    } else {
      finish(easyContent);
    }
  }


  void getSymbolText(String easyKey,int symbolRow,void Function(String content) finish) {
    getEasyText(easyKey, (content) {
      List<String> beginList = infoModel.symbolPositionAtIndex(symbolRow);
      int beginIndex = -1;
      for (String position in beginList) {
        beginIndex = findIndex(content,position,true);
        if (-1 != beginIndex) {
          break;
        }
      }

      int endIndex = -1;
      if (symbolRow >= 1) {
        List<String> endList = infoModel.symbolPositionAtIndex(symbolRow-1);
        for (String position in endList) {
          endIndex = findIndex(content,position,true);
          if (-1 != endIndex) {
            break;
          }
        }
      }

      String result = "";
      if (-1 != beginIndex) {
        if ( -1 != endIndex) {
          result = content.substring(beginIndex, endIndex);
        } else {
          result = content.substring(beginIndex);
        }
      }
      finish(result);
    });
  }

  int findIndex(String content, String searchValue,bool ignoreCase) {
    int initialIndex = -1;
    List<String> listResult = <String>[];
    if (searchValue.isNotEmpty) {
      if (ignoreCase) {
        listResult = content.toLowerCase().split(searchValue.toLowerCase());
      } else {
        listResult = content.split(searchValue);
      }
    }
    if (listResult.length >= 2) {
      String firstContent = listResult[0];
      initialIndex = firstContent.length;
    }
    return initialIndex;
  }

  String getEasyAllText(String key) {
    return "";
  }
}
