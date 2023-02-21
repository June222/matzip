import 'dart:typed_data';

import 'package:busan_univ_matzip/resources/storage_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:busan_univ_matzip/model/user.dart' as model;
import 'package:busan_univ_matzip/constants/res.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get authState => _auth.authStateChanges();
//get snapshot of current user data
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(currentUser.uid).get();

    return model.User.fromSnap(snapshot);
  }

  Future<String> signUpUser({
    // e-mail,fullname,username,password
    required String email,
    required String fullname,
    required String username,
    required String password,
    required Uint8List profilePicture,
  }) async {
    String res = Res.errMsg;
    try {
      if (email.isNotEmpty ||
          fullname.isNotEmpty ||
          username.isNotEmpty ||
          password.isNotEmpty) {
        //registre user
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        //register user's profile photo

        String photoURL = await StorageMethod()
            .uploadImageToStorage('ProfilePics', profilePicture, false);

        //upload userdata to database

        model.User user = model.User(
          email: email,
          uid: credential.user!.uid,
          username: username,
          password: password,
          fullname: fullname,
          photoURL: photoURL,
        );
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());

        res = Res.successMsg;
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//login user
  Future<String> signinUser(
      // email과 password가 비어있지 않으면
      {required String email,
      required String password}) async {
    String res = Res.errMsg;
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            // 여기서 확인해줌
            email: email,
            password: password);
        res = Res.successMsg;
      } else {
        res = Res.emptyFieldMsg;
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
