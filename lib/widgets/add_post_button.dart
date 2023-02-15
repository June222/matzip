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
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: IconButton(
          alignment: Alignment.center,
          onPressed: onPressed,
          icon: const FaIcon(
            FontAwesomeIcons.penToSquare,
            size: 30,
          ),
        ),
      ),
    );
  }
}
