import 'package:busan_univ_matzip/managers/image_manager.dart';
import 'package:flutter/material.dart';

class AnimatedPageViewIndexWidget extends StatelessWidget {
  const AnimatedPageViewIndexWidget({
    super.key,
    required int currentPage,
  }) : _currentPage = currentPage;

  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    final ImageManager imageManager = ImageManager();
    const animationDuration = Duration(milliseconds: 300);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var page = 0; page < imageManager.imgSources.length; page++)
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
    );
  }
}
