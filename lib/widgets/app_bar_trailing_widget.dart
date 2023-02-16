import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarTrailingWidget extends StatelessWidget {
  const AppBarTrailingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      clipBehavior: Clip.none,
      children: const [
        Positioned(
          bottom: 35,
          child: FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
            size: 28,
          ),
        ),
        FaIcon(
          FontAwesomeIcons.faceSmileBeam,
          color: Colors.white,
          size: 25,
        ),
      ],
    );
  }
}
