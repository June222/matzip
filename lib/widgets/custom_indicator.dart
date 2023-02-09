import 'package:busan_univ_matzip/managers/color_manager.dart';
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
    final ColorManager colorManager = ColorManager();
    return SizedBox(
      height: 20,
      child: Offstage(
        offstage: _offstage,
        child: LoadingAnimationWidget.threeArchedCircle(
          color: Colors.deepOrange,
          // color: colorManager.appetizingColor,
          size: 20,
        ),
      ),
    );
  }
}
