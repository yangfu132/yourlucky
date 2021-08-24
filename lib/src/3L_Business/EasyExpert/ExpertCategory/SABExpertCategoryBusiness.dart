import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../EasyResult/SABEasyResultModel.dart';
import 'SABExpertCategoryModel.dart';
import 'SABUsefulDeityModel.dart';

///note:章，既是预测模型
///example:趋避章
///对应：COMCategoryAdapter
///解释：Expert代表专家，每一章都是对某种情况的专家系统；

class SABExpertCategoryBusiness {
  String strExpertCategory = 'ExpertCategory';

  String stringCategory = '趋避';

  ///UI信息
  List categorySection() {
    return ['基础', '分类'];
  }

  ///UI信息
  Map categoryDictionary() {
    return {
      '基础': SABUsefulDeityModel.baseCategoryArray(),
      '分类': SABExpertCategoryModel.categoryArray(),
    };
  }

  Widget categoryController(String category, SABEasyResultModel easyItem) {
    return Text('data');
  }

  Future<void> getsCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    stringCategory = prefs.getString(strExpertCategory) ?? '趋避';
    print(stringCategory);
  }

  Future<void> setCategory(String strType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(strExpertCategory, strType);
  }
}
