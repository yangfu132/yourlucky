///全App唯一的单利
///
class SABSingletonService {
  static SABSingletonService _instance = new SABSingletonService._internal();
  static SABSingletonService _getInstance() {
    return _instance;
  }

  // 工厂模式
  factory SABSingletonService() => _getInstance();
  static SABSingletonService get instance => _getInstance();

  Map<String, dynamic> clearAbleMap = {};

  SABSingletonService._internal() {
    // 初始化
  }

  ///note:释放所有临时对象
  static removeAll() {
    SABSingletonService.instance.clearAbleMap.clear();
  }

  ///note:保存临时对象
  static addObject(String key, dynamic value) {
    SABSingletonService.instance.clearAbleMap[key] = value;
  }

  ///note:保存临时对象
  static dynamic getObject(String key) {
    return SABSingletonService.instance.clearAbleMap[key];
  }
}
