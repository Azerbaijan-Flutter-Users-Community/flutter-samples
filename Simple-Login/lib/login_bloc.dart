import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_test/login_event.dart';
import 'package:login_test/login_state.dart';

class LoginBloc extends Bloc<LogInClicedEvent, LoginState> with Validators {
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  Stream<String> get username =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Function(String) get usernameChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  @override
  LoginState get initialState => InitializedLoginState();

  @override
  Stream<LoginState> mapEventToState(LogInClicedEvent event) async* {
    if (event is LogInClicedEvent) {
      yield LoadingLoginState();
      await Future.delayed(
        Duration(seconds: 2),
      );
      if (event.username == 'Kanan' && event.password == 'Kanan12345') {
        yield SuccessLoginState();
      } else {
        yield ErrorLoginState('Check username and password');
      }
    }
  }

  @override
  Future<void> close() async {
    await _emailController?.close();
    await _passwordController?.close();
    return super.close();
  }
}

mixin Validators {
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    print('email validator');
    if (username.length >= 5) {
      sink.add(username);
    } else {
      sink.addError('Username is not valid!');
    }
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 8) {
      sink.add(password);
    } else {
      sink.addError('Password length shoud be greater than 8!');
    }
  });
}
