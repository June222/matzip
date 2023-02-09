import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomFloatingTabBarButton extends StatelessWidget {
  const BottomFloatingTabBarButton({
    super.key,
    required bool bottomAppear,
    required this.icon,
  }) : _bottomAppear = bottomAppear;

  final IconData icon;
  final bool _bottomAppear;

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      icon,
      color: Colors.white,
      size: !_bottomAppear ? 24 : 0,
    );
  }
}
