import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPostButton extends StatelessWidget {
  const AddPostButton({
    super.key,
    required this.onPressed,
    required this.offstage,
  });
  final Function() onPressed;
  final bool offstage;
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: offstage,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: const FaIcon(
          FontAwesomeIcons.penToSquare,
          size: 30,
        ),
      ),
    );
  }
}
