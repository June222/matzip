import 'package:busan_univ_matzip/widgets/custom_indicator.dart';
import 'package:flutter/material.dart';

class DocsImageWidget extends StatelessWidget {
  const DocsImageWidget({
    super.key,
    required this.docs,
    this.width,
    this.height,
  });

  final Map<String, dynamic> docs;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      docs['postURL'].toString(),
      width: width,
      height: height,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
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
  }
}
