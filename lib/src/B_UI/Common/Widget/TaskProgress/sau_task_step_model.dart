class SAUTaskStepModel {
  /// 步骤枚举，用于和 currentStep 比对
  final int step;

  /// 状态名称
  final String title;

  /// 标签：1，2，3，4
  final String iconTitle;

  /// 是否完成
  final bool done;

  SAUTaskStepModel(this.step, this.title, this.iconTitle, this.done);
}

/// 0完成，1:未完成
class VitsTaskDetailStatusListState {
  /// 0完成
  static const done = 0;

  /// 1:未完成
  static const undone = 1;
}

/// 工单状态：1:待派发,2:待调出,3:待调入,4:已完成,5:已取消
class VitsTaskStatus {
  /// 1:待派发
  static const waitDistributing = 1;

  /// 2:待调出
  static const waitOut = 2;

  /// 3:待调入
  static const waitIn = 3;

  /// 4:已完成
  static const done = 4;

  /// 5:已取消
  static const cancelled = 5;
}
