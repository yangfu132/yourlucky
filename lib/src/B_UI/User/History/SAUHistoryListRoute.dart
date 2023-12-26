import 'package:flutter/material.dart';
import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/ListCell/SAUListCell.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/ListCell/SAUListCellModel.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/SAUToastWidget.dart';
import 'package:yourlucky/src/B_UI/EasyStrategy/SAUStrategyResultRoute.dart';
import 'package:yourlucky/src/B_UI/User/History/SAUEditListItem.dart';
import 'package:yourlucky/src/C_ViewModel/EasyDetail/SABEasyDetailBusiness.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';

class SAUHistoryListRoute extends StatefulWidget {
  SAUHistoryListRoute({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SAUHistoryListRouteState createState() {
    return SAUHistoryListRouteState();
  }
}

class SAUHistoryListRouteState extends State<SAUHistoryListRoute> {
  List<SABEasyDigitModel> historyData = [];
  List<GlobalKey<SAUEditListItemState>> listKey = [];
  int positionNow=0;
  @override
  void initState() {
    super.initState();
    SACContext.easyStore().load((dataList) {
      historyData = dataList;
      setState(() {});
    });
  }

  void showLoginDialog() {

    showModalBottomSheet(context: context, builder: (context){
      return Container(height: 170,color: Colors.white,child: Column(children: <Widget>[
        SizedBox(height: 20,),
        Text("删除后将无法看到该条记录，请谨慎操作",style: TextStyle(color: Colors.grey,fontSize: 14),),
        SizedBox(height: 1,),
        Container(height: 50,width:double.infinity,margin:EdgeInsets.only(left: 15,right: 15),
          child:  TextButton(onPressed:(){
            Navigator.of(context).pop();
            //_deleteBank();
            SAUToastWidget.show("你点击了删除 $positionNow");
          },
            child: Text("删除",style: TextStyle(fontSize: 16,color:Colors.blue),),),),
        SizedBox(height: 10,),
        Container(height: 50,width:double.infinity,margin:EdgeInsets.only(left: 15,right: 15),
          child:  TextButton(onPressed:(){Navigator.of(context).pop();}, child: Text("取消",style: TextStyle(fontSize: 14),),),),
      ],),);
    });
  }

  void _deleteBank(SABEasyDigitModel model){
    SACContext.easyStore().delete(model);
    listKey.removeAt(positionNow);
    historyData.removeAt(positionNow);
    setState(() {});
  }

  Widget _buildBody() {
    if (historyData.length > 0) {
      listKey = setEditListItemKey(historyData.length);
      return ListView.builder(
          itemCount: historyData.length,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            SABEasyDigitModel model = historyData[index];
            SAUListCellModel cellModel = SAUListCellModel.fromEasyDigitModel(model);
            return SAUListCell(
              model: cellModel,
              onTap: (value) => {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    SABEasyDetailBusiness detailBusiness = SABEasyDetailBusiness(model);
                    return SAUStrategyResultRoute(detailBusiness.outputDetailModel());
                  })
                )
              },
              buttonsClick: (value) => {
                if ('delete' == value.code) {
                  _deleteBank(model)
                }
              },
            );
          });
    } else {
      return ListView.builder(
          itemCount: 1,
          //itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('暂无数据，请稍后再试'),
              onTap: null,
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('历史'),
      ),
      body: _buildBody(),
    );
  }
}
