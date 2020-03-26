import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class InitializedLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class SuccessLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class ErrorLoginState extends LoginState {
  final String errorMessage;

  ErrorLoginState(this.errorMessage);

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
