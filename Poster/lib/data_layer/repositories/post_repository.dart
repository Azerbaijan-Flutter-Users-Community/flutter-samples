import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:poster/data_layer/models/Post.dart';

class FirebasePostRepository implements PostRepository {
  final postCollection = Firestore.instance.collection('posts');
  List<Post> userPosts = [];

  @override
  Future<void> addNewPost(Post post) async {
    try {
      var currentPost = post;
      print(post.id);
      final docRef = postCollection.document();
      await docRef.setData(post.toDocument());
      currentPost.id = docRef.documentID;
      userPosts.add(currentPost);
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<void> deletePost(Post post) {
    // TODO: implement deletePost
    return null;
  }

  @override
  Stream<List<Post>> posts() {
    // TODO: implement posts
    return null;
  }

  @override
  Future<void> updatePost(Post post) {
    // TODO: implement updatePost
    return null;
  }
}

abstract class PostRepository {
  Future<void> addNewPost(Post post);

  Future<void> deletePost(Post post);

  Stream<List<Post>> posts();

  Future<void> updatePost(Post post);
}
