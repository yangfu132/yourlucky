import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';
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
    double buttonWidth = 80.0;
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
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Text(content,
              style: const TextStyle(
                fontSize: 128,
                color: Color(0xFFE5CC69),
              ),
              textAlign:TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 50,
            left: (SACContext.screenWidth(context) / 2 - buttonWidth) / 2,
            child: TextButton(
              child: Text(
                SASLocalizationsService.easyNamed(context),
                style: const TextStyle(
                  color: Color(0xFFE5CC69),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {

              },
            ),
          ),
          Positioned(
            bottom: 50,
            right: (SACContext.screenWidth(context) / 2 - buttonWidth) / 2,
            child: TextButton(
                child: Text(
                  SASLocalizationsService.easyRetry(context),
                  style: const TextStyle(
                    color: Color(0xFFE5CC69),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {

                }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent, // 设置AppBar为透明
      //   elevation: 0, // 去除AppBar的阴影
      //   automaticallyImplyLeading: false,
      //   systemOverlayStyle: const SystemUiOverlayStyle(
      //     statusBarColor: Colors.transparent,//设置状态栏的背景颜色
      //     statusBarIconBrightness: Brightness.dark,//状态栏的文字的颜色
      //   ),
      // ),
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

