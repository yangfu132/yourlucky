import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/User/SABSettingModel.dart';
import 'package:yourlucky/src/E_Service/Sqlite/SASSqliteService.dart';

class SABSettingBusiness extends SABBaseBusiness {
  final SASSqliteService sqlite = SASSqliteService();

  SABSettingModel generateModel (String settingKey, String settingTitle){
    return SABSettingModel(
        modelId: null,
        settingKey: settingKey,
        settingTitle: settingTitle,
        settingValue:false,
        settingRemark: '');
  }

  SABSettingModel errorModel (){
    return SABSettingModel(
        modelId: null,
        settingKey: "error",
        settingTitle: "数据加载错误",
        settingValue:false,
        settingRemark: '');
  }

  List<SABSettingModel> settingList (void refresh(List<SABSettingModel> dataList)){
    SABSettingModel model = generateModel("自动保存","自动保存");
    List<SABSettingModel> settingList = [model];
    load((dataList) {
      for (SABSettingModel saveModel in dataList) {
        for (SABSettingModel settingModel in settingList) {
          if (saveModel.settingKey == settingModel.settingKey) {
            settingModel.modelId = saveModel.modelId;
            settingModel.settingValue = saveModel.settingValue;
            settingModel.settingRemark = saveModel.settingRemark;
          }
        }
      }
      refresh(settingList);
    });
    return settingList;
 }

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