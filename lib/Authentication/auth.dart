import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../Models/user_model.dart';
import '../constants/constants.dart';

class Auth {
  final UserModel userModel = UserModel();
  String? downLoadLink;

  Future loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print('Running TRY block of EMAIL sign in ');
      }
      if (FirebaseAuth.instance.currentUser != null) {
        var uid = FirebaseAuth.instance.currentUser!.uid.toString();
        if (kDebugMode) {
          print(uid);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Running catch block of EMAIL sign in ');
        print('Error in EMAIL sign in:${e.message} ');
      }
    }
  }

  Future logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (kDebugMode) {
        print('RUNNING TRY BLOCK OF LOGOUT');
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('RUNNING CATCH BLOCK OF LOGOUT ${e.message}');
      }
    }
  }
}
