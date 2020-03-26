import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_structure/core/models/comment.dart';
import 'package:learn_structure/core/models/post.dart';
import 'package:learn_structure/core/models/user.dart';

class Api {
  static const base_url = 'https://jsonplaceholder.typicode.com';

  var client = http.Client();

  Future<User> getUserProfile(int userId) async {
    var response = await client.get('$base_url/users/$userId');
    return User.fromJson(json.decode(response.body));
  }

  Future<List<Post>> getUserPosts(int userId) async {
    var posts = List<Post>();

    var response = await client.get('$base_url/posts?userId=$userId');
    var parsedPosts = json.decode(response.body) as List<dynamic>;
    for(var post in parsedPosts) {
      posts.add(Post.fromJson(post));
    }

    return posts;
  }
}
