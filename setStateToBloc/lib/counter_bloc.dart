import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { Increment }

class CounterBloc extends Bloc<CounterEvent, int> {
  var _count = 0;

  @override
  int get initialState => _count;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event == CounterEvent.Increment) {
      print('running...');
      yield ++_count;
    }
  }
}
