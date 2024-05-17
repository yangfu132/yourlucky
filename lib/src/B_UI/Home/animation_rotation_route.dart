import 'package:flutter/material.dart';

class RotationDemoRoute extends StatefulWidget {
  const RotationDemoRoute({super.key});

  @override
  RotationDemoRouteState createState() {
    return RotationDemoRouteState();
  }
}

class RotationDemoRouteState extends State<RotationDemoRoute>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: RotationTransition(
        turns: _controller
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                _controller.reset();
                _controller.forward();
              }
            },
          ),
        child: const CircleAvatar(
          radius: 25,
          backgroundImage: ExactAssetImage('images/dong1@2x.png'),
          child: Icon(Icons.queue_music),
        ),
      ),
    );
  }
}
