import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CutomTextFormField extends StatefulWidget {
  const CutomTextFormField({
    super.key,
    required TextEditingController textEditingController,
    required this.labelText,
    this.icon,
    this.obscureText = false,
    required this.errorCheck,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final String labelText;
  final Widget? icon;
  final bool obscureText;
  final bool errorCheck;

  @override
  State<CutomTextFormField> createState() => _CutomTextFormFieldState();
}

class _CutomTextFormFieldState extends State<CutomTextFormField> {
  String? _errorText;
  bool _obscureText = true;

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

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
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
        textInputAction: TextInputAction.next,
        controller: widget._textEditingController,
        style: const TextStyle(fontSize: 16),
        obscureText: widget.obscureText ? _obscureText : false,
        decoration: InputDecoration(
          isCollapsed: true,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 6),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: widget.icon,
          ),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.labelText == "비밀번호")
                IconButton(
                  onPressed: _toggleObscureText,
                  constraints: BoxConstraints.tight(const Size(46, 46)),
                  splashRadius: 20,
                  icon: _obscureText
                      ? const FaIcon(
                          FontAwesomeIcons.eyeSlash,
                          size: 20,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.solidEye,
                          size: 20,
                        ),
                ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.xmark),
                constraints: BoxConstraints.tight(const Size(46, 46)),
                splashRadius: 20,
                onPressed: _onDelete,
              ),
            ],
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
