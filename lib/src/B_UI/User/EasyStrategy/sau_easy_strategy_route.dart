import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/A_Context/sac_navigator.dart';
import 'package:your_lucky/src/E_Service/sas_localizations_service.dart';

///功能：选择策略
class SAUEasyStrategyRoute extends StatefulWidget {
  SAUEasyStrategyRoute();

  @override
  _SAUEasyStrategyRoute createState() {
    return _SAUEasyStrategyRoute();
  }
}

class _SAUEasyStrategyRoute extends State<SAUEasyStrategyRoute> {
  @override
  void initState() {
    super.initState();
  }

  List categoryActionData() {
    List result = List.empty(growable: true);
    Map categoryMap = SACContext.expertCategory().categoryDictionary();
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
                decoration: const BoxDecoration(
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
                    SACContext.expertCategory().setCategory(category['key']);
                    SACNavigator.pop(context);
                  },
                ),
                // 下边框
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(width: 1, color: Colors.grey)),
                ),
              );
            }
          }),
    );
  }
}
