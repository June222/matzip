import 'package:flutter/material.dart';

class BottomFloatingTabBar extends StatefulWidget {
  const BottomFloatingTabBar({
    super.key,
    required bool bottomAppear,
  }) : _bottomAppear = bottomAppear;

  final bool _bottomAppear;

  @override
  State<BottomFloatingTabBar> createState() => _BottomFloatingTabBarState();
}

class _BottomFloatingTabBarState extends State<BottomFloatingTabBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 40,
      width:
          !widget._bottomAppear ? MediaQuery.of(context).size.width * 0.92 : 0,
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
          /// 이미지로 실행하였으나 애니매이션 적용 안됨
          Positioned(
              left: 15,
              top: -3,
              child: IconButton(
                icon: Image.asset(
                  "assets/images/write7.png",
                  height: 25,
                ),
                padding: EdgeInsets.zero,
                onPressed: _toPostScreen,
              )),
          Positioned(
              left: 110,
              top: -3,
              child: IconButton(
                icon: Image.asset(
                  "assets/images/menu4.png",
                  height: 25,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {},
              )),
          Positioned(
              right: 110,
              top: -3,
              child: IconButton(
                icon: Image.asset(
                  "assets/images/write7.png",
                  height: 25,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {},
              )),
          Positioned(
              right: 15,
              top: -3,
              child: IconButton(
                icon: Image.asset(
                  "assets/images/setting2.png",
                  height: 30,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {},
              )),
        ],
      ),
    );
  }
}
