import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
class ThemeState extends Equatable {
  final Brightness brightness;

  ThemeState({@required this.brightness});

  @override
  List<Object> get props => [brightness];
}
