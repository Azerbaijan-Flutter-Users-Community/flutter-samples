import 'package:flutter/material.dart';
import 'package:learn_structure/core/models/post.dart';

class PostView extends StatelessWidget {
  final Post post;

  PostView({this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post View'),
      ),
      body: Center(
        child: Text('Post View'),
      ),
    );
  }
}
