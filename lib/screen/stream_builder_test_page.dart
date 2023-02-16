import 'package:busan_univ_matzip/screen/stream_builder_test_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamBuilderTest extends StatelessWidget {
  const StreamBuilderTest({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("posts")
          .orderBy("timeStamp")
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilderTestScreen(data: snapshot.data!);
        } else {
          return const Text("no connected DB");
        }
      },
    );
  }
}
