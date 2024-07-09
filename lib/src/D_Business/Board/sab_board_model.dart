import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SABBoardModel extends SABBaseModel {
  late List<String> logList;
  void addBoard(String message) {
    logList.add(message);
  }
}