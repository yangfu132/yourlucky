import 'package:yourlucky/src/D_Business/Base/SABBaseBusiness.dart';
import 'package:yourlucky/src/D_Business/User/SABSettingModel.dart';
import 'package:yourlucky/src/E_Service/Sqlite/SASSqliteService.dart';

//王志文 天道 黑冰
class SABSettingBusiness extends SABBaseBusiness {
  final SASSqliteService sqlite = SASSqliteService();
  late final SABSettingModel autoSave =
      generateModel("自动保存", "自动保存", SettingTypeEnum.switchType);

  ///假设日的健康值为10/365,也就是日实际代表的是一旬；爻的健康值实际上是根据日月计算出来的；
  late final SABSettingModel dayHealth =
      generateModel("日值", "日值", SettingTypeEnum.textField, stringValue: '10');

  ///假设日的健康值为30/365,也就是月实际代表的是一月，爻的健康值实际上是根据日月计算出来的；
  late final SABSettingModel monthHealth =
      generateModel("月值", "月值", SettingTypeEnum.textField, stringValue: '30');

  SABSettingModel generateModel(
      String settingKey, String settingTitle, SettingTypeEnum settingType,
      {int intValue = 0, String stringValue = '', String stringRemark = ''}) {
    return SABSettingModel(
        modelId: null,
        settingKey: settingKey,
        settingTitle: settingTitle,
        intValue: intValue,
        stringValue: stringValue,
        settingType: settingType,
        stringRemark: stringRemark);
  }

  SABSettingModel errorModel() {
    return generateModel("error", "数据加载错误", SettingTypeEnum.textType);
  }

  List<SABSettingModel> settingList(
      void refresh(List<SABSettingModel> dataList)) {
    List<SABSettingModel> settingList = [autoSave, dayHealth];
    load((dataList) {
      for (SABSettingModel saveModel in dataList) {
        for (SABSettingModel settingModel in settingList) {
          if (saveModel.settingKey == settingModel.settingKey) {
            settingModel.modelId = saveModel.modelId;
            settingModel.intValue = saveModel.intValue;
            settingModel.stringValue = saveModel.stringValue;
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
      refresh(dataList);
    });
  }
}
