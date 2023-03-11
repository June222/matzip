import 'dart:typed_data';

import 'package:busan_univ_matzip/constants/res.dart';
import 'package:busan_univ_matzip/model/posts.dart';
import 'package:busan_univ_matzip/resources/storage_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethod {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String menu,
    String discription,
    String price,
    String uid,
    Uint8List? file,
    String username,
    String profileImage,
  ) async {
    String res = Res.errMsg;
    try {
      //storing post image in firebasestorage
      String photoUrl =
          await StorageMethod().uploadImageToStorage('posts', file!, true);

      //generating unique postid using uuid
      String postId = const Uuid().v1();

      Post post = Post(
          menu: menu,
          discription: discription,
          price: price,
          uid: uid,
          username: username,
          postId: postId,
          postURL: photoUrl,
          profileImage: profileImage,
          timeStamp: Timestamp.now(),
          likes: []);
      //storing to firebasefirestore
      firebaseFirestore.collection('posts').doc(postId).set(post.toJson());
      res = Res.successMsg;
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //add uid into likes list of inject from likes list
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await firebaseFirestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
          'numlikes': likes.length - 1,
        });
      } else {
        await firebaseFirestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
          'numlikes': likes.length + 1,
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  //
  Future<String> postComment(
      String postId, String comment, String uid, String username) async {
    String res = Res.errMsg;
    try {
      if (comment.isNotEmpty) {
        String commentId = const Uuid().v1();
        await firebaseFirestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'postId': postId,
          'commentId': commentId,
          'username': username,
          'uid': uid,
          'comment': comment,
          'likes': [],
        });
        res = Res.postSucsMsg;
      } else {
        res = Res.emptyCommentMsg;
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likeComment(
      String postId, String commentId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await firebaseFirestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await firebaseFirestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> deletePost(String postId) async {
    String res = Res.errMsg;
    try {
      await firebaseFirestore.collection('posts').doc(postId).delete();
      res = 'deleted';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
