import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/bloc_layer/theme_bloc/theme_event.dart';
import 'package:poster/bloc_layer/theme_bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(
        brightness: Brightness.light,
      );

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeChanged) {
      yield ThemeState(
          brightness: event.enableDark ? Brightness.dark : Brightness.light);
    }
  }
}
