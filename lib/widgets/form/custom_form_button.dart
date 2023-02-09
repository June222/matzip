import 'package:flutter/material.dart';

class CustomFormButton extends StatefulWidget {
  const CustomFormButton({super.key, required this.sizeAnimationController});
  final AnimationController sizeAnimationController;
  @override
  State<CustomFormButton> createState() => _CustomFormButtonState();
}

class _CustomFormButtonState extends State<CustomFormButton>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _sizeAnimation =
      Tween(begin: 1.0, end: 0.87).animate(widget.sizeAnimationController);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
