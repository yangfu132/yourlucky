///说明：
///Easy: 一次占卜实例
///place：八宫
///Branch：地支
///Trunk：天干
///EightDiagrams：八卦
library;

enum EasyTypeEnum {
  typeNull,
  from, //本卦
  to, //变卦
  hide, //伏卦
}

enum LogTypeEnum {
  typeNull,
  error, //错误
  log, //日志
  remark, //说明
  check, //参数检测
}

enum EmptyEnum {
  emptyNull,
  emptyNO, //非空
  emptyYES, //空
  emptyConflict, //冲空不空
  emptyFalse, //假空
  emptyReal, //真空
  emptyNoUseful, //用神未现
}

enum MonthConflictEnum {
  conflictNull,
  conflictNO, //非月破
  conflictBroken, //月破
  conflictOnDay, //临日柱，不破
  conflictMove, //动爻，不破
  conflictDayBorn, //日生，不破
  conflictMoveBorn, //动生，不破
}

enum DayConflictEnum {
  conflictNull,
  conflictNO, //非日冲
  conflictYES, //日冲
  conflictBROKEN, //日冲，弱而破
  conflictSAN, //旺相冲之不散，衰弱冲之则散,TODO:yangfu132程序中都是按照散写的
  conflictBackMove, //日冲，强而暗动
}

//输出权利：有权对其他爻发生作用的权利
enum OutRightEnum {
  RIGHT_NULL, //0
  RIGHT_NULL1, //1,占位符，无意义
  RIGHT_Day_Conflict, //2,占位符，无意义
  RIGHT_MOVE, //3,动
  RIGHT_STATIC, //4,静
  RIGHT_EMPTY, //5,空
  RIGHT_HIDE, //6,伏神
}

//note：代表无效的爻索引数，当未被复制的时候使用；
const GLOBAL_ROW_INVALID = -1;

//note：代表月柱对应到卦中的爻索引数；
const ROW_MONTH = 7;

//note：代表日柱对应到卦中的爻索引数；
const ROW_DAY = 8;

//note：代表伏卦中的爻索引数开始值，相对应的本卦的爻所引述开始值是0；
const ROW_FLY_BEGIN = 10;

///note：代表伏卦中的爻索引数结束值，相对应的本卦的爻所引述开始值是6；
///实际的索引数不包括END
const ROW_FLY_END = 16;

///note：代表变卦中的爻索引数开始值，相对应的本卦的爻所引述开始值是0；
const ROW_CHANGE_BEGIN = 20;

///note：代表变卦中的爻索引数结束值，相对应的本卦的爻所引述开始值是6；
///实际的索引数不包括END
const ROW_CHANGE_END = 26;

///最大防御值，不受生克影响
const MAX_DEFENSIVE = 1.0;
