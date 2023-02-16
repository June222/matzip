import 'package:flutter/material.dart';

class AppBarPageViewIndexWidget extends StatelessWidget {
  const AppBarPageViewIndexWidget({
    super.key,
    required int currentPage,
    required pageViewItemCount,
  })  : _currentPage = currentPage,
        _pageViewItemCount = pageViewItemCount;

  final int _currentPage;
  final int _pageViewItemCount;

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 300);
    return Transform.translate(
      offset: const Offset(0, -60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var page = 0; page < _pageViewItemCount; page++)
            AnimatedContainer(
              duration: animationDuration,
              curve: Curves.decelerate,
              width: page == _currentPage ? 20 : 5,
              height: 5,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
        ],
      ),
    );
  }
}
