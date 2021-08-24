import 'package:flutter/material.dart';
import 'package:yourlucky/src/1L_Context/SACNavigator.dart';
import 'package:yourlucky/src/3L_Business/EasyExpert/ExpertCategory/SABExpertCategoryBusiness.dart';
import 'package:yourlucky/src/4L_Service/SASLocalizationsService.dart';

class SAUExpertCategoryRoute extends StatefulWidget {
  SAUExpertCategoryRoute();

  @override
  _SAUExpertCategoryRoute createState() {
    return _SAUExpertCategoryRoute();
  }
}

class _SAUExpertCategoryRoute extends State<SAUExpertCategoryRoute> {
  late final SABExpertCategoryBusiness categoryBusiness =
      SABExpertCategoryBusiness();

  @override
  void initState() {
    super.initState();
  }

  List categoryActionData() {
    List result = List.empty(growable: true);
    Map categoryMap = categoryBusiness.categoryDictionary();
    categoryMap.forEach((key, value) {
      result.add({'key': key, 'value': true});
      List categoryList = categoryMap[key];
      for (final item in categoryList) {
        result.add({'key': item, 'value': false});
      }
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    List categoryActionList = categoryActionData();

    return Scaffold(
      appBar: AppBar(
        title: Text(SASLocalizationsService.userCategory(context)),
      ),
      body: ListView.builder(
          itemCount: categoryActionList.length,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            Map category = categoryActionList[index];
            if (category['value']) {
              return Container(
                //color: Colors.grey,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: ListTile(
                  title: Text(category['key']),
                  onTap: null,
                ),
              );
            } else {
              return Container(
                child: ListTile(
                  title: Text(category['key']),
                  onTap: () {
                    categoryBusiness.setCategory(category['key']);
                    SACNavigator.pop(context);
                  },
                ),
                // 下边框
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(width: 1, color: Colors.grey)),
                ),
              );
            }
          }),
    );
  }
}
