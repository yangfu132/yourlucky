
import 'package:yourlucky/src/B_UI/Common/Widget/Button/SAUBottomButtonBarModel.dart';
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

  static SAUListCellModel fromEasyDigitModel (SABEasyDigitModel model) {
    SAUListCellModel cellModel = SAUListCellModel(title: model.strEasyGoal,taskId: model.modelId.toString());
    var contents = List<SAUListCellItemModel>.empty(growable: true);
    cellModel.contents = contents;

    contents.add(SAUListCellItemModel(
        title: '时间',
        content:model.stringTime
    ));
    contents.add(SAUListCellItemModel(
        title: 'FROM',
        content:"${model.diagramsModel.stringFromName}"
    ));
    if (model.isMovement(model.listEasyData)) {
      contents.add(SAUListCellItemModel(
          title: 'TO',
          content:"${model.diagramsModel.stringToName}"
      ));
    }
    SAUButtonModel deleteButton = SAUButtonModel(title: '删除',code: 'delete');
    cellModel.buttons = [deleteButton];
    return cellModel;
  }
}