import 'package:flutter_perpttual_calendar/flutter_perpttual_calendar.dart';
import 'package:your_lucky/src/E_Service/Base/sas_base_service.dart';

class SASBuddhaService extends SASBaseService {
  SASBuddhaService({required this.stringTime}) {
    DateTime easyDateTime = DateTime.parse(stringTime);
    _buddha = PWBBuddhaBusiness(easyDateTime);
  }
  late final PWBBuddhaBusiness _buddha;
  final String stringTime;


  String getPath(){
    if (_buddha.foto.isDayZhaiTen()) {
      //十斋日
      return ' https://bookgb.bfnn.org/books/0016.htm';
    }
    else if (_buddha.foto.isDayZhaiGuanYin()) {
      //观音斋
      return 'http://www.fjbk.org/fojing/fopusa/699.html';
    }
    else if (_buddha.foto.isDayZhaiLei()) {
      //雷斋日
      return ' http://sxdaojiao.com/index.php?m=content&c=index&a=show&catid=30&id=2098';
    }
    return 'http://www.fjbk.org/fojing/fopusa/699.html';
  }
}