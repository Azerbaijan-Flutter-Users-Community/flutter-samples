import 'package:bloc/bloc.dart';

enum CounterEvent {
  Increment, Decrement,
}

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch(event){ 
      case CounterEvent.Increment:
      yield currentState + 1;
      break;
      case CounterEvent.Decrement:
      yield currentState - 1;
      break;
    }
  }
}