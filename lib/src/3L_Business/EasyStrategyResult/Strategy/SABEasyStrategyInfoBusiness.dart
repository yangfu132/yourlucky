import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../EasyDetail/SABDiagramsDetailModel.dart';
import '../../Goal/SABParentModel.dart';
import 'SABEasyStrategyInfoModel.dart';

///note:章，既是预测模型
///example:趋避章
///对应：COMCategoryAdapter
///解释：Expert代表专家，每一章都是对某种情况的专家系统；

class SABEasyStrategyInfoBusiness {
  String stringStrategyKey = 'ExpertCategory';

  String stringStrategy = '趋避';

  ///UI信息
  List strategySection() {
    return ['基础', '分类'];
  }

  ///UI信息
  Map categoryDictionary() {
    return {
      '基础': SABParentModel.baseCategoryArray(),
      '分类': SABEasyStrategyInfoModel.categoryArray(),
    };
  }

  Widget categoryController(String category, SABDiagramsDetailModel easyItem) {
    return Text('data');
  }

  Future<void> getsCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    stringStrategy = prefs.getString(stringStrategyKey) ?? '趋避';
    print(stringStrategy);
  }

  Future<void> setCategory(String strType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(stringStrategyKey, strType);
  }
}
