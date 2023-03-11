import 'package:busan_univ_matzip/widgets/post/like_widget.dart';
import 'package:flutter/material.dart';

class AppBarTrailingWidget extends StatefulWidget {
  const AppBarTrailingWidget({
    super.key,
    required this.docs,
  });
  final Map<String, dynamic> docs;

  @override
  State<AppBarTrailingWidget> createState() => _AppBarTrailingWidgetState();
}

class _AppBarTrailingWidgetState extends State<AppBarTrailingWidget> {
  @override
  Widget build(BuildContext context) {
    return LikeWidget(docs: widget.docs);
  }
}
