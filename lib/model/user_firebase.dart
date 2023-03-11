import 'package:cloud_firestore/cloud_firestore.dart';

class UserFB {
  final String uid;
  final bool emailVerified;
  String? username;
  String? photoURL;

  UserFB({
    required this.uid,
    required this.emailVerified,
    this.photoURL,
    this.username,
  });

  static UserFB fromSnap(DocumentSnapshot documentSnapshot) {
    var snapShot = documentSnapshot.data() as Map<String, dynamic>;

    return UserFB(
      photoURL: snapShot["photoURL"],
      username: snapShot["username"],
      uid: snapShot["uid"],
      emailVerified: snapShot["emailVerified"],
    );
  }

  Map<String, dynamic> toJson() => {
        "photoURL": photoURL,
        "username": username,
        "uid": uid,
        "emailVerified": emailVerified,
      };
}
