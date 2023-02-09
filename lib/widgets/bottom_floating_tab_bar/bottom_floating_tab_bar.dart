import 'package:flutter/material.dart';

class BottomFloatingTabBar extends StatelessWidget {
  const BottomFloatingTabBar({
    super.key,
    required bool bottomAppear,
  }) : _bottomAppear = bottomAppear;

  final bool _bottomAppear;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 50,
      width: !_bottomAppear ? MediaQuery.of(context).size.width * 0.92 : 0,
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
              left: 20,
              bottom: 0,
              child: IconButton(
                icon: Image.asset(
                  "assets/images/write7.png",
                  height: 35,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {},
              )),
          Positioned(
              left: 110,
              bottom: 0,
              child: IconButton(
                icon: Image.asset(
                  "assets/images/write7.png",
                  height: 35,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {},
              )),
          Positioned(
              right: 110,
              bottom: 0,
              child: IconButton(
                icon: Image.asset(
                  "assets/images/write7.png",
                  height: 35,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {},
              )),
          Positioned(
              right: 20,
              bottom: 0,
              child: IconButton(
                icon: Image.asset(
                  "assets/images/write7.png",
                  height: 35,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {},
              )),
        ],
      ),
    );
  }
}
