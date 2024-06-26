import 'package:flutter/material.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/Button/sau_button_model.dart';
import 'package:your_lucky/src/E_Service/sas_file_service.dart';

import '../../Widget/sau_divider_widget.dart';
import 'sau_detail_route_store_model.dart';

class SAUDetailRoute extends StatefulWidget {
  const SAUDetailRoute({super.key, required this.store});
  final SAUDetailRouteStoreModel store;
  @override
  SAUDetailRouteState createState() {
    return SAUDetailRouteState();
  }
}

class SAUDetailRouteState extends State<SAUDetailRoute> {
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
    final children = <Widget>[
      _buildBoxContainer(_buildAllocateInfo(widget.store)),
    ];
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

  Widget _buildAllocateInfo(SAUDetailRouteStoreModel store) {
    final resultList = store.data!.resultList;

    List<Widget> children = [
      _buildTitleWithAction('调拨信息',store.gotoOutInfo),
      const SAUDividerWidget(),
      const SizedBox(height: 10)
    ];
    for (int index = 0; index < resultList.length; index++) {
      int dataIndex = index ~/ 2;
      Map value = resultList[dataIndex];
      children.add(_buildInfoCell(value['key'], value['value']));
    }
    children.add(const SizedBox(height: 10));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
    );
  }

  Widget _buildBottomButtons(SAUDetailRouteStoreModel store) {
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

  Widget _buildButton(SAUDetailRouteStoreModel store,
      SAUButtonModel role, bool isLast) {
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
          onTap: () => store.tapButton(role.code),
          child: Center(
            child: Text(
              role.title,
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
    widget.store.requestData();
    return Scaffold(
      appBar: AppBar(
        leading: backIconButton(context),
        title: Text(widget.store.data!.title),
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