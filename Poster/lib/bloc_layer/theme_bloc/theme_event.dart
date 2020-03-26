import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => null;
}

class ThemeChanged extends ThemeEvent {
  final bool enableDark;

  ThemeChanged({@required this.enableDark});

  @override
  List<Object> get props => [enableDark];
}
