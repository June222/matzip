import 'package:busan_univ_matzip/screen/post/add_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  void _toPostScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.grey.withOpacity(0.75),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddPostScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          var scale =
              Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

          return FadeTransition(
            opacity: animation.drive(scale),
            child: SlideTransition(
              position: animation.drive(tween),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 40,
      width:
          !widget._bottomAppear ? MediaQuery.of(context).size.width * 0.92 : 0,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
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
                icon: const FaIcon(
                  FontAwesomeIcons.pencil,
                  color: Colors.white,
                ),
                padding: EdgeInsets.zero,
                onPressed: _toPostScreen,
              )),
          Positioned(
              left: 110,
              top: -3,
              child: IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.newspaper,
                  color: Colors.white,
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
