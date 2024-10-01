import 'dart:math';

import 'package:flutter_perpttual_calendar/flutter_perpttual_calendar.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/E_Service/Sqlite/sas_sqlite_service.dart';

import 'sab_develop_model.dart';

class SABDevelopBusiness extends SABBaseBusiness {
  final SASSqliteService sqlite = SASSqliteService();

  ///创建测试
  SABDevelopModel create() {
    SABDevelopModel outEasyModel;
    String strEasyGoal = '待定';
    String strUsefulDeity = '子孙';
    List<int> listRelationData = generateEasyArray();

    final DateTime easyDateTime = DateTime.now();
    PWBCalendarBusiness calendar = PWBCalendarBusiness(easyDateTime);
    String stringTime = calendar.stringFromDate();

    String strStrategy = SACContext.expertCategory().stringStrategy;
    outEasyModel = SABDevelopModel(
      modelId: null,
      strGoal: strEasyGoal,
      strUsefulDeity: strUsefulDeity,
      stringTime: stringTime,
      strStrategy: strStrategy,
      listRelationData: listRelationData,
    );

    if (1 == SACContext.setting().autoSave.intValue) {
      save(outEasyModel);
    }
    return outEasyModel;
  }

  ///利用随机数创造数据
  static List<int> generateEasyArray() {
    var listEasyData = List<int>.empty(growable: true);
    for (int nIndex = 0; nIndex < 6; nIndex++) {
      int randomNum = Random().nextInt(3);
      if (2 == randomNum) {
        randomNum = 8;
      } else if (3 == randomNum)  {
        randomNum = 9;
      }
      //else cont.
      listEasyData.add(randomNum);
    } //end for
    SABBaseBusiness.staticPrintMsg('listEasyData:$listEasyData');
    //[0, 8, 0, 1, 1, 1]
    //[8, 8, 0, 8, 0, 0]
    //[0, 1, 1, 8, 8, 1]

    return listEasyData;
  }

  ///保存
  void save(SABDevelopModel digitModel) {
    if (null == digitModel.getModelId()) {
      sqlite.insertModel(digitModel, (json) {
        SABDevelopModel savedModel = SABDevelopModel.fromJson(json);
        printMsg('DigitModel:${SABDevelopModel.fromJson(json)}');
        digitModel.modelId = savedModel.modelId;
      });
    } else {
      sqlite.updateModel(digitModel,(int count){});
    }
  }

  ///加载
  Future<void> load(void Function(List<SABDevelopModel> dataList) refresh) async {
    List<SABDevelopModel> dataList = <SABDevelopModel>[];
    SABDevelopModel model = create();
    await sqlite.query(model.getModelName(), (json) {
      dataList.add(SABDevelopModel.fromJson(json));
      refresh(dataList);
    }, () {
      refresh(dataList);
    });
  }

  void delete(SABDevelopModel digitModel) {
    sqlite.deleteModel(digitModel);
  }
}
