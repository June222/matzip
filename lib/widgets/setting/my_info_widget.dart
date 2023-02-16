import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyInfoWidget extends StatelessWidget {
  const MyInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final firebase = FirebaseFirestore.instance;
    final size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream:
          firebase.collection('users').doc(auth.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        var docs = snapshot.data;
        if (docs == null) {
          return SizedBox(
            height: size.height / 5,
            width: size.width / 2,
            child: const Text("로그인을 해주세요!"),
          );
        } else {
          return Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(docs['photoURL']),
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Text(
                    "${docs['username']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text("${docs['fullname']}"),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
