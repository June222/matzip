import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDelegate extends SliverPersistentHeaderDelegate {
  static const headerHeight = kToolbarHeight;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool isCollapsed = shrinkOffset > 0;
    return Center(
      child: Container(
        height: headerHeight,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: isCollapsed
                ? Border(bottom: BorderSide(color: Colors.grey.shade300))
                : null),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: isCollapsed
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Posts",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Row(
                  children: const [
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
              ],
            ),
          ),
          secondChild: const Align(
            alignment: Alignment.center,
            child: Text(
              "Posts",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight * 2;

  @override
  double get minExtent => headerHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
