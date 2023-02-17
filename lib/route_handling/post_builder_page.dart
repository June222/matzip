import 'package:busan_univ_matzip/screen/post/post_builder_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostBuilderPage extends StatelessWidget {
  const PostBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("posts")
          .orderBy("timeStamp", descending: true)
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return PostBuilderScreen(data: snapshot.data!);
        } else {
          return const Text("no connected DB");
        }
      },
    );
  }
}
