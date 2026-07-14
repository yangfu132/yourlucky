import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:your_lucky/src/A_Context/sac_navigator.dart';
import 'package:your_lucky/src/A_Context/sac_release.dart';
import 'package:your_lucky/src/A_Context/sac_route_url.dart';
import 'package:your_lucky/src/B_UI/EasyStrategy/sau_strategy_result_route.dart';
import 'package:your_lucky/src/B_UI/User/sau_user_route.dart';
import 'package:your_lucky/src/C_ViewModel/EasyDetail/sab_easy_detail_business.dart';
import 'package:your_lucky/src/D_Business/DigitModel/sab_easy_digit_model.dart';
import 'package:your_lucky/src/E_Service/sas_audio_service.dart';
import 'package:your_lucky/src/E_Service/sas_localizations_service.dart';

import '../../A_Context/sac_context.dart';
import 'animation_dice_widget.dart';

class SAUHomeBody extends StatefulWidget {
  const SAUHomeBody({super.key, this.title});
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
    final topPadding = MediaQuery.of(context).padding.top;
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
      SABEasyDigitModel outEasyModel = SACContext.easyStore().create();
      SABEasyDetailBusiness detailBusiness =
          SABEasyDetailBusiness(outEasyModel);
      SACNavigator.pushNamed(
          context,
          SACRouteUrl.easyResult,
          detailBusiness.outputDetailModel()
      );
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
            top: 120,
            child: imageWan,
          ),
          Positioned(
            top: topPadding + 12,
            right: 12,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => SACNavigator.pushNamed(
                  context,
                  SACRouteUrl.setting,
                  null,
                ),
                borderRadius: BorderRadius.circular(20),
                splashColor: const Color(0x33E5CC69),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'images/exported_image.svg',
                    width: 32,
                    height: 32,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFE5CC69),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: widthBg / 2,
            left: screenWidth / 4,
            width: 45 * screenRate,
            height: 45 * screenRate,
            child: Visibility(
              visible: !_bAnimation,
              child: Image.asset('images/1@2x.png'),
            ),
          ),
          Positioned(
            top: widthBg / 1.5,
            left: screenWidth / 2.5,
            width: 45 * screenRate,
            height: 45 * screenRate,
            child: Visibility(
              visible: !_bAnimation,
              child: Image.asset('images/2@2x.png'),
            ),
          ),
          Positioned(
            top: widthBg / 2,
            left: screenWidth / 4 * 2.5,
            width: 45 * screenRate,
            height: 45 * screenRate,
            child: Visibility(
              visible: !_bAnimation,
              child: Image.asset('images/4@2x.png'),
            ),
          ),
          Positioned(
            top: 50,
            bottom: 50,
            left: 0,
            right: 50,
            child: Visibility(
              visible: _bAnimation,
              child: animationDice,
            ),
          ),
          Positioned(
            bottom: 50,
            left: (SACContext.screenWidth(context) / 2 - buttonWidth) / 2,
            child: TextButton(
              child: Text(
                SASLocalizationsService.homeEasy(context),
                style: const TextStyle(
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
                  style: const TextStyle(
                    color: Color(0xFFE5CC69),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  SACNavigator.pushNamed(
                      context,
                      SACRelease.userAction(),
                      null
                  );
                }),
          ),
        ],
      ),
    );
  }
}
