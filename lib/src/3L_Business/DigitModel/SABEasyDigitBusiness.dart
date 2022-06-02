import 'dart:math';

import 'package:flutter_perpttual_calendar/flutter_perpttual_calendar.dart';
import 'package:yourlucky/src/4L_Service/Sqlite/SASSqliteService.dart';

import 'SABEasyDigitModel.dart';

class SABEasyDigitBusiness {
  ///创建
  SABEasyDigitModel create() {
    String strEasyGoal = '测试';
    String strUsefulDeity = '子孙';
    List<int> listEasyData = generateEasyArray();

    final DateTime easyDateTime = DateTime.now();
    PWBCalendarBusiness calendar = PWBCalendarBusiness(easyDateTime);
    String stringFormatTime = calendar.stringFromDate();

    SABEasyDigitModel outEasyModel = SABEasyDigitModel(
      strEasyGoal: strEasyGoal,
      strUsefulDeity: strUsefulDeity,
      easyDateTime: easyDateTime,
      listEasyData: listEasyData,
      stringFormatTime: stringFormatTime,
    );
    return outEasyModel;
  }

  ///利用随机数创造数据
  static List<int> generateEasyArray() {
    var listEasyData = List<int>.empty(growable: true);
    for (int nIndex = 0; nIndex < 6; nIndex++) {
      int randomNum = Random().nextInt(3);
      if (2 == randomNum)
        randomNum = 8;
      else if (3 == randomNum) randomNum = 9;
      //else cont.
      listEasyData.add(randomNum);
    } //end for
    print('listEasyData:$listEasyData');
    //[0, 8, 0, 1, 1, 1]
    //[8, 8, 0, 8, 0, 0]
    //[0, 1, 1, 8, 8, 1]

    return listEasyData;
  }

  ///保存
  void save(SABEasyDigitModel digitModel) {
    SASSqliteService sqlite = SASSqliteService();
    sqlite.testDog();
  }

  ///加载
  SABEasyDigitModel load() {
    return create();
  }
}
