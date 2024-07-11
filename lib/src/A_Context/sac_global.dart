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

enum ActionTypeEnum {
  typeNull,
  fromJson,
  init,
  update,
  sum,
}

enum LogTypeEnum {
  typeNull,
  error, //错误
  print,
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
  conflictOnDay, //冲临日柱，不破
  conflictMove, //冲动爻，不破
  conflictDayBorn, //冲日生，不破
  conflictMoveBorn, //冲动生，不破
}

//TODO：https://astro.sohu.com/a/772079859_100084723
//这里说的不对，无论是否临日，日生、日和、有气、有根，最后都应该归结为强弱，应该变为可以计算的值；
enum DayConflictEnum {
  conflictNull,
  conflictNO, //非日冲
  conflictYES, //日冲
  conflictBROKEN, //静爻，日冲，弱而破
  conflictSAN, //动爻， 旺相冲之不散，衰弱冲之则散,
  conflictBackMove, //日冲，强而暗动
}

//输出权利：有权对其他爻发生作用的权利
//TODO：增加月破
enum OutRightEnum {
  rightTypeNull, //0
  rightTypeBroken, //1,静爻冲破或者动爻冲散
  rightTypeDayConflict, //2,日冲，//此值为中间态，最后态为：强则变为rightTypeMove，弱则变为rightTypeBroken
  rightTypeMove, //3,动
  rightTypeStatic, //4,静
  rightTypeEmpty, //5,空
  rightTypeHide, //6,伏神
}

//note：代表无效的爻索引数，当未被复制的时候使用；
const globalRowInvalid = -1;

//note：代表月柱对应到卦中的爻索引数；
const globalRowMonth = 7;

//note：代表日柱对应到卦中的爻索引数；
const globalRowDay = 8;

//note：代表伏卦中的爻索引数开始值，相对应的本卦的爻所引述开始值是0；
const globalRowFlyBegin = 10;

///note：代表伏卦中的爻索引数结束值，相对应的本卦的爻所引述开始值是6；
///实际的索引数不包括END
const globalRowFlyEnd = 16;

///note：代表变卦中的爻索引数开始值，相对应的本卦的爻所引述开始值是0；
const globalRowChangeBegin = 20;

///note：代表变卦中的爻索引数结束值，相对应的本卦的爻所引述开始值是6；
///实际的索引数不包括END
const globalRowChangeEnd = 26;

///最大防御值，不受生克影响
const globalMaxDefensive = 1.0;
