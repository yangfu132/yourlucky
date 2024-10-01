import 'package:flutter/material.dart';
import '../sau_divider_widget.dart';
import 'sau_task_step_model.dart';

class SAUTaskProgressWidget extends StatelessWidget {
  final int currentStep;
  final int cancelStep;
  final List<SAUTaskStepModel> steps;
  final VoidCallback onOperatorTapped;

  const SAUTaskProgressWidget(
      this.currentStep, this.cancelStep, this.steps, this.onOperatorTapped, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                const Text(
                  '处理进度',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () => onOperatorTapped(),
                    child: const Row(
                      children: [
                        Text('操作记录'),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Color(0xFF333333),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SAUDividerWidget(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: _buildStepper(),
          )
        ],
      ),
    );
  }

  Widget _buildStepper() {
    final children = <Widget>[];

    for (int i = 0; i < steps.length; i++) {
      children.add(_buildStep(steps[i], i == 0));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildStep(SAUTaskStepModel step, bool isFirst) {
    final done = step.done;
    final cancelled = step.step == cancelStep;
    final isCurrent = step.step == currentStep;
    final backColor = (!cancelled && (done || isCurrent))
        ? const Color(0xFFFDA500)
        : const Color(0xFFBDBDBD);
    final lineColor =
    (done || isCurrent) ? const Color(0xFFFDA500) : const Color(0xFFBDBDBD);

    final iconData = cancelled ? Icons.close : Icons.check;
    final icon = Icon(
      iconData,
      size: 15,
      color: Colors.white,
    );
    final label = Text(
      step.iconTitle,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
    );
    Widget child;
    if (isFirst && isCurrent) {
      child = label;
    } else if (done || cancelled) {
      child = icon;
    } else {
      child = label;
    }

    final content = Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          height: 18,
          width: 18,
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: backColor,
          ),
          child: Center(
            child: child,
          ),
        ),
        Text(
          step.title,
          style: const TextStyle(fontSize: 12, color: Color(0xFF999999)),
        )
      ],
    );
    if (isFirst) {
      return content;
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 2,
            width: 33,
            margin: const EdgeInsets.only(top: 9),
            color: lineColor,
          ),
          content,
        ],
      );
    }
  }
}
