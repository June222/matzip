import 'package:busan_univ_matzip/model/user.dart';
import 'package:busan_univ_matzip/resources/firestore_method.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LikeWidget extends StatelessWidget {
  const LikeWidget({
    super.key,
    required this.currentUser,
    required this.docs,
  });

  final Map<String, dynamic> docs;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    List<dynamic> likeList = docs['likes'];
    bool alreadyLiked = likeList.contains(currentUser.uid);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
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
        ),
        Positioned(
          bottom: 0,
          right: 5,
          child: Text("${docs['numlikes']}"),
        ),
        Positioned(
          top: -10,
          left: 10,
          child: GestureDetector(
            onLongPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyLikes()));
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return const Text("tagyoung");
              //   },
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
  const MyLikes({super.key});

  @override
  State<MyLikes> createState() => _MyLikesState();
}

class _MyLikesState extends State<MyLikes> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("{docs['postId']}")),
    );
  }
}
