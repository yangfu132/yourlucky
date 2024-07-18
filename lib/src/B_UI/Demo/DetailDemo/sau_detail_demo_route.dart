import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Image/sau_upload_image_view.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/TaskProgress/sau_task_progress_widget.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/TaskProgress/sau_task_step_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/sau_divider_widget.dart';
import 'package:your_lucky/src/E_Service/sas_file_service.dart';

import 'sau_detail_demo_route_model.dart';
import 'sau_detail_demo_route_store_model.dart';

class SAUDetailDemoRoute extends StatefulWidget {
  const SAUDetailDemoRoute({super.key, this.title, required this.store});
  final String? title;
  final TransferTaskDetailStore store;
  @override
  SAUDetailDemoRouteState createState() {
    return SAUDetailDemoRouteState();
  }
}

class SAUDetailDemoRouteState extends State<SAUDetailDemoRoute> {
  var content = 'loading';

  @override
  void initState() {
    super.initState();
    SASFileService.readFile((content) {
      this.content = content;
      setState(() {

      });
    });
  }

  Widget _buildBody() {
    final steps = widget.store.data!.statusList!
        .map((e) => SAUTaskStepModel(e.status!, e.statusStr!, e.statusLabel!,
        e.state == VitsTaskDetailStatusListState.done))
        .toList();
    final children = <Widget>[
      _buildBoxContainer(
        SAUTaskProgressWidget(
          widget.store.data!.taskInfo!.status!,
          VitsTaskStatus.cancelled,
          steps,
              () => widget.store.gotoOperationHistory(),
        ),
      ),
      _buildBoxContainer(_buildVehicleInfo(widget.store)),
      _buildBoxContainer(_buildAllocateInfo(widget.store)),
      _buildBoxContainer(_buildCarrierInfo(widget.store)),
    ];

    if (widget.store.data!.outInfo != null) {
      children.add(_buildBoxContainer(_buildOutInfo(widget.store, context)));
    }

    if (widget.store.data!.inInfo != null) {
      children.add(_buildBoxContainer(_buildInInfo(widget.store, context)));
    }

    children.add(_buildBoxContainer(_buildTaskInfo(widget.store)));

    children.add(const SizedBox(height: 40));
    final body = Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: children,
        ),
      ),
    );
    if (widget.store.data!.buttonRoles!.isEmpty) {
      return body;
    } else {
      return Column(
        children: [
          Expanded(
            child: body,
          ),
          _buildBottomButtons(widget.store),
        ],
      );
    }
  }

  Widget _buildVehicleInfo(TransferTaskDetailStore store) {
    final vehicleInfo = store.data!.vehicleInfo!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('车辆信息'),
        const SAUDividerWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: _buildVehicleContent(store),
        ),
        const SAUDividerWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/transfer/image/dept.png')),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  vehicleInfo.parkDeptName!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildVehicleContent(TransferTaskDetailStore store) {
    final info = store.data!.vehicleInfo!;
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => store.gotoVehicleInfo(),
        child: Row(
          children: [
            CachedNetworkImage(
                height: 50, width: 86, imageUrl: info.vehicleModelPic!),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        info.vehicleNo!,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      info.vehicleModel!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF333333),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllocateInfo(TransferTaskDetailStore store) {
    final info = store.data!.allocateInfo!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle('调拨信息'),
        const SAUDividerWidget(),
        const SizedBox(height: 10),
        _buildInfoCell('调出门店', info.outDeptName!),
        _buildInfoCell('调出地址', info.outAddress!),
        _buildInfoCell('调入门店', info.inDeptName!),
        _buildInfoCell('调入地址', info.inAddress!),
        _buildInfoCell('预计调出时间', info.estimateOutTimeStr!),
        _buildInfoCell('预计调入时间', info.estimateInTimeStr!),
        const SizedBox(height: 10),
      ],
    );
  }


  Widget _buildCarrierInfo(TransferTaskDetailStore store) {
    final info = store.data!.carrierInfo!;
    final children = <Widget>[
      _buildTitle('承运信息'),
      const SAUDividerWidget(),
      const SizedBox(height: 10),
      _buildInfoCell('是否承运', info.needCarry! ? '是' : '否'),
    ];
    if (info.needCarry!) {
      children.addAll([
        _buildInfoCell('承运商', info.carrier!),
        _buildInfoCellWithPhone(
            '联系人',
            '${info.contactName} ${info.contactPhone}',
            info.contactPhone!,
            store),
        _buildInfoCell('预计在途时长', info.estimateDurationStr!),
        _buildInfoCell('交车地址', info.deliverAddress!),
        _buildInfoCellWithPhone(
            '交车联系人',
            '${info.deliverContactName} ${info.deliverContactPhone}',
            info.deliverContactPhone!,
            store),
        _buildInfoCell('接车地址', info.receiveAddress!),
        _buildInfoCellWithPhone(
            '接车联系人',
            '${info.receiveContactName} ${info.receiveContactPhone}',
            info.receiveContactPhone!,
            store),
      ]);
    }
    children.add(const SizedBox(height: 10));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildOutInfo(TransferTaskDetailStore store, BuildContext context) {
    final info = store.data!.outInfo!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleWithAction('调出信息', store.gotoOutInfo),
        const SAUDividerWidget(),
        const SizedBox(height: 10),
        _buildInfoCellWithPhone(
            '调出人', '${info.empName} ${info.empPhone}', info.empPhone!, store),
        _buildInfoCell('调出时间', info.timeStr!),
        const SizedBox(height: 10),
        const SAUDividerWidget(),
        const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            '交接单',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
        ),
        _buildDeliverReceipt(info.deliverReceipt!, context),
      ],
    );
  }

  Widget _buildInInfo(TransferTaskDetailStore store, BuildContext context) {
    final info = store.data!.inInfo!;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildTitleWithAction('调入信息', store.gotoInInfo),
      const SAUDividerWidget(),
      const SizedBox(height: 10),
      _buildInfoCellWithPhone(
          '调入人', '${info.empName} ${info.empPhone}', info.empPhone!, store),
      _buildInfoCell('调入时间', info.timeStr!),
      const SizedBox(height: 10),
      const SAUDividerWidget(),
      const Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text(
          '交接单',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
      ),
      _buildDeliverReceipt(info.deliverReceipt!, context),
    ]);
  }

  Widget _buildDeliverReceipt(List<String> receipts, BuildContext context) {
    if (receipts.isNotEmpty) {
      return SAUUploadImageView(receipts, false, 0);
    } else {
      return const SizedBox(
        height: 15,
      );
    }
  }

  Widget _buildTaskInfo(TransferTaskDetailStore store) {
    final taskInfo = store.data!.taskInfo!;
    final processInfo = store.data!.processInfo!;
    final children = [
      _buildTitle('工单信息'),
      const SAUDividerWidget(),
      const SizedBox(height: 10),
    ];

    if (taskInfo.taskNo != null) {
      children.add(_buildInfoCell('工单编号', taskInfo.taskNo!));
    }

    if (taskInfo.taskSource != null) {
      children.add(_buildInfoCell('工单来源', taskInfo.taskSource!));
    }

    if (processInfo.createTime != null) {
      children.add(_buildInfoCell('创建时间', processInfo.createTime!));
    }

    if (processInfo.dispatchOurTime != null) {
      children.add(_buildInfoCell('派单时间(调出)', processInfo.dispatchOurTime!));
    }
    if (processInfo.startTime != null) {
      children.add(_buildInfoCell('开始时间', processInfo.startTime!));
    }
    if (processInfo.dispatchInTime != null) {
      children.add(_buildInfoCell('派单时间(调入)', processInfo.dispatchInTime!));
    }
    if (taskInfo.status == VitsTaskStatus.cancelled) {
      children.add(_buildInfoCell('取消时间', processInfo.cancelTime!));
    } else if (taskInfo.status == VitsTaskStatus.done) {
      children.add(_buildInfoCell('完成时间', processInfo.completeTime!));
    }
    children.add(
      const SizedBox(height: 10),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildBottomButtons(TransferTaskDetailStore store) {
    final children = <Widget>[];
    final buttons = store.data!.buttonRoles!;
    final lastIndex = buttons.length - 1;
    for (int i = 0; i < buttons.length; i++) {
      children.add(_buildButton(store, buttons[i], i == lastIndex));
      if (i != lastIndex) {
        children.add(const SizedBox(width: 10));
      }
    }

    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1a0E567F),
            blurRadius: 10.0,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(children: children),
    );
  }

  Widget _buildButton(TransferTaskDetailStore store,
      VitsTaskDetailButtonRolesModel role, bool isLast) {
    final backColor = isLast ? const Color(0xFFFEAB00) : Colors.white;
    final borderColor = isLast ? const Color(0xFFFEAB00) : const Color(0xFFDCDFE6);
    final textColor = isLast ? Colors.white : Colors.black;
    return Expanded(
      child: Material(
        shape: StadiumBorder(
          side: BorderSide(
            width: 0.5,
            color: borderColor,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        color: backColor,
        child: InkWell(
          onTap: () => store.tapButton(role.code!),
          child: Center(
            child: Text(
              role.name!,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTitleWithAction(String title, VoidCallback action) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => action(),
        child: Row(
          children: [
            Expanded(
              child: _buildTitle(title),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCell(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 114),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ),
          Expanded(
            child: Text(
              detail,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCellWithPhone(String title, String detail, String phone,
      TransferTaskDetailStore store) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 114),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              detail,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ),
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () => store.callMobilePhone(phone),
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.phone,
                size: 16,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBoxContainer(Widget child) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x1a0E567F),
            blurRadius: 20.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backIconButton(context),
        title: const Text('详情'),
      ),
      body: _buildBody(),
    );
  }

  IconButton backIconButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        });
  }
}