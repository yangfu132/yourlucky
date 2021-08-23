import 'package:flutter/material.dart';
import 'package:yourlucky/src/3L_Business/EasyExpert/ExpertCategory/SABExpertCategoryBusiness.dart';

class SAUExpertCategoryRoute extends StatefulWidget {
  SAUExpertCategoryRoute();

  @override
  _SAUExpertCategoryRoute createState() {
    return _SAUExpertCategoryRoute();
  }
}

class _SAUExpertCategoryRoute extends State<SAUExpertCategoryRoute> {
  late final SABExpertCategoryBusiness categoryBusiness;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('补充'),
      ),
      body: ListView.builder(
          itemCount: 10,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            int dataIndex = index ~/ 2;
            int kv = index % 2;
            Map value = {'key': 'key', 'value': 'value'};
            if (kv > 0)
              return ListTile(
                title: Text(value['value']),
                onTap: () {
                  print('111');
                },
              );
            else
              return Container(
                //color: Colors.grey,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: ListTile(title: Text(value['key'])),
              );
            //return ListTile(title: Text(value['key']));
          }),
    );
  }
}
