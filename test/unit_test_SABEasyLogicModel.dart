import 'package:test/test.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABEasyLogicBusiness.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/BaseLogic/SABEasyLogicModel.dart';

void main() {
  test('my first unit test', () {
    var answer = 42;
    expect(answer, 42);
  });

  test('bMovement', () {
    SABEasyLogicModel dataModel;
    dataModel = generateData([0, 8, 0, 1, 1, 1]);
    expect(dataModel.rowModelAtRow(0).stringSymbolForwardOrBack.isEmpty, true);
    expect(dataModel.rowModelAtRow(1).stringSymbolForwardOrBack.isEmpty, true);
    expect(dataModel.rowModelAtRow(2).stringSymbolForwardOrBack.isEmpty, true);
    expect(dataModel.rowModelAtRow(3).stringSymbolForwardOrBack.isEmpty, true);
    expect(dataModel.rowModelAtRow(4).stringSymbolForwardOrBack.isEmpty, true);
    expect(dataModel.rowModelAtRow(5).stringSymbolForwardOrBack.isEmpty, true);

    dataModel = generateData([1, 1, 8, 8, 0, 0]);
    expect(dataModel.rowModelAtRow(0).stringSymbolForwardOrBack.isEmpty, true);
    expect(dataModel.rowModelAtRow(1).stringSymbolForwardOrBack.isEmpty, true);
    expect(dataModel.rowModelAtRow(2).stringSymbolForwardOrBack.isEmpty, true);
    expect(dataModel.rowModelAtRow(3).stringSymbolForwardOrBack.isEmpty, true);
    expect(dataModel.rowModelAtRow(4).stringSymbolForwardOrBack.isEmpty, true);
    expect(dataModel.rowModelAtRow(5).stringSymbolForwardOrBack.isEmpty, true);
  });
}

SABEasyLogicModel generateData(List<int> listEasyData) {
  String strEasyGoal = "单元测试";
  String strUsefulDeity = "子孙";
  String stringTime = "2023-01-28 15:27:27";
  //[0, 8, 0, 1, 1, 1]
  //[8, 8, 0, 8, 0, 0]
  //[0, 1, 1, 8, 8, 1]
  SABEasyDigitModel _inputEasyModel;
  _inputEasyModel = SABEasyDigitModel(
    modelId: null,
    strEasyGoal: strEasyGoal,
    strUsefulDeity: strUsefulDeity,
    stringTime: stringTime,
    listEasyData: listEasyData,
  );
  SABEasyLogicBusiness _logicBusiness = SABEasyLogicBusiness(_inputEasyModel);
  return _logicBusiness.outputLogicModel();
}
