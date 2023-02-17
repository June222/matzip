import 'package:busan_univ_matzip/widgets/post/appBar/app_bar_sub_title_widget.dart';
import 'package:busan_univ_matzip/widgets/post/appBar/app_bar_title_widget.dart';
import 'package:busan_univ_matzip/widgets/post/appBar/app_bar_trailing_widget.dart';
import 'package:flutter/material.dart';

class AppBarImageInfoWidget extends StatelessWidget {
  const AppBarImageInfoWidget({
    super.key,
    required this.docs,
  });

  final Map<String, dynamic> docs;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.white,
      title: AppBarTitleWidget(text: docs['menu']),
      subtitle: AppBarSubTitleWidget(text: docs['discription']),
      trailing: AppBarTrailingWidget(docs: docs),
    );
  }
}
