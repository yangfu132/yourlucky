import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yourlucky/src/A_Context/SACContext.dart';
import 'package:yourlucky/src/E_Service/SABSingletonService.dart';
import 'package:yourlucky/src/E_Service/SASLocalizationsService.dart';

import 'src/B_UI/Home/SAUHomeRoute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SACContext businessContext = SACContext();
    businessContext.initStep();
    SABSingletonService.addObject('SACContext', businessContext);

    return MaterialApp(
      builder: BotToastInit(),
      localizationsDelegates: [
        // 本地化的代理类
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SASLocalizationsDelegate(),
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 美国英语
        const Locale('zh', 'CN'), // 中文简体
        //其它Locales
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme:AppBarTheme(
            centerTitle: true,
          ),
      ),
      home: SAUHomeRoute(title: 'Flutter Demo Home Page'),
    );
  }
}
