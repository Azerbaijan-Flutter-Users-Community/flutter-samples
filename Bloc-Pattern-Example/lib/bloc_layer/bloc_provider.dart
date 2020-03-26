import 'package:flutter/material.dart';
import 'package:learn_bloc_pattern/bloc_layer/bloc.dart';
import 'package:meta/meta.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  static T of<T extends Bloc>(BuildContext context) {
    final type = _providerType<BlocProvider<T>>();
    final BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _providerType<T>() => T;

  @override
  _BlocProviderState createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
