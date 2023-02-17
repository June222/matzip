import 'dart:math';

import 'package:busan_univ_matzip/managers/image_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RandomPickScreen extends StatefulWidget {
  const RandomPickScreen({super.key});

  @override
  State<RandomPickScreen> createState() => _RandomPickScreenState();
}

class _RandomPickScreenState extends State<RandomPickScreen> {
  var _pickedNumber = 0;
  final Duration _waitDuration = const Duration(milliseconds: 70);
  final rng = Random();

  Future<void> wait(Duration duration) async {
    await Future.delayed(duration);
  }

  void _makeRandomNumber(int times) async {
    for (var i = 0; i < times; i++) {
      _pickedNumber = rng.nextInt(imageCategoryList.length);
      await wait(_waitDuration);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: [
              for (var i = 0; i < imageCategoryList.length; i++)
                Hero(
                  tag: "imageCategory$i",
                  transitionOnUserGestures: true,
                  child: FoodCategoryWidget(
                    fileName: imageCategoryList[i],
                    picked: i == _pickedNumber,
                  ),
                ),
              IconButton(
                onPressed: () => _makeRandomNumber(100 ~/ 7),
                icon: const Icon(Icons.start_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FoodCategoryWidget extends StatelessWidget {
  const FoodCategoryWidget({
    super.key,
    required this.fileName,
    required this.picked,
  });
  final String fileName;
  final bool picked;
  @override
  Widget build(BuildContext context) {
    const double iconLength = 35;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: picked ? Colors.yellow : Colors.transparent),
      ),
      child: Image.asset(
        "assets/images/$fileName.png",
        width: iconLength,
        height: iconLength,
      ),
    )
        .animate(
          onPlay: (controller) {
            if (picked) {
              controller.forward();
            }
          },
          onComplete: (controller) => controller.reverse(),
        )
        .scaleXY(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeIn,
          begin: 1.0,
          end: 2.0,
        );
  }
}
