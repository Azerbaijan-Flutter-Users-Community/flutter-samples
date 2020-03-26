import 'dart:async';

import 'package:learn_structure/core/models/user.dart';
import 'package:learn_structure/core/services/api.dart';

class AuthenticationService {
    final Api _api;
    
  AuthenticationService({Api api}) : _api = api;

  StreamController<User> _userController = StreamController<User>();

  Stream<User> get user => _userController.stream;

  Future<bool> login(int userId) async {
    var fetchedUser = await _api.getUserProfile(userId);
    var hasUser = fetchedUser.id != null;
    if(hasUser){
      _userController.add(fetchedUser);
    }

    return hasUser;
  } 
}