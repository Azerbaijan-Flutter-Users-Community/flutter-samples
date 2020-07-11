import 'package:cubit/cubit.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void incrementCount() => emit(state + 1);

  void decrementCount() => emit(state - 1);
}
