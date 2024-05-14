import 'package:your_lucky/src/A_Context/SACContext.dart';
import 'package:your_lucky/src/A_Context/SACGlobal.dart';

class SABBaseBusiness {
  void error() {
    coLog(
      StackTrace.current,
      LogTypeEnum.error,
      '--- ${this.runtimeType} error --- ',
    );
    print("");
  }
}
