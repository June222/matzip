import 'package:busan_univ_matzip/model/user_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserFBProvider with ChangeNotifier {
  late UserFB _userFB = UserFB(emailVerified: false, uid: "123");
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  UserFB get getUser => _userFB;

  Future<void> refreshUser() async {
    DocumentSnapshot documentSnapshot =
        await firebase.collection('users').doc(user!.uid).get();
    UserFB userFB = UserFB.fromSnap(documentSnapshot);
    _userFB = userFB;
    notifyListeners();
  }
}
