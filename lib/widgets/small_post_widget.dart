import 'package:flutter/material.dart';

import 'custom_indicator.dart';

class SmallPostWidget extends StatelessWidget {
  const SmallPostWidget({
    super.key,
    required this.docs,
  });

  final Map<String, dynamic> docs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.network(
              docs['profileImage'].toString(),
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                  child,
              // loadingBuilder: (context, child, loadingProgress) =>
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const CustomIndicator(offstage: false);
                }
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Text("no Image to show"),
            ),
          ),
          Text("discription: ${docs['discription']}"),
          Text("username: ${docs['username']}"),
        ],
      ),
    );
  }
}
