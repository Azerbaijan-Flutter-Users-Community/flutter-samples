import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:why_bloc/counter_bloc.dart';

class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            return Text(
              '$state',
              style: TextStyle(
                fontSize: 40,
              ),
            );
          },
        ),
      ),
    );
  }
}
