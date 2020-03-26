import 'package:flutter/foundation.dart';
import 'package:learn_structure/core/models/post.dart';
import 'package:learn_structure/core/services/api.dart';
import 'package:learn_structure/core/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  Api _api;

  HomeViewModel({
    @required Api api,
  }): _api = api;

  List<Post> posts;

  Future getUserPosts(int userId) async {
    setBusy(true);
    posts = await _api.getUserPosts(userId);
    setBusy(false);
  }
}