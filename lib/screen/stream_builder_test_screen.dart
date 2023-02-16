import 'package:busan_univ_matzip/widgets/custom_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamBuilderTestScreen extends StatefulWidget {
  const StreamBuilderTestScreen({super.key, required this.data});

  final QuerySnapshot<Map<String, dynamic>> data;

  @override
  State<StreamBuilderTestScreen> createState() =>
      _StreamBuilderTestScreenState();
}

class _StreamBuilderTestScreenState extends State<StreamBuilderTestScreen> {
  @override
  Widget build(BuildContext context) {
    final querySnapShot = widget.data;

    return PageView.builder(
      itemCount: querySnapShot.docs.length,
      itemBuilder: (_, index) {
        var docs = querySnapShot.docs[index].data();
        return Image.network(
          docs['postURL'].toString(),
          fit: BoxFit.fill,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
              child,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return const CustomIndicator(offstage: false);
            }
          },
          errorBuilder: (context, error, stackTrace) =>
              const Text("no Image to show"),
        );
      },
    );
  }
}
