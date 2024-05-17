import 'package:flutter/material.dart';
import 'package:your_lucky/src/A_Context/sac_context.dart';

import 'animation_mutile_image.dart';

///note：三个色子转动的动画
class AnimationDiceWidget extends StatefulWidget {
  final VoidCallback callbackFinish;
  const AnimationDiceWidget(this.callbackFinish, {super.key});
  @override
  AnimationDiceState createState() {
    return AnimationDiceState();
  }
}

class AnimationDiceState extends State<AnimationDiceWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<Offset> _animationOffset1 =
      animationMethod(tweenSequenceDice1());

  late final Animation<Offset> _animationOffset2 =
      animationMethod(tweenSequenceDice2());

  late final Animation<Offset> _animationOffset3 =
      animationMethod(tweenSequenceDice3());

  late final SlideTransition _dice1 = movingDice(context, _animationOffset1);

  late final SlideTransition _dice2 = movingDice(context, _animationOffset2);

  late final SlideTransition _dice3 = movingDice(context, _animationOffset3);

  late final AnimationMutileImage images;

  bool _bFinish = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(milliseconds: 10), vsync: this);

    _controller.forward();
  }

  TweenSequence<Offset> tweenSequenceDice1() {
    double rate = 1 / 50;
    double offsetX = 30 * rate;
    double offsetY = 20 * rate;
    Offset offset0 = Offset(
      140.0 * rate,
      200.0 * rate + offsetY,
    );
    Offset offset1 = Offset(
      85.0 * rate + offsetX,
      115.0 * rate + offsetY,
    );
    Offset offset2 = Offset(
      165.0 * rate + offsetX,
      100.0 * rate + offsetY,
    );
    Offset offset3 = Offset(
      240.0 * rate + offsetX,
      160.0 * rate + offsetY,
    );
    Offset offset4 = Offset(
      140.0 * rate + offsetX,
      200.0 * rate + offsetY,
    );
    return TweenSequence<Offset>([
      //使用TweenSequence进行多组补间动画
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset0, end: offset1),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset1, end: offset2),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset2, end: offset3),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset3, end: offset4),
        weight: 1,
      ),
    ]);
  }

  TweenSequence<Offset> tweenSequenceDice2() {
    double rate = 1 / 50;
    double offsetX = 50 * rate;
    double offsetY = 20 * rate;
    //Tween(begin: _offsetBegin, end: _offsetEnd)
    Offset offset0 = Offset(
      100.0 * rate + offsetX,
      130.0 * rate + offsetY,
    );
    Offset offset1 = Offset(
      195.0 * rate + offsetX,
      115.0 * rate + offsetY,
    );
    Offset offset2 = Offset(
      175.0 * rate + offsetX,
      95.0 * rate + offsetY,
    );
    Offset offset3 = Offset(
      140.0 * rate + offsetX,
      220.0 * rate + offsetY,
    );
    Offset offset4 = Offset(
      100.0 * rate + offsetX,
      130.0 * rate + offsetY,
    );
    return TweenSequence<Offset>([
      //使用TweenSequence进行多组补间动画
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset0, end: offset1),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset1, end: offset2),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset2, end: offset3),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset3, end: offset4),
        weight: 1,
      ),
    ]);
  }

  TweenSequence<Offset> tweenSequenceDice3() {
    double rate = 1 / 50;
    double offsetX = 50 * rate;
    double offsetY = 20 * rate;
    //Tween(begin: _offsetBegin, end: _offsetEnd)
    Offset offset0 = Offset(
      230.0 * rate + offsetX,
      110.0 * rate + offsetY,
    );
    Offset offset1 = Offset(
      200.0 * rate + offsetX,
      180.0 * rate + offsetY,
    );
    Offset offset2 = Offset(
      90.0 * rate + offsetX,
      190.0 * rate + offsetY,
    );
    Offset offset3 = Offset(
      70.0 * rate + offsetX,
      140.0 * rate + offsetY,
    );
    Offset offset4 = Offset(
      230.0 * rate + offsetX,
      110.0 * rate + offsetY,
    );
    return TweenSequence<Offset>([
      //使用TweenSequence进行多组补间动画
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset0, end: offset1),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset1, end: offset2),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset2, end: offset3),
        weight: 1,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween(begin: offset3, end: offset4),
        weight: 1,
      ),
    ]);
  }

  Animation<Offset> animationMethod(TweenSequence<Offset> tweenSequence) {
    Animation<Offset> animationOffset = tweenSequence.animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (!_bFinish) {
            _bFinish = true;
            widget.callbackFinish();
          }
          //else cont.
        }
      });
    return animationOffset;
  }

  SlideTransition movingDice(context, animationOffset) {
    Image theImage = Image.asset('images/dong1@2x.png');

    final rate = SACContext.screenWidth(context) / 350;
    int width = 45;
    int height = 45;
    theImage.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      width = info.image.width;
      height = info.image.height;
    }));
    return SlideTransition(
      position: animationOffset,
      child: RotationTransition(
        turns: _controller
          ..addStatusListener(
            (status) {},
          ),
        child: AnimationMutileImage(
          {
            1: Image.asset(
              'images/dong1@2x.png',
              width: width * rate,
              height: height * rate,
              fit: BoxFit.fill,
            ),
            2: Image.asset(
              'images/dong2@2x.png',
              fit: BoxFit.fill,
              width: width * rate,
              height: height * rate,
            ),
            3: Image.asset(
              'images/dong3@2x.png',
              fit: BoxFit.fill,
              width: width * rate,
              height: height * rate,
            )
          },
          width * rate,
          height * rate,
          Colors.transparent,
          true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _dice1,
        _dice2,
        _dice3,
      ],
    );
  }
}

///note：测试界面
class AnimationRoute extends StatefulWidget {
  const AnimationRoute({super.key});

  @override
  AnimationRouteState createState() {
    return AnimationRouteState();
  }
}

class AnimationRouteState extends State<AnimationRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
        centerTitle: true,
      ),
      body: AnimationDiceWidget(() {}),
    );
  }
}
