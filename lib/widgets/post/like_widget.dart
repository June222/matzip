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
          top: -20,
          left: 10,
          child: GestureDetector(
            // onTap: () {
            //   showBottomSheet(
            //     context: context,
            //     builder: (context) => const Text("hi2"),
            //   );
            //   showDialog(
            //     context: context,
            //     builder: (context) => const Text("hi"),
            //   );
            // },
            onLongPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyLikes(),
                ),
              );
            },
            child: const Icon(
              FontAwesomeIcons.tag,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

class MyLikes extends StatelessWidget {
  const MyLikes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Mylikes")),
    );
  }
}
