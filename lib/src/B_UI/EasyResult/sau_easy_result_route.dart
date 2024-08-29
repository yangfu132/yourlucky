import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route.dart';
import 'package:your_lucky/src/B_UI/Common/Route/sau_textfield_route_model.dart';
import 'package:your_lucky/src/B_UI/Common/Widget/ListCell/sau_select_view.dart';
import 'package:your_lucky/src/E_Service/sas_localizations_service.dart';
import 'sau_easy_result_route_store.dart';

class SAUEasyResultRoute extends StatefulWidget {
  const SAUEasyResultRoute({super.key, required this.store});
  final SAUEasyResultRouteStore store;
  @override
  SAUEasyResultRouteState createState() {
    return SAUEasyResultRouteState();
  }
}

class SAUEasyResultRouteState extends State<SAUEasyResultRoute> {
  var content = 'loading';
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    widget.store.loadData((content) {
      this.content = content;
      setState(() {
      });
    });
  }

  Widget _buildBody() {
    double screenWidth = SACContext.screenWidth(context);
    double screenHeight = SACContext.screenHeight(context);
    double padding = 40.0;
    double fontSize = content.length > 2 ? 80 : 128;
    return SingleChildScrollView(
      controller: scrollController,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'images/8466654.jpg',
            width: screenWidth,
            height: screenHeight,
            fit: BoxFit.fill,
          ),
          Container(
              padding:EdgeInsets.only(left: padding, right: padding),
              width: screenWidth,
              height: screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("",
                    style: TextStyle(
                      fontSize: 50,
                      color: Color(0xFFE5CC69),
                    ),
                    textAlign:TextAlign.center,
                  ),
                  Center(child:
                    Container(
                      // margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      // padding:EdgeInsets.fromLTRB(15, 5, 15, 5),
                      width: screenWidth - padding - 40,
                      height: screenWidth - padding - 40,
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 5,//宽度
                            color: Color(0xFFE5CC69), //边框颜色
                          ),
                          top: BorderSide(
                            width: 5,//宽度
                            color: Color(0xFFE5CC69), //边框颜色
                          ),
                          right: BorderSide(
                            width: 5,//宽度
                            color: Color(0xFFE5CC69), //边框颜色
                          ),
                          bottom: BorderSide(
                            width: 5,//宽度
                            color: Color(0xFFE5CC69), //边框颜色
                          ),
                        ),
                      ),
                      child: Center(child: Text(content,
                        style: TextStyle(
                          fontSize: content.length > 2 ? 80 : 128,
                          color: Color(0xFFE5CC69),
                        ),
                        textAlign:TextAlign.center,
                      ),),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    height: screenHeight / 5,
                    child: const Text("",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFFE5CC69),
                      ),
                      textAlign:TextAlign.center,
                    ),
                  ),
                  SelectorInputView(
                    title: '趋吉',
                    titleMinWidth: 75,
                    content: '进入详情  ',
                    onTap: () {
                      widget.store.gotoSeekFortuneDetail(context);
                    },
                  ),
                  SelectorInputView(
                    title: '避凶',
                    titleMinWidth: 75,
                    content: '进入详情  ',
                    onTap: () {
                      widget.store.gotoAvoidEvilDetail(context);
                    },
                  ),
                  SelectorInputView(
                    title: '祈福',
                    titleMinWidth: 75,
                    content: '进入详情  ',
                    onTap: () => {},
                  ),
              ],),
          ),

          Positioned(
            bottom: 50,
            height: 50,
            width: SACContext.screenWidth(context) / 2 - 20,
            left: 15,
            child: TextButton(
              child: Text(
                SASLocalizationsService.easyNamed(context),
                style: const TextStyle(
                  color: Color(0xFFE5CC69),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              onPressed: () async {
                widget.store.gotoTextField(context);
              },
            ),
          ),
          Positioned(
            bottom: 50,
            height: 50,
            right: 15,
            width: SACContext.screenWidth(context) / 2 - 20,
            child: TextButton(
                child: Text(
                  SASLocalizationsService.easyRetry(context),
                  style: const TextStyle(
                    color: Color(0xFFE5CC69),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
}

