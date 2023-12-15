import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/User/SABSettingModel.dart';
import 'package:yourlucky/src/E_Service/Sqlite/SASSqliteService.dart';
//王志文 天道 黑冰
class SABSettingBusiness extends SABBaseBusiness {
  final SASSqliteService sqlite = SASSqliteService();
  late final SABSettingModel autoSave = generateModel("自动保存","自动保存");

  SABSettingModel generateModel (String settingKey, String settingTitle){
    return SABSettingModel(
        modelId: null,
        settingKey: settingKey,
        settingTitle: settingTitle,
        settingValue:false,
        settingRemark: '',
        settingType: null);
  }

  SABSettingModel errorModel (){
    return generateModel("error","数据加载错误");
  }

  List<SABSettingModel> settingList (void refresh(List<SABSettingModel> dataList)){
    List<SABSettingModel> settingList = [autoSave];
    load((dataList) {
      for (SABSettingModel saveModel in dataList) {
        for (SABSettingModel settingModel in settingList) {
          if (saveModel.settingKey == settingModel.settingKey) {
            settingModel.modelId = saveModel.modelId;
            settingModel.settingValue = saveModel.settingValue;
            settingModel.settingRemark = saveModel.settingRemark;
            settingModel.settingType = saveModel.settingType;
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