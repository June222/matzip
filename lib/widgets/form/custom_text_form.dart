import 'package:busan_univ_matzip/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CutomTextFormField extends StatefulWidget {
  const CutomTextFormField({
    super.key,
    required TextEditingController textEditingController,
    required this.labelText,
    required this.hintText,
    this.icon,
    this.obscureText = false,
    required this.errorCheck,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final String labelText;
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
  String? _errorText;

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
    // setState(() {
    //   _animationController.forward();
    // });
  }

  void _onTapOutside() {
    // setState(() {
    //   _animationController.reverse();
    // });
  }

  void _errorCheck() async {
    if (widget.errorCheck == false) return;
    final fieldText = widget._textEditingController.text;
    if (fieldText.isNotEmpty) {
      _errorText = null;
    } else {
      _errorText = "Must Fill";
    }
  }

  void _onDelete() {
    setState(() {
      widget._textEditingController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final fieldText = widget._textEditingController.text;
    var errorExist = widget.errorCheck && fieldText.isEmpty;
    _errorCheck();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        keyboardType:
            widget.labelText == "이메일" ? TextInputType.emailAddress : null,
        controller: widget._textEditingController,
        style: const TextStyle(fontSize: 16),
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          isCollapsed: true,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 6),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: widget.icon,
          ),
          suffix: IconButton(
            icon: const FaIcon(FontAwesomeIcons.xmark),
            constraints: BoxConstraints.tight(const Size(46, 46)),
            splashRadius: 20,
            onPressed: _onDelete,
          ),
          labelText: widget.labelText,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          border: InputBorder.none,
          errorText: widget.errorCheck ? _errorText : null,
        ),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: errorExist ? 500.ms : 0.ms,
          delay: 4000.ms,
        )
        .shakeX(hz: 1.5, curve: Curves.easeInOut);
  }
}
