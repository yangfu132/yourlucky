import 'package:flutter/material.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_button_model.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_action_model.dart';
import 'package:your_lucky/src/D_Business/EasyLogic/Health/sab_health_sum_action_model.dart';

import '../../../../D_Business/Develop/sab_develop_model.dart';

enum SAUListCellModelItemType {
  keyValue,
  picture,
}

class SAUListCellItemModel {
  final String title;
  final String content;
  final String? secondContent;
  double titleWidth = 104;
  bool contentMultiline = false;
  bool secondEllipsis = true;
  SAUListCellModelItemType type = SAUListCellModelItemType.keyValue;

  SAUListCellItemModel(
      {required this.title,
      required this.content,
      this.secondContent,
      this.titleWidth = 104,
      this.contentMultiline = false,
      this.secondEllipsis = true});
}

class SAUListCellModel {
  final String title;
  final String? tips;
  String? statusStr;
  String? transportTaskStatusStr;
  bool showStatus = false;
  Color statusStrColor = const Color(0xFFF56C6C);
  final String taskId;
  final String? carrierId;
  Object? dataModel;
  List<SAUListCellItemModel> contents = List.empty(growable: true);
  List<SAUButtonModel> buttons = List.empty(growable: true);
  SAUListCellModel(
      {required this.title,
      required this.taskId,
      this.statusStr,
      this.tips,
      this.carrierId});

  static SAUListCellModel errorOutRangeCellModel(String message) {
    SAUListCellModel cellModel = SAUListCellModel(title: 'Index Out Range', taskId: 'taskId');
    var contents = List<SAUListCellItemModel>.empty(growable: true);
    cellModel.contents = contents;
    contents.add(SAUListCellItemModel(title: 'message', content: 'message'));
    SAUButtonModel annotate = SAUButtonModel(title: "批注", code: "annotate");
    cellModel.buttons = [annotate];
    return cellModel;
  }

  static SAUListCellModel fromEasyDigitModel(SABEasyDigitModel model) {
    SAUListCellModel cellModel = SAUListCellModel(
        title: model.stringTime, taskId: model.modelId.toString());
    var contents = List<SAUListCellItemModel>.empty(growable: true);
    cellModel.contents = contents;

    contents.add(SAUListCellItemModel(title: '目的', content: model.strEasyGoal));
    contents.add(SAUListCellItemModel(title: '门类', content: model.strStrategy));
    contents
        .add(SAUListCellItemModel(title: '用神', content: model.strUsefulDeity));
    contents.add(SAUListCellItemModel(
        title: 'FROM', content: model.diagramsModel.stringFromName));
    if (model.isMovement(model.listEasyData)) {
      contents.add(SAUListCellItemModel(
          title: 'TO', content: model.diagramsModel.stringToName));
    }
    contents.add(SAUListCellItemModel(title: '批注', content: model.strAnnotate));

    SAUButtonModel deleteButton = SAUButtonModel(title: '删除', code: 'delete');
    SAUButtonModel annotate = SAUButtonModel(title: "批注", code: "annotate");
    SAUButtonModel actionList = SAUButtonModel(title: "Action", code: "actionList");
    cellModel.buttons = [deleteButton, annotate,actionList];
    return cellModel;
  }

  static SAUListCellModel fromDevelopModel(SABDevelopModel model) {
    SAUListCellModel cellModel = SAUListCellModel(
        title: model.stringTime, taskId: model.modelId.toString());
    var contents = List<SAUListCellItemModel>.empty(growable: true);
    cellModel.contents = contents;

    contents.add(SAUListCellItemModel(title: '目的', content: model.strGoal));
    contents.add(SAUListCellItemModel(title: '门类', content: model.strStrategy));
    contents
        .add(SAUListCellItemModel(title: '用神', content: model.strUsefulDeity));
    contents.add(SAUListCellItemModel(title: '批注', content: model.strAnnotate));

    SAUButtonModel deleteButton = SAUButtonModel(title: '删除', code: 'delete');
    SAUButtonModel annotate = SAUButtonModel(title: "批注", code: "annotate");
    SAUButtonModel upload = SAUButtonModel(title: "上传", code: "upload");
    SAUButtonModel removeUpload = SAUButtonModel(title: "移除上传", code: "removeUpload");
    cellModel.buttons = [upload,removeUpload,deleteButton, annotate];
    return cellModel;
  }

  static SAUListCellModel fromActionModel(SABHealthActionModel model) {
    SAUListCellModel cellModel = SAUListCellModel(
        title: model.timeDes, taskId: "taskId");
    cellModel.dataModel = model;
    var contents = List<SAUListCellItemModel>.empty(growable: true);
    cellModel.contents = contents;
    contents.add(SAUListCellItemModel(title: 'ActionType', content: model.getActionTypeName()));
    contents.add(SAUListCellItemModel(title: 'doubleHealth', content: "${model.doubleHealth}"));
    contents.add(SAUListCellItemModel(title: 'easyType', content: model.easyType.name));
    contents.add(SAUListCellItemModel(title: 'row', content: "${model.nRow}"));
    contents.add(SAUListCellItemModel(title: 'sumList', content: "${model.sumActionList.length}条"));
    contents.add(SAUListCellItemModel(title: 'effectRowList', content: "迁移到sum"));
    contents.add(SAUListCellItemModel(title: 'basicDefense', content: "${model.basicDefense ?? "空"}"));
    contents.add(SAUListCellItemModel(title: 'isBasicHealth', content: model.isBasicHealth ? '是' : '否'));
    SAUButtonModel annotate = SAUButtonModel(title: "批注", code: "annotate");
    cellModel.buttons = [annotate];
    return cellModel;
  }

  static SAUListCellModel fromSumModel(SABHealthSumActionModel model) {
    SAUListCellModel cellModel = SAUListCellModel(
        title: model.timeDes, taskId: "taskId");
    var contents = List<SAUListCellItemModel>.empty(growable: true);
    cellModel.contents = contents;
    contents.add(SAUListCellItemModel(title: 'targetRow', content: "${model.targetModel.nRow}"));
    contents.add(SAUListCellItemModel(title: 'targetType', content: model.targetModel.easyType.name));
    contents.add(SAUListCellItemModel(title: 'targetName', content: model.targetModel.symbolName));
    contents.add(SAUListCellItemModel(title: 'addendRow', content: "${model.addendModel.nRow}"));
    contents.add(SAUListCellItemModel(title: 'addendType', content: model.addendModel.easyType.name));
    contents.add(SAUListCellItemModel(title: 'addendName', content: model.addendModel.symbolName));
    contents.add(SAUListCellItemModel(title: 'targetHealth', content: '${model.targetModel.health}'));
    contents.add(SAUListCellItemModel(title: 'addendHealth', content: '${model.addendModel.getOut()}'));
    contents.add(SAUListCellItemModel(title: 'resultHealth', content: '${model.getResult()}'));

    SAUButtonModel annotate = SAUButtonModel(title: "批注", code: "annotate");
    cellModel.buttons = [annotate];
    return cellModel;
  }
}
