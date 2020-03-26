import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/bloc_layer/theme_bloc/theme_bloc.dart';
import 'package:poster/bloc_layer/theme_bloc/theme_event.dart';
import 'package:poster/bloc_layer/theme_bloc/theme_state.dart';

class ThemeChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Switch(
          onChanged: (value) => BlocProvider.of<ThemeBloc>(context).add(
            ThemeChanged(enableDark: value),
          ),
          value: state.brightness == Brightness.dark ? true : false,
        );
      },
    );
  }
}
