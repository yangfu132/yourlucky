
import 'package:your_lucky/src/D_Business/Base/sab_base_model.dart';

class SAUDetailRouteModel extends SABBaseModel {
  SAUDetailRouteModel({required this.stringTitle, this.data, this.stringRemark, this.stringPlaceholder});
  final String stringTitle;
  final String? data;
  String? stringPlaceholder;
  String? stringRemark;
}

class VitsTaskDetailModel {

  /// 权限按钮

  final List<VitsTaskDetailButtonRolesModel>? buttonRoles;


  /// 处理进度

  final List<VitsTaskDetailStatusListModel>? statusList;


  /// 车辆信息

  final VitsTaskDetailVehicleInfoModel? vehicleInfo;


  /// 调拨信息

  final VitsTaskDetailAllocateInfoModel? allocateInfo;


  /// 承运信息

  final VitsTaskDetailCarrierInfoModel? carrierInfo;


  /// 调出信息

  final VitsTaskDetailOutInfoModel? outInfo;


  /// 调入信息

  final VitsTaskDetailInInfoModel? inInfo;


  /// 工单信息

  final VitsTaskDetailTaskInfoModel? taskInfo;


  /// 处理信息

  final VitsTaskDetailProcessInfoModel? processInfo;


  VitsTaskDetailModel(


      this.buttonRoles,



      this.statusList,



      this.vehicleInfo,



      this.allocateInfo,



      this.carrierInfo,



      this.outInfo,



      this.inInfo,



      this.taskInfo,



      this.processInfo,


      );
}

class VitsTaskDetailButtonRolesModel {

  /// 按钮编码

  final String? code;


  /// 按钮名称

  final String? name;


  VitsTaskDetailButtonRolesModel(


      this.code,



      this.name,


      );
}

class VitsTaskDetailStatusListModel {

  /// 状态

  final int? status;


  /// 状态名称

  final String? statusStr;


  /// 标签：1，2，3，4

  final String? statusLabel;


  /// 0完成，1:未完成

  final int? state;


  VitsTaskDetailStatusListModel(


      this.status,



      this.statusStr,



      this.statusLabel,



      this.state,


      );
}

class VitsTaskDetailVehicleInfoModel {

  /// 车牌号

  final String? vehicleNo;


  /// 车型图片

  final String? vehicleModelPic;


  /// 车型

  final String? vehicleModel;


  /// 停放门店

  final String? parkDeptName;


  /// 车辆id

  final String? vehicleId;


  VitsTaskDetailVehicleInfoModel(


      this.vehicleNo,



      this.vehicleModelPic,



      this.vehicleModel,



      this.parkDeptName,



      this.vehicleId,


      );

}

class VitsTaskDetailAllocateInfoModel {

  /// 调出城市id

  final String? outCityId;


  /// 调入城市id

  final String? inCityId;


  /// 调出门店名称

  final String? outDeptName;


  /// 调出门店id

  final String? outDeptId;


  /// 调出地址

  final String? outAddress;


  /// 调入门店名称

  final String? inDeptName;


  /// 调入门店id

  final String? inDeptId;


  /// 调入地址

  final String? inAddress;


  /// 预计调出时间

  final String? estimateOutTimeStr;


  /// 预计调入时间

  final String? estimateInTimeStr;


  VitsTaskDetailAllocateInfoModel(


      this.outCityId,



      this.inCityId,



      this.outDeptName,



      this.outDeptId,



      this.outAddress,



      this.inDeptName,



      this.inDeptId,



      this.inAddress,



      this.estimateOutTimeStr,



      this.estimateInTimeStr,


      );

}

class VitsTaskDetailCarrierInfoModel {

  /// 是否承运

  final bool? needCarry;


  /// 承运商

  final String? carrier;


  /// 联系人

  final String? contactName;


  /// 联系人电话

  final String? contactPhone;


  /// 预计在途时间

  final String? estimateDurationStr;


  /// 交车地址

  final String? deliverAddress;


  /// 交车联系人

  final String? deliverContactName;


  /// 交车联系人电话

  final String? deliverContactPhone;


  /// 接车地址

  final String? receiveAddress;


  /// 接车联系人

  final String? receiveContactName;


  /// 接车联系人电话

  final String? receiveContactPhone;


  VitsTaskDetailCarrierInfoModel(


      this.needCarry,



      this.carrier,



      this.contactName,



      this.contactPhone,



      this.estimateDurationStr,



      this.deliverAddress,



      this.deliverContactName,



      this.deliverContactPhone,



      this.receiveAddress,



      this.receiveContactName,



      this.receiveContactPhone,


      );
}

class VitsTaskDetailOutInfoModel {

  /// 调出人

  final String? empName;


  /// 调出人电话

  final String? empPhone;


  /// 调出时间

  final String? timeStr;


  /// 交接单

  final List<String>? deliverReceipt;


  VitsTaskDetailOutInfoModel(


      this.empName,



      this.empPhone,



      this.timeStr,



      this.deliverReceipt,


      );

}

class VitsTaskDetailInInfoModel {

  /// 当前状态

  final String? statusStr;


  /// 当前状态

  final int? status;


  /// 调入人

  final String? empName;


  /// 调入人电话

  final String? empPhone;


  /// 调入时间

  final String? timeStr;


  /// 交接单

  final List<String>? deliverReceipt;


  VitsTaskDetailInInfoModel(


      this.statusStr,



      this.status,



      this.empName,



      this.empPhone,



      this.timeStr,



      this.deliverReceipt,


      );
}

class VitsTaskDetailTaskInfoModel {

  /// 是否可以点击调度

  final bool? canDispatch;


  /// 无法调度tip

  final String? noDispatchTip;


  /// 调出调度单号

  final String? dispatchOutTaskId;


  /// 状态名称

  final String? statusStr;


  /// 状态

  final int? status;


  /// 工单号

  final String? taskNo;


  /// 工单id

  final String? taskId;


  /// 工单来源

  final String? taskSource;


  VitsTaskDetailTaskInfoModel(


      this.canDispatch,



      this.noDispatchTip,



      this.dispatchOutTaskId,



      this.statusStr,



      this.status,



      this.taskNo,



      this.taskId,



      this.taskSource,


      );
}

class VitsTaskDetailProcessInfoModel {

  /// 创建时间

  final String? createTime;


  /// 调出派单时间

  final String? dispatchOurTime;


  /// 调入派单时间

  final String? dispatchInTime;


  /// 开始时间

  final String? startTime;


  /// 取消时间

  final String? cancelTime;


  /// 完成时间

  final String? completeTime;


  VitsTaskDetailProcessInfoModel(


      this.createTime,



      this.dispatchOurTime,



      this.dispatchInTime,



      this.startTime,



      this.cancelTime,



      this.completeTime,


      );
}