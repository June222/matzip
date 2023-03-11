import 'package:busan_univ_matzip/model/user.dart';
import 'package:busan_univ_matzip/providers/user_provider.dart';
import 'package:busan_univ_matzip/resources/firestore_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LikeWidget extends StatefulWidget {
  const LikeWidget({
    super.key,
    required this.docs,
  });

  final Map<String, dynamic> docs;

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final currentUser = firebaseAuth.currentUser;
    List<dynamic> likeList = widget.docs['likes'];
    bool alreadyLiked = likeList.contains(currentUser!.uid);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () => FireStoreMethod().likePost(
            widget.docs['postId'],
            currentUser.uid,
            widget.docs['likes'],
          ),
          visualDensity: VisualDensity.comfortable,
          splashRadius: 0.1,
          icon: FaIcon(
            alreadyLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            size: 24,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 5,
          child: Text("${widget.docs['numlikes']}"),
        ),
        Positioned(
          top: -10,
          left: 10,
          child: GestureDetector(
            onLongPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyLikes(docs: widget.docs)));
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return Text("찜목록");

              // );
            },
            child: const Icon(FontAwesomeIcons.tag),
          ),
        ),
      ],
    );
  }
}

class MyLikes extends StatefulWidget {
  const MyLikes({super.key, required this.docs});

  final Map<String, dynamic> docs;

  @override
  State<MyLikes> createState() => _MyLikesState();
}

class _MyLikesState extends State<MyLikes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("${widget.docs['postId']}")),
    );
  }
}
