import 'dart:math';

import 'package:busan_univ_matzip/managers/image_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RandomPickScreen extends StatefulWidget {
  const RandomPickScreen({super.key});

  @override
  State<RandomPickScreen> createState() => _RandomPickScreenState();
}

class _RandomPickScreenState extends State<RandomPickScreen> {
  static const int period = 70;
  static const int oneSecond = 1000;
  static const Duration _waitDuration = Duration(milliseconds: period);
  static final rng = Random();

  var _pickedNumber = 100;
  var totalCount = 0;

  Future<void> wait(Duration duration) async {
    await Future.delayed(duration);
  }

  void _makeRandomNumber(int times) async {
    for (totalCount = 0; totalCount < times; totalCount++) {
      _pickedNumber = rng.nextInt(imageCategoryList.length);
      await wait(_waitDuration);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var times = oneSecond ~/ period;
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
                FoodCategoryWidget(
                  key: UniqueKey(),
                  fileName: imageCategoryList[i],
                  picked: i == _pickedNumber,
                )
                    .animate(
                      onPlay: (controller) {
                        if (i == _pickedNumber && totalCount == times) {
                          controller.loop(count: 2);
                        }
                      },
                      onComplete: (controller) => controller.reset(),
                    )
                    .scaleXY(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      begin: 1.0,
                      end: 2.0,
                    ),
              IconButton(
                onPressed: () => _makeRandomNumber(times),
                icon: const Icon(Icons.arrow_forward_rounded),
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
    if (kDebugMode) {
      // print(fileName);
      // print(picked);
      // print("");
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: picked ? Colors.yellow : Colors.transparent),
      ),
      child: Image.asset(
        "assets/images/$fileName.png",
        width: iconLength,
        height: iconLength,
      ),
    );
  }
}
