///全App唯一的单利
///
class SABSingletonBusiness {
  static SABSingletonBusiness _instance = new SABSingletonBusiness._internal();
  static SABSingletonBusiness _getInstance() {
    return _instance;
  }

  // 工厂模式
  factory SABSingletonBusiness() => _getInstance();
  static SABSingletonBusiness get instance => _getInstance();

  Map<String, dynamic> clearAbleMap = {};

  SABSingletonBusiness._internal() {
    // 初始化
  }

  ///note:释放所有临时对象
  static removeAll() {
    SABSingletonBusiness.instance.clearAbleMap.clear();
  }

  ///note:保存临时对象
  static addObject(String key, dynamic value) {
    SABSingletonBusiness.instance.clearAbleMap[key] = value;
  }

  ///note:保存临时对象
  static dynamic getObject(String key) {
    return SABSingletonBusiness.instance.clearAbleMap[key];
  }
}
