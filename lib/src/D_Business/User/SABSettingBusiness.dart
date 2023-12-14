import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/User/SABSettingModel.dart';
import 'package:yourlucky/src/E_Service/Sqlite/SASSqliteService.dart';

class SABSettingBusiness extends SABBaseBusiness {
  final SASSqliteService sqlite = SASSqliteService();

  ///保存
  void save(SABSettingModel model) {
    if (null == model.getModelId()) {
      sqlite.insertModel(model, (json) {
        SABSettingModel savedModel = SABSettingModel.fromJson(json);
        print('SABSettingModel:${SABSettingModel.fromJson(json)}');
        model.modelId = savedModel.modelId;
      });
    } else {
      sqlite.updateModel(model);
    }
  }

  ///加载
  Future<void> load(void refresh(List<SABSettingModel> dataList)) async {
    List<SABSettingModel> dataList = <SABSettingModel>[];
    await sqlite.query('setting', (json) {
      dataList.add(SABSettingModel.fromJson(json));
    });
    refresh(dataList);
  }
}