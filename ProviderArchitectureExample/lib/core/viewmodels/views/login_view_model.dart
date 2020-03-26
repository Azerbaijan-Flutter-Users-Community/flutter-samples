import 'package:learn_structure/core/services/authentication_service.dart';
import 'package:learn_structure/core/viewmodels/base_model.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends BaseModel {
  AuthenticationService _authecticationService;

  LoginViewModel({@required AuthenticationService authecticationService})
      : _authecticationService = authecticationService;

  Future<bool> login(String userIdText) async {
    setBusy(true);
    var userId = int.tryParse(userIdText);
    var success = await _authecticationService.login(userId);
    setBusy(false);
    return success;
  }    
}
