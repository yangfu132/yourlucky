import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../1L_Context/SACContext.dart';
import '../../3L_Business/Basic/SABEasyDigitModel.dart';
import '../EasyExpertResult/SAUEasyExpertResultRoute.dart';
// import 'package:flutter/src/foundation/constants.dart';
import 'AnimationDiceWidget.dart';

class SAUHomeBody extends StatefulWidget {
  SAUHomeBody({this.title});
  final String? title;
  @override
  SAUHomeBodyState createState() {
    return SAUHomeBodyState();
  }
}

class SAUHomeBodyState extends State<SAUHomeBody> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  AnimationDiceWidget animationWidget = AnimationDiceWidget(() {});
  bool _bAnimation = false;
  @override
  void initState() {
    super.initState();

    // if (kIsWeb) {
    //   // Calls to Platform.isIOS fails on web
    //   return;
    // }

    if (Platform.isIOS) {
      audioCache.fixedPlayer?.notificationService.startHeadlessService();
      advancedPlayer.notificationService.startHeadlessService();
    }
  }

  @override
  void dispose() {
    advancedPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 80.0;
    double widthBg =
        SACContext.screenHeight(context) > SACContext.screenWidth(context)
            ? SACContext.screenWidth(context)
            : SACContext.screenHeight(context);
    Image imageWan = Image.asset(
      'images/shangpingwan@2x.png',
      width: widthBg,
      height: widthBg,
      fit: BoxFit.fill,
    );

    final animationDice = AnimationDiceWidget(() {
      _bAnimation = false;
      setState(() {});
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        SABEasyDigitModel outEasyModel = SABEasyDigitModel(
          '测试',
          '子孙',
          DateTime.now(),
          SABEasyDigitModel.generateEasyArray(),
        );
        return SAUEasyExpertResultRoute(outEasyModel);
      }));
    });
    double screenWidth = SACContext.screenWidth(context);
    double screenHeight = SACContext.screenHeight(context);
    final screenRate = SACContext.screenWidth(context) / 350;
    return Center(
      child: Stack(
        children: <Widget>[
          Image.asset(
            'images/8466654.jpg',
            width: screenWidth,
            height: screenHeight,
            fit: BoxFit.fill,
          ),
          Positioned(
            child: imageWan,
            top: 40,
          ),
          Positioned(
            top: widthBg / 2,
            left: screenWidth / 4,
            width: 45 * screenRate,
            height: 45 * screenRate,
            child: Visibility(
              child: Image.asset('images/1@2x.png'),
              visible: !_bAnimation,
            ),
          ),
          Positioned(
            top: widthBg / 1.5,
            left: screenWidth / 2.5,
            width: 45 * screenRate,
            height: 45 * screenRate,
            child: Visibility(
              child: Image.asset('images/2@2x.png'),
              visible: !_bAnimation,
            ),
          ),
          Positioned(
            top: widthBg / 2,
            left: screenWidth / 4 * 2.5,
            width: 45 * screenRate,
            height: 45 * screenRate,
            child: Visibility(
              child: Image.asset('images/4@2x.png'),
              visible: !_bAnimation,
            ),
          ),
          Positioned(
            child: Visibility(
              child: animationDice,
              visible: _bAnimation,
            ),
            top: 50,
            bottom: 50,
            left: 0,
            right: 50,
          ),
          Positioned(
            bottom: 50,
            left: (SACContext.screenWidth(context) / 2 - buttonWidth) / 2,
            child: TextButton(
              child: Text(
                '开始',
                style: TextStyle(
                  color: Color(0xFFE5CC69),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                _bAnimation = true;
                setState(() {});
                audioCache.play('glass.wav', mode: PlayerMode.LOW_LATENCY);
              },
            ),
          ),
          Positioned(
            bottom: 50,
            right: (SACContext.screenWidth(context) / 2 - buttonWidth) / 2,
            child: TextButton(
                child: Text(
                  '用户',
                  style: TextStyle(
                    color: Color(0xFFE5CC69),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AnimationRoute();
                  }));
                }),
          ),
        ],
      ),
    );
  }
}
