import 'package:your_lucky/src/D_Business/Base/sab_base_business.dart';
import 'package:your_lucky/src/D_Business/User/sab_setting_model.dart';
import 'package:your_lucky/src/E_Service/Sqlite/sas_sqlite_service.dart';

//王志文 天道 黑冰
class SABSettingBusiness extends SABBaseBusiness {
  final SASSqliteService sqlite = SASSqliteService();

  late final SABSettingModel autoSave =
      generateModel("自动保存", "自动保存", SettingTypeEnum.switchType);

  late final SABSettingModel appType =
  generateModel("ReleaseType", "ReleaseType", SettingTypeEnum.switchType);

  late final SABSettingModel emptyZero = generateModel(
      "旬空时日Health为0",
      "旬空时日Health为0",
      SettingTypeEnum.switchType,
      intValue: 1);

  late final SABSettingModel monthConflictZero = generateModel(
      "月冲时月Health为0",
      "月冲时月Health为0",
      SettingTypeEnum.switchType,
      intValue: 1);

  late final SABSettingModel isRemainStrong = generateModel(
      "余气是否为强",
      "余气是否为强",
      SettingTypeEnum.switchType,
      intValue: 0);

  late final SABSettingModel isRemainEmpty = generateModel(
      "余气是否为空",
      "余气是否为空",
      SettingTypeEnum.switchType,
      intValue: 1);

  ///假设日的健康值为10/365,也就是日实际代表的是一旬；爻的健康值实际上是根据日月计算出来的；
  late final SABSettingModel dayHealth =
      generateModel("日值", "日值", SettingTypeEnum.textField, stringValue: '10');

  ///假设日的健康值为30/365,也就是月实际代表的是一月，爻的健康值实际上是根据日月计算出来的；
  late final SABSettingModel monthHealth =
      generateModel("月值", "月值", SettingTypeEnum.textField, stringValue: '30');

  late final _settingList = [
    appType,
    autoSave,
    emptyZero,
    monthConflictZero,
    isRemainStrong,
    isRemainEmpty,
    monthHealth,
    dayHealth
  ];

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

  void settingList(void Function(List<SABSettingModel> dataList) refresh) {
    load((dataList) {

      for (SABSettingModel settingModel in _settingList) {
        for (SABSettingModel saveModel in dataList) {
          if (saveModel.settingKey == settingModel.settingKey) {
            settingModel.modelId = saveModel.modelId;
            settingModel.intValue = saveModel.intValue;
            settingModel.stringValue = saveModel.stringValue;
            settingModel.settingType = saveModel.settingType;
          }
        }
      }
      refresh(_settingList);
    });
  }

  ///保存
  void save(SABSettingModel model) {
    if (null == model.getModelId()) {
      sqlite.insertModel(model, (json) {
        SABSettingModel savedModel = SABSettingModel.fromJson(json);
        printMsg('SABSettingModel:${SABSettingModel.fromJson(json)}');
        model.modelId = savedModel.modelId;
      });
    } else {
      sqlite.updateModel(model,(int count){});
    }
  }

  ///加载
  Future<void> load(void Function(List<SABSettingModel> dataList) refresh) async {
    List<SABSettingModel> dataList = <SABSettingModel>[];
    await sqlite.query('setting', (json) {
      dataList.add(SABSettingModel.fromJson(json));
    }, () {
      refresh(dataList);
    });
  }
}
