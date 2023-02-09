import 'package:flutter/material.dart';

class CommentWigdet extends StatelessWidget {
  const CommentWigdet({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.deepOrange.shade100,
        // border: GradientBoxBorder(
        //   width: 1.5,
        //   gradient: SweepGradient(
        //     startAngle: 2,
        //     endAngle: 3,
        //     // tileMode: TileMode.repeated,
        //     // stops: const [0.1, 0.3],
        //     colors: [Colors.yellow.shade300, Colors.deepOrange],
        //   ),
        // ),
      ),
      // color: Colors.teal.shade100,
      child: ListTile(
        style: ListTileStyle.drawer,
        title: Text("hi#$index"),
        subtitle: const Text("hello"),
      ),
    );
  }
}
