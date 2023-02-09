import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String discription;
  final String username;
  final String uid;
  final String postId;
  final List likes;
  final String postURL;
  final String profileImage;

  Post({
    required this.profileImage,
    required this.uid,
    required this.discription,
    required this.username,
    required this.postId,
    required this.likes,
    required this.postURL,
  });

  static Post fromSnap(DocumentSnapshot doc) {
    var snapShot = doc.data() as Map<String, dynamic>;

    return Post(
      discription: snapShot['discription'],
      uid: snapShot['uid'],
      username: snapShot['username'],
      postId: snapShot['postId'],
      postURL: snapShot['postURL'],
      profileImage: snapShot['profileImage'],
      likes: snapShot['likes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'discription': discription,
        'username': username,
        'postId': postId,
        'postURL': postURL,
        'likes': likes,
        'uid': uid,
        'profileImage': profileImage,
        // 'datePublished': datePublished,
      };
}
