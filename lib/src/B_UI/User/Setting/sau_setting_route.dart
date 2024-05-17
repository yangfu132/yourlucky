import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/D_Business/User/sab_setting_model.dart';

class SAUSettingRoute extends StatefulWidget {
  const SAUSettingRoute({super.key, this.title});
  final String? title;
  @override
  SAUSettingRouteState createState() {
    return SAUSettingRouteState();
  }
}

class SAUSettingRouteState extends State<SAUSettingRoute> {
  List<SABSettingModel> settingList = [];
  @override
  void initState() {
    super.initState();
    SACContext.setting().settingList((dataList) {
      settingList = dataList;
      setState(() {});
    });
  }

  Widget _buildBody() {
    // return Text('Waiting');
    int itemCount = settingList.isNotEmpty ? settingList.length : 1;
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        SABSettingModel settingModel;
        if (settingList.length > index) {
          settingModel = settingList[index];
          if (SettingTypeEnum.textField == settingModel.settingType) {
            return _textFieldWidget(settingModel);
          } else if (SettingTypeEnum.switchType == settingModel.settingType) {
            return _switchRowWidget(settingModel);
          } else {
            return Text(settingModel.settingTitle);
          }
        } else {
          settingModel = SACContext.setting().errorModel();
          return Text(settingModel.settingTitle);
        }
      },
    );
  }

  Widget _textFieldWidget(SABSettingModel settingModel) {
    final textController = TextEditingController();
    textController.text = settingModel.stringValue;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Text(settingModel.settingTitle),
        Padding(
          padding: const EdgeInsets.only(left: 80),
          child: TextField(
            controller: textController,
            style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
            minLines: 1,
            maxLines: 1,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              settingModel.stringValue = value;
              SACContext.setting().save(settingModel);
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _switchRowWidget(SABSettingModel settingModel) {
    return Container(
      child: Row(
        children: [
          Text(settingModel.settingTitle),
          Switch(
              value: 1 == settingModel.intValue,
              onChanged: (value) {
                if (settingModel.settingKey != "waiting") {
                  settingModel.intValue = value ? 1 : 0;
                  SACContext.setting().save(settingModel);
                  setState(() {});
                }
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: _buildBody(),
    );
  }
}
