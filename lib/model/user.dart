import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photourl;
  final String username;
  final String bio;
  final List follower;
  final List following;
  const User({
    required this.email,
    required this.uid,
    required this.photourl,
    required this.username,
    required this.bio,
    required this.follower,
    required this.following,
  });
  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        "bio": bio,
        "followers": [],
        "following": [],
        "photourl": photourl,
      };
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photourl: snapshot['photourl'],
      bio: snapshot['bio'],
      follower: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
