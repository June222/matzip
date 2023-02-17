import 'package:busan_univ_matzip/model/user.dart';
import 'package:busan_univ_matzip/providers/user_provider.dart';
import 'package:busan_univ_matzip/resources/firestore_method.dart';
import 'package:busan_univ_matzip/widgets/docs_image_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SmallPostWidget extends StatefulWidget {
  const SmallPostWidget({
    super.key,
    required this.docs,
  });

  final Map<String, dynamic> docs;

  @override
  State<SmallPostWidget> createState() => _SmallPostWidgetState();
}

class _SmallPostWidgetState extends State<SmallPostWidget> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User currentUser = userProvider.getUser;

    List<dynamic> likeList = widget.docs['likes'];
    bool alreadyLiked = likeList.contains(currentUser.uid);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                child:
                    DocsImageWidget(docs: widget.docs, width: 200, height: 150),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: LikeWidget(
                  docs: widget.docs,
                  currentUser: currentUser,
                  alreadyLiked: alreadyLiked,
                ),
              )
            ],
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            title: Text(
              "${widget.docs['menu']}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${widget.docs['discription']}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class LikeWidget extends StatelessWidget {
  const LikeWidget({
    super.key,
    required this.currentUser,
    required this.alreadyLiked,
    required this.docs,
  });

  final Map<String, dynamic> docs;
  final User currentUser;
  final bool alreadyLiked;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => FireStoreMethod().likePost(
        docs['postId'],
        currentUser.uid,
        docs['likes'],
      ),
      visualDensity: VisualDensity.comfortable,
      splashRadius: 0.1,
      icon: FaIcon(
        alreadyLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        size: 24,
      ),
    );
  }
}
