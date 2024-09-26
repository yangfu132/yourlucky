import 'package:test/test.dart';
import 'package:yourlucky/src/D_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/Health/SABEasyHealthBusiness.dart';
import 'package:yourlucky/src/D_Business/EasyLogic/Health/SABHealthModel.dart';

void main() {
  test('my first unit test', () {
    var answer = 42;
    expect(answer, 42);
  });

  test('my first unit test', () {
    SABHealthModel healthModel;
    healthModel = generateTestModel([0, 8, 0, 1, 1, 1]);
    // expect(healthModel.rowModelAtRow(0).bMovement, false);
    // expect(healthModel.rowModelAtRow(1).bMovement, true);
    // expect(wordsModel.rowModelAtRow(2).bMovement, false);
    // expect(wordsModel.rowModelAtRow(3).bMovement, false);
    // expect(wordsModel.rowModelAtRow(4).bMovement, false);
    // expect(wordsModel.rowModelAtRow(5).bMovement, false);
  });
}

SABHealthModel generateTestModel(List<int> listEasyData) {
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
  SABEasyHealthBusiness _healthBusiness =
      SABEasyHealthBusiness(_inputEasyModel);
  return _healthBusiness.outHealthModel();
}
