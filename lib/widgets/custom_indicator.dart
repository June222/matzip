import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required bool offstage,
  }) : _offstage = offstage;

  final bool _offstage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Offstage(
        offstage: _offstage,
        child: LoadingAnimationWidget.threeArchedCircle(
          color: Theme.of(context).primaryColor,
          // color: colorManager.appetizingColor,
          size: 20,
        ),
      ),
    );
  }
}
