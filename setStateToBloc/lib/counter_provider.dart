import 'package:flutter/cupertino.dart';
import 'package:why_bloc/counter.dart';

class CounterProvider extends InheritedWidget {
  final Counter counter;
  final Widget child;

  CounterProvider({this.counter, this.child})
      : super(
          child: child,
        );

  static CounterProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CounterProvider>();

  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return counter != oldWidget.counter;
  }
}
