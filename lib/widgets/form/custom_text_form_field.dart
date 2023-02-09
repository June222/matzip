import 'package:busan_univ_matzip/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CutomTextFormField extends StatefulWidget {
  const CutomTextFormField({
    super.key,
    required TextEditingController textEditingController,
    required this.labeText,
    required this.hintText,
    this.icon,
    this.obscureText = false,
    required this.errorCheck,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final String labeText;
  final String hintText;
  final Widget? icon;
  final bool obscureText;
  final bool errorCheck;

  @override
  State<CutomTextFormField> createState() => _CutomTextFormFieldState();
}

class _CutomTextFormFieldState extends State<CutomTextFormField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
  );

  late final Animation<double> _animation;

  final ColorManager colorManager = ColorManager();
  String _errorText = "";

  @override
  void initState() {
    super.initState();
    _animation = Tween(begin: 0.93, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      _animationController.forward();
    });
  }

  void _onTapOutside() {
    setState(() {
      _animationController.reverse();
    });
  }

  void _errorCheck() async {
    if (widget.errorCheck == false) return;
    final fieldText = widget._textEditingController.text;
    if (fieldText.isNotEmpty) {
      _errorText = "";
    } else {
      _errorText = "Must Fill";
    }
  }

  @override
  Widget build(BuildContext context) {
    final fieldText = widget._textEditingController.text;
    var errorExist = widget.errorCheck && fieldText.isEmpty;
    _errorCheck();
    return ScaleTransition(
      scale: _animation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: widget._textEditingController,
          onTap: _onTap,
          onTapOutside: (event) => _onTapOutside(),
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            icon: widget.icon,
            labelText: widget.labeText,
            hintText: widget.hintText,
            focusColor: Colors.green,
            errorStyle: TextStyle(color: errorExist ? Colors.red : Colors.grey),
            errorText: _errorText,
            errorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: errorExist ? Colors.red : Colors.grey),
            ),
          ),
        ),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: errorExist ? 500.ms : 0.ms,
          delay: 3000.ms,
        )
        .shakeX(hz: 1.5, curve: Curves.easeInOut);
  }
}
