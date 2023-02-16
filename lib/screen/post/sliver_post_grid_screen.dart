import 'package:busan_univ_matzip/widgets/post/small_post_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SliverPostGridScreen extends StatelessWidget {
  const SliverPostGridScreen({
    super.key,
    required this.querySnapShot,
  });

  final QuerySnapshot<Map<String, dynamic>> querySnapShot;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: querySnapShot.docs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 13,
      ),
      itemBuilder: (_, index) => SmallPostWidget(
        docs: querySnapShot.docs[index].data(),
      ),
    );
  }
}
