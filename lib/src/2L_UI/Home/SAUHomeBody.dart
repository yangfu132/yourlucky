import 'package:flutter/material.dart';
import 'package:yourlucky/src/2L_UI/EasyStrategy/SAUStrategyResultRoute.dart';
import 'package:yourlucky/src/2L_UI/User/SAUUserRoute.dart';
import 'package:yourlucky/src/3L_Business/DigitModel/SABEasyDigitBusiness.dart';
import 'package:yourlucky/src/3L_Business/DigitModel/SABEasyDigitModel.dart';
import 'package:yourlucky/src/3L_Business/EasyDetail/SABEasyDetailBusiness.dart';
import 'package:yourlucky/src/4L_Service/SASAudioService.dart';
import 'package:yourlucky/src/4L_Service/SASLocalizationsService.dart';

import '../../1L_Context/SACContext.dart';
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
  AnimationDiceWidget animationWidget = AnimationDiceWidget(() {});
  bool _bAnimation = false;
  final SASAudioService _audioService = SASAudioService();

  @override
  void initState() {
    super.initState();
    _audioService.initAudio();
    // if (kIsWeb) {
    //   // Calls to Platform.isIOS fails on web
    //   return;
    // }
  }

  @override
  void dispose() {
    _audioService.disposeAudio();
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
        SABEasyDigitModel outEasyModel = SABEasyDigitBusiness.create();
        SABEasyDetailBusiness detailBusiness =
            SABEasyDetailBusiness(outEasyModel);
        return SAUStrategyResultRoute(detailBusiness.outputDetailModel());
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
                SASLocalizationsService.homeEasy(context),
                style: TextStyle(
                  color: Color(0xFFE5CC69),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                _bAnimation = true;
                setState(() {});
                _audioService.playAudio();
              },
            ),
          ),
          Positioned(
            bottom: 50,
            right: (SACContext.screenWidth(context) / 2 - buttonWidth) / 2,
            child: TextButton(
                child: Text(
                  SASLocalizationsService.homeUser(context),
                  style: TextStyle(
                    color: Color(0xFFE5CC69),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SAUUserRoute();
                  }));
                }),
          ),
        ],
      ),
    );
  }
}
