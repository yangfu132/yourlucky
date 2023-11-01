import 'dart:math';

import 'package:flutter_perpttual_calendar/flutter_perpttual_calendar.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/E_Service/Sqlite/SASSqliteService.dart';

import 'SABEasyDigitModel.dart';

class SABEasyDigitBusiness extends SABBaseBusiness {
  final SASSqliteService sqlite = SASSqliteService();

  ///创建测试
  SABEasyDigitModel create() {
    SABEasyDigitModel outEasyModel;
    String strEasyGoal = '测试';
    String strUsefulDeity = '子孙';
    List<int> listEasyData = generateEasyArray();

    final DateTime easyDateTime = DateTime.now();
    PWBCalendarBusiness calendar = PWBCalendarBusiness(easyDateTime);
    String stringTime = calendar.stringFromDate();

    outEasyModel = SABEasyDigitModel(
      modelId: null,
      strEasyGoal: strEasyGoal,
      strUsefulDeity: strUsefulDeity,
      stringTime: stringTime,
      listEasyData: listEasyData,
    );
    save(outEasyModel);
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
    if (null == digitModel.getModelId()) {
      sqlite.insertModel(digitModel, (json) {
        SABEasyDigitModel savedModel = SABEasyDigitModel.fromJson(json);
        print('DigitModel:${SABEasyDigitModel.fromJson(json)}');
        digitModel.modelId = savedModel.modelId;
      });
    } else {
      sqlite.updateModel(digitModel);
    }
  }

  ///加载
  Future<void> load(void refresh(List<SABEasyDigitModel> dataList)) async {
    List<SABEasyDigitModel> dataList = <SABEasyDigitModel>[];
    await sqlite.query('easy', (json) {
      dataList.add(SABEasyDigitModel.fromJson(json));
    });
    refresh(dataList);
  }
}
