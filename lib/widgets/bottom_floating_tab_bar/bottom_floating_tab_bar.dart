import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bottom_floating_tab_button.dart';

class BottomFloatingTabBar extends StatelessWidget {
  const BottomFloatingTabBar({
    super.key,
    required bool bottomAppear,
  }) : _bottomAppear = bottomAppear;

  final bool _bottomAppear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: !_bottomAppear
            ? const EdgeInsets.symmetric(vertical: 5)
            : EdgeInsets.zero,
        height: 40,
        width: !_bottomAppear ? MediaQuery.of(context).size.width * 0.9 : 0,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.8)
          ]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 40,
              child: BottomFloatingTabBarButton(
                icon: FontAwesomeIcons.fileArrowUp,
                bottomAppear: _bottomAppear,
              ),
            ),
            Positioned(
              left: 120,
              child: BottomFloatingTabBarButton(
                icon: FontAwesomeIcons.book,
                bottomAppear: _bottomAppear,
              ),
            ),
            Positioned(
              right: 120,
              child: BottomFloatingTabBarButton(
                icon: FontAwesomeIcons.listCheck,
                bottomAppear: _bottomAppear,
              ),
            ),
            Positioned(
              right: 40,
              child: BottomFloatingTabBarButton(
                icon: FontAwesomeIcons.gear,
                bottomAppear: _bottomAppear,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
