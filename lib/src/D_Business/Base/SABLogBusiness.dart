import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:your_lucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:your_lucky/src/E_Service/Sqlite/SASSqliteService.dart';

import '../../A_Context/sac_global.dart';
import 'SABLogModel.dart';

class SABLogBusiness extends SABBaseBusiness {
  SABLogBusiness(this.digitModel);
  final SASSqliteService sqlite = SASSqliteService();
  final SABEasyDigitModel digitModel;

  void saLog(String strMsg) {
    coLog(StackTrace.current, LogTypeEnum.log, strMsg);
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
      sqlite.insertModel(digitModel, (json) {
        printMsg('SABLogModel:${SABLogModel.fromJson(json)}');
      });
    } else {
      sqlite.updateModel(digitModel);
    }
  }

  ///加载
  Future<void> load(void refresh(List<SABLogModel> dataList)) async {
    List<SABLogModel> dataList = <SABLogModel>[];
    await sqlite.query('logs', (json) {
      dataList.add(SABLogModel.fromJson(json));
    }, () {});
    refresh(dataList);
  }
}
