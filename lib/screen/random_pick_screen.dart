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
  static const int _waitPeriod = 70;
  static const int _oneSecond = 1000;
  static const Duration _waitDuration = Duration(milliseconds: _waitPeriod);
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
    var times = _oneSecond ~/ _waitPeriod;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              for (var i = 0; i < imageCategoryList.length; i++)
                FoodCategoryWidget(
                  key: UniqueKey(),
                  fileName: imageCategoryList[i],
                  picked: i == _pickedNumber && totalCount == times,
                )
                    .animate(
                      onPlay: (controller) {
                        if (totalCount == times) {
                          controller.stop();
                        }
                        if (i == _pickedNumber && totalCount == times) {
                          controller.loop(count: 2, reverse: true);
                        }
                      },
                      onComplete: (controller) => controller.reverse(),
                    )
                    .scaleXY(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                      begin: 1.0,
                      end: 2.0,
                    ),
              IconButton(
                onPressed: () => _makeRandomNumber(times),
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                ),
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
        border: Border.all(
            color:
                picked ? Theme.of(context).primaryColor : Colors.transparent),
        // borderRadius: BorderRadius.circular(10),
        // color: Theme.of(context).splashColor,
      ),
      child: Image.asset(
        "assets/images/$fileName.png",
        width: iconLength,
        height: iconLength,
      ),
    );
  }
}
