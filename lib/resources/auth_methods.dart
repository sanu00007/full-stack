import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/model/user.dart' as model;
import 'package:instagram/resources/stoage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('user').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        print("Id:" + cred.user!.uid);

        String photourl = await StorageMethods()
            .uploadImageToString("profile pics", file, false);
        model.User user = model.User(
            email: email,
            uid: cred.user!.uid,
            photourl: photourl,
            username: username,
            bio: bio,
            follower: [],
            following: []);
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        res = "The email is badly formated";
      } else if (err.code == "weak-password") {
        res = "password should be at least 6 characters";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //login;authetication
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "user not found";
      } else if (e.code == "wrong-password") {
        res = "please enter correct password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
