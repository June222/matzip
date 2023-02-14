import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print(shrinkOffset);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState:
              true ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Posts",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "view all",
                style: TextStyle(fontSize: 16),
              ),
              FaIcon(
                FontAwesomeIcons.chevronRight,
                size: 12,
              ),
            ],
          ),
          secondChild: const Text(
            "Posts",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
