import 'package:equatable/equatable.dart';

class LogInClicedEvent extends Equatable {
  final String username;
  final String password;

  LogInClicedEvent(
    this.username,
    this.password,
  );

  @override
  List<Object> get props => [
        username,
        password,
      ];
}
