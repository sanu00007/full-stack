import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final datePublished;
  final String postUrl;
  final String ProfImage;
  final likes;
  const Post({
    required this.description,
    required this.uid,
    required this.postId,
    required this.username,
    required this.datePublished,
    required this.postUrl,
    required this.ProfImage,
    required this.likes,
  });
  Map<String, dynamic> toJson() => {
        'descrription': description,
        'uid': uid,
        "postId": postId,
        'username': username,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "ProfImage": ProfImage,
        "likes": likes,
      };
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      description: snapshot['description'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      username: snapshot['username'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      ProfImage: snapshot['ProfImage'],
      likes: snapshot['likes'],
    );
  }
}
