import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/E_Service/Sqlite/SASSqliteService.dart';

import 'SABLogModel.dart';

class SABLogBusiness extends SABBaseBusiness {
  SABLogBusiness(this.digitModel);
  final SASSqliteService sqlite = SASSqliteService();
  final SABEasyDigitModel digitModel;

  void saLog(String strMsg) {
    coLog(strMsg);
    SABLogModel logModel = SABLogModel(
      modelId: null,
      dataId: digitModel.getModelId(),
      dataJson: digitModel.toString(),
      msg: strMsg,
    );
    save(logModel);
  }

  ///保存
  void save(SABLogModel logModel) {
    if (null == digitModel.getModelId()) {
      sqlite.insertModel(digitModel);
    } else {
      sqlite.updateModel(digitModel);
    }
  }

  ///加载
  Future<void> load(void refresh(List<SABLogModel> dataList)) async {
    List<SABLogModel> dataList = <SABLogModel>[];
    await sqlite.query('logs', (json) {
      dataList.add(SABLogModel.fromJson(json));
    });
    refresh(dataList);
  }
}
