import 'dart:math';

import 'SABEasyDigitModel.dart';

class SABEasyDigitBusiness {
  ///创建
  static SABEasyDigitModel create() {
    SABEasyDigitModel outEasyModel = SABEasyDigitModel(
      '测试',
      '子孙',
      DateTime.now(),
      generateEasyArray(),
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
    } //endf
    //return _listEasyData;
    print('listEasyData:$listEasyData');
    //[0, 8, 0, 1, 1, 1]
    //[8, 8, 0, 8, 0, 0]
    //[0, 1, 1, 8, 8, 1]

    return listEasyData;
  }

  ///保存
  static void save(SABEasyDigitModel digitModel) {}

  ///加载
  static SABEasyDigitModel load() {
    SABEasyDigitModel outEasyModel = SABEasyDigitModel(
      '测试',
      '子孙',
      DateTime.now(),
      generateEasyArray(),
    );
    return outEasyModel;
  }
}
