import 'package:busan_univ_matzip/model/user.dart';
import 'package:busan_univ_matzip/providers/user_provider.dart';
import 'package:busan_univ_matzip/widgets/post/like_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarTrailingWidget extends StatelessWidget {
  const AppBarTrailingWidget({
    super.key,
    required this.docs,
  });
  final Map<String, dynamic> docs;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User currentUser = userProvider.getUser;
    return LikeWidget(currentUser: currentUser, docs: docs);
  }
}
