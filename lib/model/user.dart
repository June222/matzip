import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String password;
  final String username;
  final String fullname;
  final String photoURL;
  final List<String> pids;

  User({
    required this.photoURL,
    required this.email,
    required this.uid,
    required this.username,
    required this.password,
    required this.fullname,
    required this.pids,
  });

  static User fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;

    return User(
      email: snapshot["email"],
      uid: snapshot['uid'],
      username: snapshot["username"],
      password: snapshot["password"],
      fullname: snapshot["fullname"],
      photoURL: snapshot['photoURL'],
      pids: snapshot['pids'],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        'uid': uid,
        "username": username,
        "password": password,
        "fullname": fullname,
        'photoURL': photoURL,
        'pids': pids,
      };
}
