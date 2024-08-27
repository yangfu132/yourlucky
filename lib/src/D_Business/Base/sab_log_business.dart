import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/E_Service/Sqlite/sas_sqlite_service.dart';

import '../../A_Context/sac_global.dart';
import 'sab_log_model.dart';

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
      sqlite.updateModel(digitModel,(int count){});
    }
  }

  ///加载
  Future<void> load(void Function(List<SABLogModel> dataList) refresh) async {
    List<SABLogModel> dataList = <SABLogModel>[];
    await sqlite.query('logs', (json) {
      dataList.add(SABLogModel.fromJson(json));
    }, () {});
    refresh(dataList);
  }
}
