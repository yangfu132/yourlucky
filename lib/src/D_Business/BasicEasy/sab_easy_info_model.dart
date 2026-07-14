// import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';
//
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_global.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SABEasyInfoModel extends SABBaseModel {
  final Map dictionary = {};

  List<String> symbolPositionAtIndex(int symbolIndex) {
    List<String> result = <String>[];
    switch(symbolIndex){
      case 0:
        result = ['上六','上九'];
        break;
      case 1:
        result = ['六五','九五'];
        break;
      case 2:
        result = ['六四','九四'];
        break;
      case 3:
        result = ['六三','九三'];
        break;
      case 4:
        result = ['六二','九二'];
        break;
      case 5:
        result = ['初六','初九'];
        break;
      default:
        coLog(StackTrace.current, LogTypeEnum.error, 'symbolIndex:$symbolIndex');
    }
    return result;
  }















  Map initEasyData() {
    Map dictionary = {};
    dictionary["111111"] = {"name": "第一卦","next":"第二卦"};
    dictionary["111110"] = {"name": "第四十四卦","next":"第四十五卦"};
    dictionary["111100"] = {"name": "第三十三卦","next":"第三十四卦"};
    dictionary["111000"] = {"name": "第十二卦","next":"第十三卦"};
    dictionary["110000"] = {"name": "第二十卦","next":"第二十一卦"};
    dictionary["100000"] = {"name": "第二十三卦","next":"第二十四卦"};
    dictionary["101000"] = {"name": "第三十五卦","next":"第三十六卦"};
    dictionary["101111"] = {"name": "第十四卦","next":"第十五卦"};
    dictionary["010010"] = {"name": "第二十九卦","next":"第三十卦"};
    dictionary["010011"] = {"name": "第六十卦","next":"第六十一卦"};
    dictionary["010001"] = {"name": "第三卦","next":"第四卦"};
    dictionary["010101"] = {"name": "第六十三卦","next":"第六十四卦"};
    dictionary["011101"] = {"name": "第四十九卦","next":"第五十卦"};
    dictionary["001101"] = {"name": "第五十五卦","next":"第五十六卦"};
    dictionary["000101"] = {"name": "第三十六卦","next":"第三十七卦"};
    dictionary["000010"] = {"name": "第七卦","next":"第八卦"};
    dictionary["100100"] = {"name": "第五十二卦","next":"第五十三卦"};
    dictionary["100101"] = {"name": "第二十二卦","next":"第二十三卦"};
    dictionary["100111"] = {"name": "第二十六卦","next":"第二十七卦"};
    dictionary["100011"] = {"name": "第四十一卦","next":"第四十二卦"};
    dictionary["101011"] = {"name": "第三十八卦","next":"第三十九卦"};
    dictionary["111011"] = {"name": "第十卦","next":"第十一卦"};
    dictionary["110011"] = {"name": "第六十一卦","next":"第六十二卦"};
    dictionary["110100"] = {"name": "第五十三卦","next":"第五十四卦"};
    dictionary["001001"] = {"name": "第五十一卦","next":"第五十二卦"};
    dictionary["001000"] = {"name": "第十六卦","next":"第十七卦"};
    dictionary["001010"] = {"name": "第四十卦","next":"第四十一卦"};
    dictionary["001110"] = {"name": "第三十二卦","next":"第三十三卦"};
    dictionary["000110"] = {"name": "第四十六卦","next":"第四十七卦"};
    dictionary["010110"] = {"name": "第四十八卦","next":"第四十九卦"};
    dictionary["011110"] = {"name": "第二十八卦","next":"第二十九卦"};
    dictionary["011001"] = {"name": "第十七卦","next":"第十八卦"};
    dictionary["110110"] = {"name": "第五十七卦","next":"第五十八卦"};
    dictionary["110111"] = {"name": "第九卦","next":"第十卦"};
    dictionary["110101"] = {"name": "第三十七卦","next":"第三十八卦"};
    dictionary["110001"] = {"name": "第四十二卦","next":"第四十三卦"};
    dictionary["111001"] = {"name": "第二十五卦","next":"第二十六卦"};
    dictionary["101001"] = {"name": "第二十一卦","next":"第二十二卦"};
    dictionary["100001"] = {"name": "第二十七卦","next":"第二十八卦"};
    dictionary["100110"] = {"name": "第十八卦","next":"第十九卦"};
    dictionary["101101"] = {"name": "第三十卦","next":"第三十一卦"};
    dictionary["101100"] = {"name": "第五十六卦","next":"第五十七卦"};
    dictionary["101110"] = {"name": "第五十卦","next":"第五十一卦"};
    dictionary["101010"] = {"name": "第六十四卦","next":"无"};
    dictionary["100010"] = {"name": "第四卦","next":"第五卦"};
    dictionary["110010"] = {"name": "第五十九卦","next":"第六十卦"};
    dictionary["111010"] = {"name": "第六卦","next":"第七卦"};
    dictionary["111101"] = {"name": "第十三卦","next":"第十四卦"};
    dictionary["000000"] = {"name": "第二卦","next":"第三卦"};
    dictionary["000001"] = {"name": "第二十四卦","next":"第二十五卦"};
    dictionary["000011"] = {"name": "第十九卦","next":"第二十卦"};
    dictionary["000111"] = {"name": "第十一卦","next":"第十二卦"};
    dictionary["001111"] = {"name": "第三十四卦","next":"第三十五卦"};
    dictionary["011111"] = {"name": "第四十三卦","next":"第四十四卦"};
    dictionary["010111"] = {"name": "第五卦","next":"第六卦"};
    dictionary["010000"] = {"name": "第八卦","next":"第九卦"};
    dictionary["011011"] = {"name": "第五十八卦","next":"第五十九卦"};
    dictionary["011010"] = {"name": "第四十七卦","next":"第四十八卦"};
    dictionary["011000"] = {"name": "第四十五卦","next":"第四十六卦"};
    dictionary["011100"] = {"name": "第三十一卦","next":"第三十二卦"};
    dictionary["010100"] = {"name": "第三十九卦","next":"第四十卦"};
    dictionary["000100"] = {"name": "第十五卦","next":"第十六卦"};
    dictionary["001100"] = {"name": "第六十二卦","next":"第六十三卦"};
    dictionary["001011"] = {"name": "第五十四卦","next":"第五十五卦"};
    return dictionary;
  }