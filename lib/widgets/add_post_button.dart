import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPostButton extends StatefulWidget {
  const AddPostButton({
    super.key,
    required this.onPressed,
    required this.offstage,
  });
  final Function() onPressed;
  final bool offstage;

  @override
  State<AddPostButton> createState() => _AddPostButtonState();
}

class _AddPostButtonState extends State<AddPostButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onPressed,
      tooltip: "게시글 작성",
      child: const FaIcon(
        FontAwesomeIcons.penToSquare,
        size: 30,
      ),
    ).animate(
      onPlay: (controller) {
        if (widget.offstage) {
          controller.reverse();
        } else {
          controller.forward();
        }
      },
    ).fade(
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
      begin: 0.3,
      end: 1.0,
    );
  }
}
