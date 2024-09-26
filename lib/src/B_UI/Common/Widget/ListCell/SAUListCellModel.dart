import 'package:flutter/material.dart';
import 'package:yourlucky/src/B_UI/Common/Widget/Button/SAUButtonModel.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';

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
  Color statusStrColor = Color(0xFFF56C6C);
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
        title: 'FROM', content: "${model.diagramsModel.stringFromName}"));
    if (model.isMovement(model.listEasyData)) {
      contents.add(SAUListCellItemModel(
          title: 'TO', content: "${model.diagramsModel.stringToName}"));
    }
    contents.add(SAUListCellItemModel(title: '批注', content: model.strAnnotate));

    SAUButtonModel deleteButton = SAUButtonModel(title: '删除', code: 'delete');
    SAUButtonModel annotate = SAUButtonModel(title: "批注", code: "annotate");
    cellModel.buttons = [deleteButton, annotate];
    return cellModel;
  }
}
