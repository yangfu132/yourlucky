import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourlucky/src/1L_Context/SACContext.dart';
import 'package:yourlucky/src/3L_Business/SABSingletonBusiness.dart';

import 'src/2L_UI/Home/SAUHomeRoute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SACContext businessContext = SACContext();
    businessContext.initStep();
    SABSingletonBusiness.addObject('SACContext', businessContext);

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SAUHomeRoute(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
