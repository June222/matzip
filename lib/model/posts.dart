import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String menu;
  final String discription;
  final String price;
  final String username;
  final String uid;
  final String postId;
  final List likes;
  final String postURL;
  final String profileImage;
  final Timestamp timeStamp;

  Post({
    required this.menu,
    required this.price,
    required this.profileImage,
    required this.uid,
    required this.discription,
    required this.username,
    required this.postId,
    required this.likes,
    required this.postURL,
    required this.timeStamp,
  });

  static Post fromSnap(DocumentSnapshot doc) {
    var snapShot = doc.data() as Map<String, dynamic>;

    return Post(
        menu: snapShot['menu'],
        discription: snapShot['discription'],
        price: snapShot['price'],
        uid: snapShot['uid'],
        username: snapShot['username'],
        postId: snapShot['postId'],
        postURL: snapShot['postURL'],
        profileImage: snapShot['profileImage'],
        likes: snapShot['likes'],
        timeStamp: snapShot['timeStamp']);
  }

  Map<String, dynamic> toJson() => {
        'menu': menu,
        'discription': discription,
        'price': price,
        'username': username,
        'postId': postId,
        'postURL': postURL,
        'likes': likes,
        'uid': uid,
        'profileImage': profileImage,
        'timeStamp': timeStamp,
        // 'datePublished': datePublished,
      };
}
